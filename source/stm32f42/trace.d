// Copyright © 2015 Michael V. Franklin
//
// This file is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This file is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this file.  If not, see <http://www.gnu.org/licenses/>.

module stm32f42.trace;

nothrow:

/************************************************************************************
* Initiate semihosting command
*/
private void semihostingInvoke(int command, const scope void* message) @trusted
{
  // LDC and GDC use slightly different inline assembly syntax, so we have to
  // differentiate them with D's conditional compilation feature, version.
  version(LDC)
  {
    __asm
    (
      "mov r0, $0;
       mov r1, $1;
       bkpt #0xAB",
      "r,r,~{r0},~{r1}",
      command, message
    );
  }
  else version(GNU)
  {
    asm
    {
        "mov r0, %[cmd];
         mov r1, %[msg];
         bkpt #0xAB"
        :
        : [cmd] "r" command, [msg] "r" message
        : "r0", "r1", "memory";
    }
  }
}

 @safe:

/************************************************************************************
* Create semihosting message and forward it to semihostingInvoke
*/
private void semihostingWrite(const scope void* ptr, uint length)
{
    // Create semihosting message message
    uint[3] message =
    [
        2,             // stderr
        cast(uint)ptr, // ptr to string
        length         // size of string
    ];

    // Send semihosting command
    // 0x05 = Write
    semihostingInvoke(0x05, &message[0]);
}

/************************************************************************************
* Print unsigned integer
*/
void write(uint value, uint base = 10)
{
    assert(base == 10 || base == 16, "Only base 10 and base 16 are supported");

    //Will use at most 10 digits, for a 32-bit base-10 number
    char[10] buffer;

    //Print digit to the end of the buffer starting with the
    //least significant bit first.
    auto i = buffer.length;
    do
    {
        uint index = value % base;
        buffer[--i] = cast(char)(index <= 9 ? '0' + index : 'A' + (index - 10));
        value /= base;
    } while(value);

    // &buffer[i] == pointer to most significant digit
    // buffer.length - i == length of string
    semihostingWrite(&buffer[i], buffer.length - i);
}

/************************************************************************************
* Print signed integer
*/
void write(int value, uint base = 10)
{
    // if negative, write minus sign and get absolute value
    if (value < 0)
    {
        write("-");
        write(cast(uint)(value * -1), base);
    }
    // if greater than or equal to 0, just treat it as an unsigned int
    else
    {
        write(cast(uint)value, base);
    }
}

/************************************************************************************
* Print boolean
*/
void write(bool value)
{
    write(value ? "true" : "false");
}

/************************************************************************************
* Print unsigned byte
*/
void write(ubyte value)
{
    write(cast(uint)value);
}

/************************************************************************************
* Print unsigned integer with a new line
*/
void writeln(uint value, uint base = 10)
{
    write(value, base);
    write("\r\n");
}

/************************************************************************************
* Print boolean with a newline
*/
void writeln(bool value)
{
    write(value);
    write("\r\n");
}

/************************************************************************************
* Print unsigned byte with a newline
*/
void writeln(ubyte value)
{
    write(cast(uint)value);
    write("\r\n");
}

/************************************************************************************
* Print signed integer with a new line
*/
//void writeln(int value, uint base = 10)
//{
//    write(value, base);
//    write("\r\n");
//}

/************************************************************************************
* Print string of charactes
*/
void write(in string text)
{
    if (text.length > 0)
    {
        semihostingWrite(&text[0], text.length);
    }
}

/************************************************************************************
* Print several values at once
*/
void write(A...)(in A a)
{
    foreach(t; a)
    {
        write(t);
    }
}

/************************************************************************************
* Print several values at once with a new line
*/
void writeln(A...)(in A a)
{
    foreach(t; a)
    {
        write(t);
    }
    write("\r\n");
}