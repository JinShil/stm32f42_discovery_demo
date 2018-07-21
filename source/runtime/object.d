module object;

alias size_t    = typeof(int.sizeof);
alias ptrdiff_t = typeof(cast(void*)0 - cast(void*)0);

alias string = immutable(char)[];

bool _xopEquals(in void*, in void*)
{
    return false;
}

version(GNU)
{
    private import gcc.attribute;
    enum inline = attribute("forceinline");
    enum noinline = attribute("noinline");
}

version(LDC)
{
    enum inline = "";
    enum noinline = "";
}

version(LDC)
{
    struct __asmtuple_t(T...)
    {
        T v;
    }

    pragma(LDC_inline_asm)
    {
        void __asm()(const(char)[] asmcode, const(char)[] constraints, ...) pure nothrow @nogc;
        T __asm(T)(const(char)[] asmcode, const(char)[] constraints, ...) pure nothrow @nogc;
    }
}