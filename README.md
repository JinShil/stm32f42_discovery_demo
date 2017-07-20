# stm32f42_discovery_demo
A simple demonstration of using D to bare-metal program an [STM32F29I Discovery Board](http://www.st.com/web/catalog/tools/FM116/SC959/SS1532/PF259090)

![](https://raw.githubusercontent.com/JinShil/stm32f42_discovery_demo/master/images/teaser.jpg)

[Download Video](https://raw.githubusercontent.com/JinShil/stm32f42_discovery_demo/master/images/teaser.mp4)

## Build
Simply run `rdmd build.d`.

You need to install dmd, dtools, arm-none-eabi-gcc (for arm-none-eabi-gdb), and openocd from your Linux distribution's package manager.

You will also need a [GDC ARM cross compiler](https://github.com/JinShil/arm-none-eabi-gdc).

## The Good
* It works!
* No CRT startup files, libgcc, libc, or vendor's C peripheral libraries were used.  EVERYTHING is in D. 
* No Stinking `-betterC`.  If you don't want the overhead of a certain feature of D, don't use it. `-betterC` is just a synonymn for `-worseD`.
* [Compile-time enforcement of register/bitfield mutability](https://github.com/JinShil/stm32f42_discovery_demo/blob/master/source/stm32f42/mmio.d#L219-L234)
* [Compile-time optimization of MMIO register access](https://github.com/JinShil/stm32f42_discovery_demo/blob/master/source/stm32f42/mmio.d#L374-L395) by turning byte- and half-word-aligned accesses into single, atomic reads/writes. Single-bit bitfields are optimized at compile time to use ARM's bitbanding feature for atomic access.  This increases performance, reduces code size, and is all abstracted from the user.
* [Setting multiple bit fields in a register with a single read-modify-write](https://github.com/JinShil/stm32f42_discovery_demo/blob/master/source/stm32f42/mmio.d#L624-L630)

```
with(GPIOA.MODER)
{
	setValue
	!(
		  MODER3,  0b10  // Alternate function mode
		, MODER4,  0b10
		, MODER6,  0b10
		, MODER11, 0b10
		, MODER12, 0b10
	);
}
```

* Seems to be pretty fast, but I still need to verify the generated code to ensure optimizations are being performed properly
* Small Code Size (3k).  The data in the BSS segment is my LCD's frame buffer, so that really doesn't count.

```
text       data     bss     dec      hex   filename
3100	      0	 153600	 156700	  2641c	binary/firmware
```
* The code resembles the register descriptions in the STM32 reference manual for easy cross-referencing.
![](https://raw.githubusercontent.com/JinShil/stm32f42_discovery_demo/master/images/cross-referencing.png)
* Good integration with tooling.  e.g Register descriptions in DDoc popups, and register layout in outline and code completion windows.  In other words, the code *is* the datasheet.
![](https://raw.githubusercontent.com/JinShil/stm32f42_discovery_demo/master/images/tooling.png)


## The Bad
* [The implementation of D runtime](https://github.com/JinShil/stm32f42_discovery_demo/tree/master/source/runtime) is minimal, and therefore very incomplete.  Many features of D are not usable.
* Due to [bug 12496](https://issues.dlang.org/show_bug.cgi?id=12496), I can't enforce that a `Bitfield` belongs to a `Register` when using the `setValue` template.
* Really long build times (Nearly 1 minute to generate a 3k binary!).  This seems to be GDC issue.  See [Forum Discussion](http://forum.dlang.org/post/iqryqssxooypdnszmzmg@forum.dlang.org)
* `-O2` and `-O3` produce broken binaries.  Need to investigate further.  -O3 produces a 6kB binary; almost double the size of `-Os`.
* Currently only works for the GDC compiler.  LCD was not supported due to [Issue 781](https://github.com/ldc-developers/ldc/issues/781) and [Issue 552](https://github.com/ldc-developers/ldc/issues/552)

## The Ugly
* I didn't put much diligence and care into some of the code, because I was anxious to just get something to appear on the LCD screen.  There are a lot of magic numbers that should be enums, and there is no hardware abstraction layer - the program directly manipulates the memory-mapped IO registers. There are also some static asserts that should be added for compile-time sanity checks.
* [TypeInfo faking](https://youtu.be/o5m0m_ZG9e8?t=2513).  [Potential solution](https://issues.dlang.org/show_bug.cgi?id=12270)
* Using an unimplemented druntime feature will result in a linker error, at best, instead of a compiler error.  [Potential solution](http://forum.dlang.org/post/psssnzurlzeqeneagora@forum.dlang.org).
* I have to put a `.value` every time I want to access a memory-mapped IO bitfield.  This is because there is no `static alias x this;` and D's `static opAssign` isn't symetric.  I think if I were to do this again, I would use a different pattern altogether.
