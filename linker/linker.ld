/*
Copyright © 2015 Michael V. Franklin

This file is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This file is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this file.  If not, see <http://www.gnu.org/licenses/>.
*/

MEMORY
{
  CCRAM (rxw) : ORIGIN = 0x10000000, LENGTH = 64k
  SRAM (rxw) : ORIGIN = 0x20000000, LENGTH = 192k
  FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 2048k
}

_stackStart = ORIGIN(CCRAM) + LENGTH(CCRAM); /* Falling stack starts at the end of the CCM */

SECTIONS
{
    /* Not ready to implement exceptions yet, so discard this to prevent linker errors */
    /DISCARD/ :
    {
        *(.ARM.extab*)
        *(.ARM.exidx*)
    }

    /* Appears to be just meta-data, so discard it */
    /DISCARD/ :
    {
        *(.ARM.attributes*)
        *(.comment)
    }

    /* Code */
    .text :
    {
        LONG(_stackStart);                 /* Initial stack pointer */
        KEEP(*(*.ResetHandler))            /* Pointer to program's entry point */
        LONG(0)                            /* Pointer to non-maskable interrupt handler (ignore for now) */
        KEEP(*(*.HardFaultHandler))        /* Pointer to hard fault handler */
        *(.text)                           /* Our executable code */
        *(.text*)
    } > FLASH

    /*************************************************************************************
     * immutable variables initialized by the user
     * Examples:
     *           __gshared immutable uint a = 1; // initialized by user to 1
     * extern(C) __gshared immutable uint b = 2; // initialized by user to 2
     */
    .rodata : ALIGN(4)
    {
        *(.rodata)
        *(.rodata*)
    } > FLASH

    __text_end__ = .;

    /*************************************************************************************
     * __gshared variables initialized by either the user or the compiler go here.
     * Also __gshared immutables initialized by the user.
     * Examples:
     *           __gshared           uint a;     // initialized by compiler to 0
     *           __gshared           uint b = 1; // initialized by user to 1
     * extern(C) __gshared           uint c = 2; // initialized by user to 2
     * extern(C) __gshared immutable uint d = 1; // initialized by user to 1
     */
    .data : AT(__text_end__) ALIGN(4)
    {
         __data_start__ = .;
        *(.data)
        *(.data.*)
        __data_end__ = .;
    } > SRAM

    /*************************************************************************************
     * __gshared variables initialized with void or uninitialized __gshared variables
     * with C linkage go here
     * Examples:
     *           __gshared uint a = void;  // initialized to void
     * extern(C) __gshared uint b;         // uninitialied with C linkage
    */
    .bss : ALIGN(4)
    {
         __bss_start__ = .;
        *(.bss)
        *(.bss.*)
        __bss_end__ = .;
    } > SRAM
}