version(GNU)
{
    void _d_invariant(Object o)
    {   
    //     ClassInfo c;
    // 
    //     //printf("__d_invariant(%p)\n", o);
    // 
    //     // BUG: needs to be filename/line of caller, not library routine
    //     assert(o !is null); // just do null check, not invariant check
    // 
    //     c = typeid(o);
    //     do
    //     {
    //         if (c.classInvariant)
    //         {
    //             (*c.classInvariant)(o);
    //         }
    //         c = c.base;
    //     } while (c);
    }
}
