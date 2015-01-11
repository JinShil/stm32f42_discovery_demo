module exception;

import trace;

/***********************************************************************
  For assert(condition) statements
*/
extern(C) void _d_assert(string file, uint line)
{
    trace.writeLine(file, ":", line);
}

/***********************************************************************
  For assert(condition, message) statements
*/
extern(C) void _d_assert_msg(string msg, string file, uint line)
{
    trace.writeLine(file, ":", line, ":", msg);
}