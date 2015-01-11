module object;

alias size_t    = typeof(int.sizeof);
alias ptrdiff_t = typeof(cast(void*)0 - cast(void*)0);

alias string = immutable(char)[];

class Object
{ }

class TypeInfo
{ 
    const(void)[] init() nothrow pure const @safe { return null; }
}

class TypeInfo_Class : TypeInfo
{
    ubyte[68] ignore;
}

class TypeInfo_Struct : TypeInfo
{
    ubyte[52] ignore;
}

class TypeInfo_Array : TypeInfo
{  
    ubyte[1] ignore;
}

class TypeInfo_Enum : TypeInfo
{  
    ubyte[20] ignore;
}

bool _xopEquals(in void*, in void*)
{
    //assert(false, "Not Implemented");
    //throw new Error("TypeInfo.equals is not implemented");
    return true;
}

class TypeInfo_i : TypeInfo
{

}