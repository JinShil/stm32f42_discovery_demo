# stm32f42_discovery_demo
A simple demonstration of using D to bare-metal program an [STM32F29I Discovery Board](http://www.st.com/web/catalog/tools/FM116/SC959/SS1532/PF259090)

Good
* No CRT startup files, libgcc, libc, or vendor's C peripheral libraries were used.  EVERYTHING is in D. 
* Compile-time enforcement of register mutability
* Compile-time optimization of MMIO register access by turning byte aligned accesses into single, atomic reads/writes, even bitfields of a single byte due to ARM's bit-banding feature.  This increases performance and reduces code size
* Easy cross-referencing to the data sheet
* Setting multiple bit fields in a register with a single read-modify-write
* Fast (show video)
* Small Code Size (show executable size)
* Create compatibility with tooling (Show DDOC and Register Outline in IDE)

Bad
* Incomplete D runtime
* volatileLoad/volatileStore were added in 2.067.0, but that has not yet been merged into GDC.  For now, those are implemented using inline assembly.
* No HAL.  Program directly manipulates MMIO registers
* No enums on MMIO registers.  (HSE vs HSI is a bool (true|false))
* memset and memcpy are not written in optimized assembly
* Bug 12496:  Can't enforce bitfield belongs to a register when using setValue
* Really long build times

Ugly
* TypeInfo Faking
* Sed hack to get rid of code bloat in TypeInfo name
* Using an unimplemented druntime feature will result in a linker error instead of a compiler error.
* sometimes needing .value everywhere.  Would be nice to have an alias static this.
