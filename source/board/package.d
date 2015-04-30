// Copyright © 2015 Michael V. Franklin
//      
// This file is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This file is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this file.  If not, see <http://www.gnu.org/licenses/>.

module board;

import gcc.attribute;

import stm32f42.rcc;
import stm32f42.pwr;
import stm32f42.flash;
// import dma2d;
// import ltdc;
import stm32f42.gpio;
// import nvic;

import lcd = board.lcd;
import trace = stm32f42.trace;
import statusLED = board.statusLED;

extern void main();

// These are marked extern(C) to avoid name mangling, so we can refer to them in our linker script
alias ISR = void function(); // Alias Interrupt Service Routine function pointers
extern(C) immutable ISR ResetHandler = &OnReset; // Pointer to entry point, OnReset
extern(C) immutable ISR HardFaultHandler = &OnHardFault; // Pointer to hard fault handler, OnHardFault

// Handle any hard faults here
void OnHardFault()
{
    // Display a message notifying us that a hard fault occurred
    //trace.writeLine("Hard Fault");
    trace.writeLine("hard fault");
    
    // Enter an infinite loop so we can use the debugger
    // to examine registers, memory, etc...
    while(true) { }
}

@naked void OnReset()
{
    // Enable Core-coupled memory for stack
    RCC.AHB1ENR.CCMDATARAMEN.value = true;
    
    // call main
    version(GNU)
    {
      asm
      {
          " ldr r2, handler_address
          bx r2
          handler_address: .word hardwareInit";
      };
    }
}

// defined in the linker
extern(C) extern __gshared ubyte __text_end__;
extern(C) extern __gshared ubyte __data_start__;
extern(C) extern __gshared ubyte __data_end__;
extern(C) extern __gshared ubyte __bss_start__;
extern(C) extern __gshared ubyte __bss_end__;

extern(C) void* memset(void* dest, int value, size_t num)
{
    // naive implementation for the moment.  Eventually,
    // this should be implemented in assembly
    
    byte* d = cast(byte*)dest;
    for(int i = 0; i < num; i++)
    {
        d[i] = cast(byte)value;
    }
    
    return dest;
} 

extern(C) void* memcpy(void* dest, void* src, size_t num)
{    
    // naive implementation for the moment.  Eventually,
    // this should be implemented in assembly
    
    ubyte* d = cast(ubyte*)dest;
    ubyte* s = cast(ubyte*)src;
    
    for(int i = 0; i < num; i++)
    {
        d[i] = s[i];
    }
    
    return dest;
} 

extern(C) void hardwareInit()
{
    // copy data segment out of ROM and into RAM
    memcpy(&__data_start__, &__text_end__, &__data_end__ - &__data_start__);
    
    // zero out variables initialized to void
    //memset(&__bss_start__, 0, &__bss_end__ - &__bss_start__);
    
    //----------------------------------------------------------------------
    // Power configuration
    //----------------------------------------------------------------------

    // Enable clock for the power management peripheral
    RCC.APB1ENR.PWREN.value = true;
    
    // increase voltage from the voltage regulator to acheive a 
    // greater clock speed at the expense of power consumption
    PWR.CR.VOS.value = 0b11;
    
    // Enable the Over-drive to extend the clock frequency to 180 Mhz
    PWR.CR.ODEN.value = true;
    while(!PWR.CSR.ODRDY.value) { }
    
    PWR.CR.ODSWEN.value = true;
    while(!PWR.CSR.ODSWRDY.value) {}
    
    //----------------------------------------------------------------------
    // Flash configuration
    //----------------------------------------------------------------------
    
    // Enable Flash prefetch, Instruction cache, Data cache and wait state
    with(FLASH.ACR)
    {
        setValue
        !(
              PRFTEN,  true  // prefetch
            , ICEN,    true  // instruction cache
            , DCEN,    true  // data cache
            , LATENCY, 5     // 5 wait states. No choice if we increase
        )();                 //   the clock speed, which we intend to do  
    }
    
 
    //----------------------------------------------------------------------
    // Clock configuration
    //----------------------------------------------------------------------
    with (RCC.CR)
    {
        setValue
        !(
              HSION,     true      //Default to HSI on
            , HSEON,     false
            , CSSON,     false
            , PLLON,     false
            , PLLISAION, false
            , PLLI2SON,  false
        );
    }
    while(!RCC.CR.HSIRDY.value) { }
    
    RCC.CR.HSEBYP.value = false;
    
    with(RCC.CFGR)
    {
        setValue
        !(
              MCO2,    0
            , MCO2PRE, 0
            , MCO1PRE, 0
            , I2SSRC,  0
            , MCO1,    0
            , RTCPRE,  0
            , HPRE,    0b000 // AHB  = HCLK divided by 1
            , PPRE2,   0b100 // APB2 = HCLK divided by 2
            , PPRE1,   0b101 // APB1 = HCLK divide by 4
            , SW,      0     // HSI is system clock
        )();
    }
    
    // Turn on high speed external clock
    RCC.CR.HSEON.value = true;
    while(!RCC.CR.HSERDY.value) { }
    
    // Configure PLL
    with(RCC.PLLCFGR)
    {
        setValue
        !(
              PLLSRC, true // HSE
            , PLLM,   8
            , PLLN,   360
            , PLLP,   2
            , PLLQ,   7
        )();
    }
    
    // Turn on PLL
    RCC.CR.PLLON.value = true;
    while(!RCC.CR.PLLRDY.value){ }
    
    // Select the main PLL as system clock source
    RCC.CFGR.SW.value = 0b10; // PLL
    while(RCC.CFGR.SWS.value != RCC.CFGR.SW.value) { }
    
    // status LED
    statusLED.init();
    
    //Initialize the LCD
	lcd.init();
    
    main();
}