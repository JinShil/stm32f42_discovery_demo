# stm32f42_discovery_demo
A simple demonstration of using D to bare-metal program an [STM32F29I Discovery Board](http://www.st.com/web/catalog/tools/FM116/SC959/SS1532/PF259090)

Good
* It works!
* No CRT startup files, libgcc, libc, or vendor's C peripheral libraries were used.  EVERYTHING is in D. 
* [Compile-time enforcement of register/bitfield mutability] (https://github.com/JinShil/stm32f42_discovery_demo/blob/master/source/stm32f42/mmio.d#L346-L456)
* [Compile-time optimization of MMIO register access](https://github.com/JinShil/stm32f42_discovery_demo/blob/master/source/stm32f42/mmio.d#L346-L456) by turning byte- and half-word-aligned accesses into single, atomic reads/writes. Single-bit bitfields are optimized at compile time to use ARM's bitbanding feature for atomic access.  This increases performance, reduces code size, and is all abstracted from the user.
* [Setting multiple bit fields in a register with a single read-modify-write] (https://github.com/JinShil/stm32f42_discovery_demo/blob/master/source/stm32f42/mmio.d#L610-L616)
* Seems to be pretty fast, but I still need to verify the generated code to ensure optimizations are being performed properlly
* Small Code Size 

```
text       data     bss     dec      hex   filename
6200       0        153600  159800   27038 binary/firmware
```
* The code resembles the register descriptions in the STM32 reference manual for easy cross-referenceing.
(side-by-side image of datasheet with IDE)
* Create compatibility with tooling (Show DDOC and Register Outline in IDE)


Bad
* I didn't put much diligence and care into some of the code, because I was anxious to just get something to appear on the LCD screen.  There are a lot of magic numbers that should be enums, and there is no hardware abstraction layer - the program directly manipulates the memory-mapped IO registers.
* [The implementation of D runtime](https://github.com/JinShil/stm32f42_discovery_demo/tree/master/source/runtime) is minimal, and therefore very incomplete.  Many features of D are not usable.
* volatileLoad/volatileStore were added in 2.067.0, but that has not yet been merged into GDC.  For now, I'm misusing [GDC's `shared` bug](https://github.com/JinShil/stm32f42_discovery_demo/tree/master/source/runtime) as a feature. [See code](https://github.com/JinShil/stm32f42_discovery_demo/blob/master/source/stm32f42/mmio.d#L92-L103).
* Due to [bug 12496](https://issues.dlang.org/show_bug.cgi?id=12496), I can't enforce that a `Bitfield` belongs to a `Register` when using the `setValue` template.
* Really long build times (Nearly 2 minutes to generate a 6k binary!).  I suspect that is due to my liberal use of D's metaprogramming and compile-time features.

Ugly
* [TypeInfo faking](https://youtu.be/o5m0m_ZG9e8?t=2513).  [Potential solution](https://issues.dlang.org/show_bug.cgi?id=12270)
* The compiler generates a TypeInfo.name for each and every bitfield in my code, and puts that in the rodata segment.  Due to [GCC bug 192](https://gcc.gnu.org/bugzilla/show_bug.cgi?id=192), -fdata-sections doesn't put it in its own linker, so my binary becomes more than 400k.  [See this discussion for details](http://forum.dlang.org/post/quemhwpgijwmqtpxukiv@forum.dlang.org).  So, I added a [sed hack](https://github.com/JinShil/stm32f42_discovery_demo/blob/master/build.d#L69) to my build script put these strings in their own sections, and that brings my binary down to around 5-6k.  But it's not perfect and sometimes results in removing strings that are needed.
* Using an unimplemented druntime feature will result in a linker error, at best, instead of a compiler error.  [Potential solution](http://forum.dlang.org/post/psssnzurlzeqeneagora@forum.dlang.org).
* I have to put a `.value` every time I want to access a memory-mapped IO bitfield.  This is because there is no 'static alias x this;` in D's `static opAssign` isn't symetric.  I think if I were to do this again, I would use a different pattern altogether.
