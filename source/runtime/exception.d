module exception;

import trace = stm32f42.trace;

nothrow:

/***********************************************************************
    For assert(condition) statements
*/
extern(C) void _d_assert(string file, uint line)
{
    trace.writeln(file, ":", line);
    while(true) { }
}

/***********************************************************************
    For assert(condition, message) statements
*/
extern(C) void _d_assert_msg(string msg, string file, uint line)
{
    trace.writeln(file, ":", line, ": ", msg);
    while(true) { }
}