module gcc.attribute;

version(GNU)
{
    private struct Attribute(A...)
    {
        A args;
    }

    auto attribute(A...)(A args) if(A.length > 0 && is(A[0] == string))
    {
        return Attribute!A(args);
    }

    public enum inline = gcc.attribute.attribute("forceinline");
    public enum naked = gcc.attribute.attribute("naked");
}