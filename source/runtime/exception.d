module exception;

import trace = stm32f42.trace;

/***********************************************************************
    For assert(condition) statements
*/
extern(C) void _d_assert(string file, uint line)
{
    trace.writeLine(file, ":", line);
    while(true) { }
}

/***********************************************************************
    For assert(condition, message) statements
*/
extern(C) void _d_assert_msg(string msg, string file, uint line)
{
    trace.writeLine(file, ":", line, ": ", msg);
    while(true) { }
}