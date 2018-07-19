module attributes;

version(GNU)
{
    private:
    struct Attribute(A...)
    {
        A args;
    }

    auto attribute(A...)(A args) if(A.length > 0 && is(A[0] == string))
    {
        return Attribute!A(args);
    }

    public:
    enum inline = attribute("forceinline");
    enum naked = attribute("naked");
}

version(LDC)
{
    import ldc.attributes;

    public:
    enum inline = "";
    enum naked = "";
}