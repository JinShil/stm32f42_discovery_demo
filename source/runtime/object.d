module object;

alias size_t    = typeof(int.sizeof);
alias ptrdiff_t = typeof(cast(void*)0 - cast(void*)0);

alias string = immutable(char)[];

class Object
{ }

class TypeInfo
{ }

class TypeInfo_Const : TypeInfo
{
    size_t getHash(in void *p) const nothrow { return 0; }
}

class Throwable
{ }

class Error : Throwable
{ 
    this(string x)
    { }
}

