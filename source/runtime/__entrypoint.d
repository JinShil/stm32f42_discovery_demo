// This is needed by GDC as the compiler looks for this module in order to inject
// a CMain function.  
// See https://github.com/D-Programming-GDC/GDC/blob/48384612969fe90bdf88f562d1017bd8c5ec8612/gcc/d/d-lang.cc#L747
module __entrypoint;