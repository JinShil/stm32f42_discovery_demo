module attributes;

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