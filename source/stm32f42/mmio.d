// Copyright © 2017 Michael V. Franklin
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

/***************************************************************************
 Implementation of memory-mapped I/O registers in D.  The idea for this
 came from a paper by Ken Smith titled "C++ Hardware Register Access Redux".
 At the time of this writing, a link to the could be found here:
 http://yogiken.files.wordpress.com/2010/02/c-register-access.pdf

 The idea, is that all of this logic will actually be evaluated at compile
 time and each BitField access will only cost a few instructions of assembly.

 Right now, this will probably only work for 32-bit platforms. I'd like to
 modify this so it is portable to even 16, and 8 bit platforms, but one step
 at a time.

 * It enforces word, half-word, and byte access policy at compile time.
   See Access.
 * It enforces mutability constraints such as read, write, readwrite, etc...
   at compile time. See Mutability.
 * It optimizes byte-aligned and half-word aligned bitfields generating atomic
   read/write operations resulting in smaller code size and faster performance.
 * It optimizes bitfieds of a single bit, via bit-banding, generating atomic
   read/write operations resulting in smaller code size and faster performance.
 * It can combine multiple bitfield accesses within a single register into one
   read-modify-write operation resulting in smaller code size and faster
   performance.
 * It enables intuitive and obvious register modeling that directly cross-references
   back to register specifications.

 Example:
 --------------------
 // A peripherals's register specification can be modeled as follows
 // TODO: make a more meaningful example
final abstract class MyPeripheral : Peripheral!(0x2000_1000)
{
    final abstract class MyRegister0 : Register!(0x0000, Access.Word)
    {
        alias EntireRegister = BitField!(31, 0, Mutability.rw);
        alias Bits31To17     = BitField!(17, 2, Mutability.rw);
        alias Bits15to8      = BitField!(15, 8, Mutability.rw);
        alias Bits1to0       = BitField!( 1, 0, Mutability.rw);
        alias Bit1           = Bit!(1, Mutability.rw);
        alias Bit0           = Bit!(0, Mutability.rw);
    }

    final abstract class MyRegister1 : Register!(0x0004, Access.Word)
    {
        alias EntireRegister = BitField!(31, 0, Mutability.rw);
        alias Bits31To17     = BitField!(17, 2, Mutability.rw);
        alias Bits15to8      = BitField!(15, 8, Mutability.rw);
        alias Bits1to0       = BitField!( 1, 0, Mutability.rw);
        alias Bit1           = Bit!(1, Mutability.rw);
        alias Bit0           = Bit!(0, Mutability.rw);
    }
}
 --------------------
*/
module stm32f42.mmio;

import attributes;

private alias Address    = uint;
private alias BitIndex   = uint;
private alias HalfWord   = ushort;
private alias Word       = uint;

// These are the bit band address that can be translated to bit-band addresses
// that can address a single bit
private immutable Address PeripheralRegionStart        = 0x4000_0000u;
private immutable size_t  PeripheralRegionSize         = 0x000F_FFFFu;
private immutable Address PeripheralRegionEnd          = PeripheralRegionStart + PeripheralRegionSize - 1;
private immutable Address PeripheralBitBandRegionStart = 0x4200_0000u;

private immutable Address SRAMRegionStart              = 0x2000_0000u;
private immutable size_t  SRAMRegionSize               = 0x000F_FFFFu;
private immutable Address SRAMRegionEnd                = SRAMRegionStart + SRAMRegionSize - 1;
private immutable Address SRAMBitBandRegionStart       = 0x2200_0000u;

/****************************************************************************
   Template wrapping volatileLoad intrinsic casting to basic type based on
   size.
*/
private T volatileLoad(T)(T* a) @trusted nothrow
{
    static import core.bitop;
    static if (T.sizeof == 1)
    {
        return cast(T)core.bitop.volatileLoad(cast(ubyte*)a);
    }
    else static if (T.sizeof == 2)
    {
        return cast(T)core.bitop.volatileLoad(cast(ushort*)a);
    }
    else static if (T.sizeof == 4)
    {
        return cast(T)core.bitop.volatileLoad(cast(uint*)a);
    }
    else
    {
        static assert(false, "Size not supported.");
    }
}

/****************************************************************************
   Template wrapping volatileStore intrinsic casting to basic type based on
   size.
*/
private void volatileStore(T)(T* a, in T v) @trusted nothrow
{
    static import core.bitop;
    static if (T.sizeof == 1)
    {
        core.bitop.volatileStore(cast(ubyte*)a, cast(ubyte)v);
    }
    else static if (T.sizeof == 2)
    {
        core.bitop.volatileStore(cast(ushort*)a, cast(ushort)v);
    }
    else static if (T.sizeof == 4)
    {
        core.bitop.volatileStore(cast(uint*)a, cast(uint)v);
    }
    else
    {
        static assert(false, "Size not supported");
    }
}

/****************************************************************************
   Defines the width of access to the fields of a register.  For example, some
   registers can only be accessed by 32-bit words.
*/
enum Access
{
    /****************************************************************************
     Register can only be accessed as a 32-bit word
    */
    Word = 4,

    /****************************************************************************
     Register can be accessed as individual bytes or 32-bit words
    */
    Byte_Word = 1 | Word,

    /****************************************************************************
     Register can be accessed as 16-bit halfwords or 32-bit words
    */
    HalfWord_Word = 2 | Word,

    /****************************************************************************
     Register can be accessed as individual bytes, 16-bit halfwords, or 32-Bit
     words
    */
    Byte_HalfWord_Word = 1 | 2 | Word
}

/****************************************************************************
   Mutability (Read/Write policy) as specified in the datasheet
   see pp. 57 of the STM32 reference manual
*/
enum Mutability
{
    /****************************************************************************
     Software can read and write to these bits.
    */
    rw,

    /****************************************************************************
      Software can only read these bits
    */
    r,

    /****************************************************************************
     Software can only write to this bit. Reading the bit returns the reset
     value.
    */
    w,

    /****************************************************************************
     Software can read as well as clear this bit by writing 1. Writing '0' has
     no effect on the bit value.
    */
    rc_w1,

    /****************************************************************************
     Software can read as well as clear this bit by writing 0. Writing '1' has
     no effect on the bit value.
    */
    rc_w0,

    /****************************************************************************
     Software can read this bit. Reading this bit automatically clears it to '0'.
     Writing '0' has no effect on the bit value
    */
    rc_r,

    /****************************************************************************
     Software can read as well as set this bit. Writing '0' has no effect on the
     bit value.
    */
    rs,

    /****************************************************************************
     Software can read this bit. Writing '0' or '1' triggers an event but has no
     effect on the bit value.
    */
    rt_w
}

/****************************************************************************
    Defines how the bitfield is aligned within a register
*/
private enum Alignment
{
    /****************************************************************************
     Bitfield is not aligned on any bondary
    */
    None = 0,

    /****************************************************************************
     Bitfield is aligned on an 8-bit byte boundary
    */
    Byte = 1,

    /****************************************************************************
     Bitfield is aligned on a 16-bit boundary
    */
    HalfWord = 2
}

/***********************************************************************
    Whether or not the mutability policy allows for reading the bit/
    bitfield's value
*/
static auto canRead(immutable Mutability m) @safe pure nothrow
{
    return m == Mutability.r     || m == Mutability.rw
        || m == Mutability.rt_w  || m == Mutability.rs
        || m == Mutability.rc_r  || m == Mutability.rc_w0
        || m == Mutability.rc_w1;
}

/***********************************************************************
    Whether or not the mutability policy allows for writing the bit/
    bitfield's value
*/
static auto canWrite(immutable Mutability m) @safe pure nothrow
{
    return m == Mutability.w     || m == Mutability.rw
        || m == Mutability.rc_w0 || m == Mutability.rc_w1
        || m == Mutability.rs;
}

 /***********************************************************************
    Whether or not the mutability policy allows for only setting or
    clearing a bit
*/
static auto canOnlySetOrClear(immutable Mutability m) @safe pure nothrow
{
    return m == Mutability.rc_w0 || m == Mutability.rc_w1
        || m == Mutability.rs;
}

 /***********************************************************************
    Whether or not the mutability policy applies only to single bits
*/
static auto isForBitsOnly(immutable Mutability m) @safe pure nothrow
{
    return m == Mutability.rc_w0 || m == Mutability.rc_w1
        || m == Mutability.rs    || m == Mutability.rc_r
        || m == Mutability.rt_w;
}

/***********************************************************************
 Provides information about a bit field given the specified bit indices
*/
mixin template BitFieldDimensions(BitIndex bitIndex0, BitIndex bitIndex1)
{
    /***************************************************************
        Index of this BitField's most significant Bit
    */
    static immutable auto mostSignificantBitIndex = bitIndex0 >= bitIndex1 ? bitIndex0 : bitIndex1;

    /***********************************************************************
        Index of this BitField's least significant Bit
    */
    static immutable auto leastSignificantBitIndex = bitIndex0 <= bitIndex1 ? bitIndex0 : bitIndex1;

    /***********************************************************************
        Total number of bits in this BitField
    */
    static immutable auto numberOfBits = mostSignificantBitIndex - leastSignificantBitIndex + 1;

    /***************************************************************
      Determines if bitIndex is a valid index for this register

      Returns: true if the bitIndex is valid, false if not
    */
    private static auto isValidBitIndex(immutable BitIndex bitIndex) @safe pure
    {
        return bitIndex >= 0 && bitIndex < (Word.sizeof * 8);
    }

    /***********************************************************************
        Gets a bit-mask for this bit field for masking just this BitField out
        of the register.
    */
    private static immutable auto bitMask = numberOfBits >= 32 
        ? uint.max  // if numberOfBits >=32, the left shift below will fail to compile
        : ((1 << numberOfBits) - 1) << leastSignificantBitIndex;

    /***********************************************************************
      Takes a value and moves its bits to align with this bitfields position
      in the register.
    */
    private static Word maskValue(T)(T value) @safe pure nothrow
    {
        return (value << leastSignificantBitIndex) & bitMask;
    }

    /***********************************************************************
      Whether or not this bitfield is aligned to an even multiple of bytes
    */
    private static Alignment alignment() @property @safe pure nothrow
    {
        // If half-word aligned
        static if (((mostSignificantBitIndex + 1) % 16) == 0 && (leastSignificantBitIndex % 16) == 0)
        {
            return Alignment.HalfWord;
        }
        // If byte aligned
        else if (((mostSignificantBitIndex + 1) % 8) == 0 && (leastSignificantBitIndex % 8) == 0)
        {
            return Alignment.Byte;
        }
        // if not aligned
        else
        {
            return Alignment.None;
        }
    }

    static if (alignment == Alignment.Byte)
    {
        /***********************************************************************
          Gets the address of this bitfield at its aligned byte's location
        */
        private static immutable Address byteAlignedAddress = address + (leastSignificantBitIndex / 8u);
    }

    static if (alignment == Alignment.HalfWord)
    {
        /***********************************************************************
          Gets the address of this bitfield at its aligned half-word's location
        */
        private static immutable Address halfWordAlignedAddress = address + (leastSignificantBitIndex / 16u);
    }

    // The bitBandAddress property should only be generated if the address
    // of this register is aliased to a bit-banded region
    static if(isBitBandable)
    {
        private static Address bitBandAddress() @property @safe pure nothrow
        {
            static if (address >= PeripheralRegionStart && address <= PeripheralRegionEnd)
            {
                return PeripheralBitBandRegionStart + ((address - PeripheralRegionStart) * 32u) + (leastSignificantBitIndex * 4u);
            }
            else static if (address >= SRAMRegionStart && address <= SRAMRegionEnd)
            {
                return SRAMBitBandRegionStart + ((address - SRAMRegionStart) * 32u) + (leastSignificantBitIndex * 4u);
            }
            else
            {
                static assert(false, "Address not aliased to bit-banded region");
            }
        }
    }
}

/***********************************************************************
 Provides access and mutability enforcement for a bitfield.
*/
mixin template BitFieldMutation(Mutability mutability, ValueType_)
{
    alias ValueType = ValueType_;

    // Sanity check: ensure bit indices are of within the size of the register
    static assert(isValidBitIndex(bitIndex0) && isValidBitIndex(bitIndex1), "Invalid bit index");

    // Ensure correct mutability for the size of the bitfield.  Some policies
    // are only relevant to single bits
    static assert(numberOfBits == 1 || !mutability.isForBitsOnly(), "Mutability is only applicable to a single bit");

    // if mutabililty policy allows for reading the bit/bitfield's value
    static if (mutability.canRead())
    {
        /***********************************************************************
            Get this BitField's value
        */
        @inline pragma(inline, true) static ValueType value() @property @trusted nothrow
        {
            // If only a single bit, use bit banding
            static if (numberOfBits == 1 && isBitBandable)
            {
                return volatileLoad(cast(ValueType*)bitBandAddress);
            }
            // if can access data with perfect halfword alignment
            else static if (alignment == Alignment.HalfWord
                && (access == Access.Byte_HalfWord_Word || access == Access.HalfWord_Word))
            {
                return volatileLoad(cast(ValueType*)halfWordAlignedAddress);
            }
            // if can access data with perfect byte alignment
            else static if (alignment == Alignment.Byte
                && (access == Access.Byte_HalfWord_Word || access == Access.Byte_Word))
            {
                return volatileLoad(cast(ValueType*)byteAlignedAddress);
            }
            // catch-all.  No optimizations possible, so read and mask and shift
            else
            {
                return cast(ValueType)((volatileLoad(cast(Word*)address) & bitMask) >> leastSignificantBitIndex);
            }
        }
    }

    // If mutability allows setting the bit/bitfield in some way
    static if (mutability.canWrite)
    {
        // Can modify the bit/bitfield's value, but only with a set or clear
        static if (mutability.canOnlySetOrClear)
        {
            static if (mutability == Mutability.rc_w0)
            {
                /***********************************************************************
                    Clears bit by writing a '0'
                */
                @inline pragma(inline, true) static void clear() @safe
                {
                    value = false;
                }
            }
            else static if (mutability == Mutability.rc_w1)
            {
                /***********************************************************************
                    Clears bit by writing a '1'
                */
                @inline pragma(inline, true) static void clear() @safe
                {
                    value = true;
                }
            }
            else static if (mutability == Mutability.rs)
            {
                /***********************************************************************
                    Sets bit by writing a '1'
                */
                @inline pragma(inline, true) static void set() @safe
                {
                    value = true;
                }
            }

            // 'value' is private as it is enpsulated by the clear/set methods above
            private:
        }

        /***********************************************************************
            Set this BitField's value
        */
        @inline pragma(inline, true) static void value(immutable ValueType value_) @property @trusted nothrow
        {
            // If only a single bit, use bit banding
            static if (numberOfBits == 1 && isBitBandable)
            {
                volatileStore(cast(ValueType*)bitBandAddress, value_);
            }
            // if can access data with perfect halfword alignment
            else static if (alignment == Alignment.HalfWord 
                && (access == Access.Byte_HalfWord_Word || access == Access.HalfWord_Word))
            {
                volatileStore(cast(ValueType*)halfWordAlignedAddress, value_);
            }
            // if can access data with perfect byte alignment
            else static if (alignment == Alignment.Byte 
                && (access == Access.Byte_HalfWord_Word || access == Access.Byte_Word))
            {
                volatileStore(cast(ValueType*)byteAlignedAddress, value_);
            }
            // catch-all.  No optimizations possible, so just do read-modify-write
            else
            {
                volatileStore(cast(Word*)address, (volatileLoad(cast(Word*)address) & ~bitMask) | ((cast(Word)value_) << leastSignificantBitIndex));
            }
        }
    }

    // So we don't need to constantly type ".value" every time we want
    // to read/write a bitfield
    static alias value this;
}

/***********************************************************************
 Provides access to a limited range of bits in a register.  This
 version automatically determines the return type based on the size
 of the bitfield.
*/
mixin template BitFieldImplementation(BitIndex bitIndex0, BitIndex bitIndex1, Mutability mutability)
{
    mixin BitFieldDimensions!(bitIndex0, bitIndex1);

    //TODO: do a test to determine if limiting return type to something less
    // than the natural word size results in slower code.  Perhaps it's better
    // to simply make everything default to Word

    // determine the return type based on the number of bits
    static if (numberOfBits <= 1)
    {
        alias ValueType = bool;
    }
    else static if (numberOfBits <= (ubyte.sizeof * 8))
    {
        alias ValueType = ubyte;
    }
    else static if (numberOfBits <= (HalfWord.sizeof * 8))
    {
        alias ValueType = HalfWord;
    }
    else static if (numberOfBits <= (Word.sizeof * 8))
    {
        alias ValueType = Word;
    }

    mixin BitFieldMutation!(mutability, ValueType);
}

/***********************************************************************
 Provides access to a limited range of bits in a register. User
 must specify the return type.
*/
mixin template BitFieldImplementation(BitIndex bitIndex0, BitIndex bitIndex1, Mutability mutability, ValueType)
{
    mixin BitFieldDimensions!(bitIndex0, bitIndex1);
    mixin BitFieldMutation!(mutability, ValueType);
}

/***********************************************************************
 For modeling a peripheral register bank
*/
abstract class Peripheral(Bus, Address peripheralOffset)
{
    // this alias is used by some of the child mixins
    // May be able to use __traits(parent) in children if https://issues.dlang.org/show_bug.cgi?id=12496 is ever fixed.
    private static immutable Address peripheralAddress = Bus.address + peripheralOffset;

    /***********************************************************************
        Gets this peripheral's address as specified in the datasheet
    */
    static immutable auto address = Bus.address + peripheralOffset;

    /***********************************************************************
      A register for this peripheral
    */
    abstract class Register(ptrdiff_t addressOffset, Access access_ = Access.Byte_HalfWord_Word)
    {
        /***********************************************************************
          Gets this register's address as specified in the datasheet
        */
        static immutable auto address = peripheralAddress + addressOffset;

        /***********************************************************************
          Whether or not the address has a bit-banded alias
        */
        static immutable auto isBitBandable =
            (address >= PeripheralRegionStart && address <= PeripheralRegionEnd)
            || (address >= SRAMRegionStart && address <= SRAMRegionEnd);


        /***********************************************************************
          Gets the data width(byte, half-word, word) access policy for this
          register.
        */
        static immutable auto access = access_;

        /***********************************************************************
          Gets all bits in the register as a single value.  It's only exposed
          privately to prevent circumventing the access mutability.
        */
        private static auto value() @property @trusted nothrow
        {
            return volatileLoad(cast(Word*)address);
        }

        /***********************************************************************
          Sets all bits in the register as a single value.  It's only exposed
          privately to prevent circumventing the access mutability.
        */
        private static void value(immutable Word value) @property @trusted nothrow
        {
            volatileStore(cast(Word*)address, value);
        }

        /***********************************************************************
          Recursive template to combine values of each bitfield passed to the
          setValue function
        */
        @inline pragma(inline, true) private static Word combineValues(T...)() @safe nothrow
        {
            static if (T.length > 0)
            {
                //TODO: ensure T[0] is a child of this register
                // Currently doesn't work due to https://issues.dlang.org/show_bug.cgi?id=12496
                //static assert(__traits(isSame, __traits(parent, T[0]), __traits(parent, value)), "Bitfield is not part of this register");

                //Ensure value assignment is legal
                // Need to wrap assignment expression in parentheses due to https://issues.dlang.org/show_bug.cgi?id=17703
                static assert(__traits(compiles, (T[0].value = T[1])), "Invalid assignment");

                // merge all specified bitFields into a single Word value and assign to this
                // register's value
                return T[0].maskValue(T[1]) | combineValues!(T[2..$])();
            }
            else
            {
                // no more values left to combine
                return 0;
            }
        }

        /***********************************************************************
          Recursive template to combine masks of each bitfield passed to the
          setValue function
        */
        @inline pragma(inline, true) private static Word combineMasks(T...)() @safe nothrow
        {
            static if (T.length > 0)
            {
                // merge all specified bitFields and assign to this register's value
                return T[0].bitMask | combineMasks!(T[2..$])();
            }
            else
            {
                // no more values left to combine
                return 0;
            }
        }

        /***********************************************************************
          Sets multiple bit fields simultaneously
        */
        @inline pragma(inline, true) static void setValue(T...)() @safe nothrow
        {
            // number of arguments must be even
            static assert(!(T.length & 1), "Wrong number of arguments");

            value = (value & ~combineMasks!(T)()) | combineValues!(T)();
        }

        /***********************************************************************
          A range of bits in the this register.  Return type is automatically
          determined.
        */
        final abstract class BitField(BitIndex bitIndex0, BitIndex bitIndex1, Mutability mutability)
        {
            mixin BitFieldImplementation!(bitIndex0, bitIndex1, mutability);
        }

        /***********************************************************************
          A range of bits in the this register.  User must specify the return
          type.
        */
        final abstract class BitField(BitIndex bitIndex0, BitIndex bitIndex1, Mutability mutability, ValueType)
        {
            mixin BitFieldImplementation!(bitIndex0, bitIndex1, mutability, ValueType);
        }

        /***********************************************************************
          A special case of BitField (a single bit).   Return type is automatically
          determined.
        */
        final abstract class Bit(BitIndex bitIndex, Mutability mutability)
        {
            mixin BitFieldImplementation!(bitIndex, bitIndex, mutability);
        }

        /***********************************************************************
          A special case of BitField (a single bit). User must specify the return
          type.
        */
        final abstract class Bit(BitIndex bitIndex, Mutability mutability, ValueType)
        {
            mixin BitFieldImplementation!(bitIndex, bitIndex, mutability, ValueType);
        }
    }
}
