module object;

nothrow:
@safe:

alias size_t    = typeof(int.sizeof);
alias ptrdiff_t = typeof(cast(void*)0 - cast(void*)0);

alias string = immutable(char)[];

version(GNU)
{
    private import gcc.attribute;
    enum inline = attribute("forceinline");
    enum noinline = attribute("noinline");

    private import gcc.builtins;
    public alias alloca = __builtin_alloca;

    // See https://bugzilla.gdcproject.org/show_bug.cgi?id=299
    bool _xopEquals(in void*, in void*)
    {
        return false;
    }
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

    pragma(LDC_alloca)
    void* alloca(size_t size) pure;
}