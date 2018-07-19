# stm32f42_discovery_demo
A simple demonstration of using D to bare-metal program an [STM32F29I Discovery Board](http://www.st.com/web/catalog/tools/FM116/SC959/SS1532/PF259090)

![](https://raw.githubusercontent.com/JinShil/stm32f42_discovery_demo/master/images/teaser.jpg)

[Download Video](https://raw.githubusercontent.com/JinShil/stm32f42_discovery_demo/master/images/teaser.mp4)

## Build
Run `rdmd build.d -c=gdc` to build with GDC.  You will need a [GDC ARM cross compiler](https://github.com/JinShil/arm-none-eabi-gdc).

Run `rdmd build.d -c=ldc` to build with LDC.  You can use the *linux-armhf* download from the [LDC releases](https://github.com/ldc-developers/ldc/releases).

You need to install dmd and dtools (for `rdmd`), arm-none-eabi-gcc (for `arm-none-eabi-gdb`), and openocd from your Linux distribution's package manager.

## The Good
* It works!
* No CRT startup files, libgcc, libc, or vendor's C peripheral libraries were used.  *EVERYTHING* is in D.
* No Stinking `-betterC`.  If you don't want the overhead of a certain feature of D, don't use it.
* [Compile-time enforcement of register/bitfield mutability](https://github.com/JinShil/stm32f42_discovery_demo/blob/c324bbf861cf258a819478481521528fca88dcb3/source/stm32f42/mmio.d#L244-L275)
* [Compile-time optimization of MMIO register access](https://github.com/JinShil/stm32f42_discovery_demo/blob/c324bbf861cf258a819478481521528fca88dcb3/source/stm32f42/mmio.d#L417-L437) by turning byte- and half-word-aligned accesses into single, atomic reads/writes. Single-bit bitfields are optimized at compile time to use ARM's bitbanding feature for atomic access.  This increases performance, reduces code size, and is all abstracted from the user.
* [Setting multiple bit fields in a register with a single read-modify-write](https://github.com/JinShil/stm32f42_discovery_demo/blob/c324bbf861cf258a819478481521528fca88dcb3/source/stm32f42/mmio.d#L665-L671)

```D
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
3124	      0	 153600	 156700	  2641c	binary/firmware
```
* The code resembles the register descriptions in the STM32 reference manual for easy cross-referencing.
![](https://raw.githubusercontent.com/JinShil/stm32f42_discovery_demo/master/images/cross-referencing.png)
* Good integration with tooling.  e.g Register descriptions in DDoc popups, and register layout in outline and code completion windows.  In other words, the code *is* the datasheet.
![](https://raw.githubusercontent.com/JinShil/stm32f42_discovery_demo/master/images/tooling.png)


## The Bad
* [The implementation of D runtime](https://github.com/JinShil/stm32f42_discovery_demo/tree/master/source/runtime) is minimal, and therefore incomplete, but a C-like subset of D (inline assembly, structs, templates, mixins, and even static classes) is available.

## The Ugly
* I didn't put much diligence and care into some of the code, because I was anxious to just get something to appear on the LCD screen.  There are a lot of magic numbers that should be enums, and there is no hardware abstraction layer - the program directly manipulates the memory-mapped IO registers. There are also some static asserts that should be added for compile-time sanity checks.  Lots of refactoring and code quality improvements still need to be done.
