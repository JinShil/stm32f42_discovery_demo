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

import trace;
import gcc.attribute;
import rcc;
import pwr;
import flash;
import dma2d;
import ltdc;
import gpio;
import nvic;

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

@attribute("naked") void OnReset()
{
    // Enable Core-coupled memory for stack
    RCC.AHB1ENR.CCMDATARAMEN.value = true;
    
    // call main
    asm
    {
        " ldr r2, handler_address
        bx r2
        handler_address: .word hardwareInit";
    };
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
    memset(&__bss_start__, 0, &__bss_end__ - &__bss_start__);
    
    //----------------------------------------------------------------------
    // Power configuration
    //----------------------------------------------------------------------
    
    // Enable clock for the power management peripheral
    RCC.APB1ENR.PWREN.value = true;
    
    // increase voltage from the voltage regulator to acheive a 
    // greater clock speed at the expense of power consumption
    PWR.CR.VOS.value = 0b11;
    
 
    //----------------------------------------------------------------------
    // Clock configuration
    //----------------------------------------------------------------------
    
    // put RCC in default state
    with (RCC.CR)
    {
        setValue
        !(
              HSION,  true
            , HSEON,  false
            , CSSON,  false
            , PLLON,  false
            , HSEBYP, false
        )();
    }
    while(RCC.CR.HSERDY.value) { }
    
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
            , PPRE2,   0
            , PPRE1,   0
            , HPRE,    0
            , SW,      0
        )();
    }
    
    with(RCC.CIR)
    {
        setValue
        !(
              CSSC,        false
            , PLLSAIRDYC,  false
            , PLLI2SRDYC,  false
            , PLLRDYC,     false
            , HSERDYC,     false
            , HSIRDYC,     false
            , LSERDYC,     false
            , LSIRDYC,     false
            , PLLSAIRDYIE, false
            , PLLI2SRDYIE, false
            , PLLRDYIE,    false
            , HSERDYIE,    false
            , HSIRDYIE,    false
            , LSERDYIE,    false
            , LSIRDYIE,    false
        )();
    }
    
    with(RCC.PLLCFGR)
    {
        setValue
        !(
              PLLSRC, false  //HSI
            , PLLQ,   6
            , PLLP,   0
            , PLLN,   192
            , PLLM,   16
        )();
    }

    // Turn off and configure PLL
    RCC.CR.PLLON.value = false;
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
    
    // Clock prescalers
    with(RCC.CFGR)
    {
        setValue
        !(
              HPRE,  0b000 // AHB  = HCLK divided by 1
            , PPRE2, 0b100 // APB1 = HCLK divided by 2
            , PPRE1, 0b101 // APB2 = HCLK divide by 4
        )();
    }
    
    // Enable the Over-drive to extend the clock frequency to 180 Mhz
    PWR.CR.ODEN.value = true;
    while(!PWR.CSR.ODRDY.value) { }
    
    // Turn on high speed external clock
    RCC.CR.HSEON.value = true;
    while(!RCC.CR.HSERDY.value) { }
    
    // Turn on PLL
    RCC.CR.PLLON.value = true;
    while(!RCC.CR.PLLRDY.value){ }
    
    // Select the main PLL as system clock source
    RCC.CFGR.SW.value = 0b10; // PLL
    while(RCC.CFGR.SWS.value != RCC.CFGR.SW.value) { }
    
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
            , LATENCY, 5     // 5 wait states. No choice if we increase them
        )();                 //   the clock speed, which we intend to do  
    }
    
    // blinky
    RCC.AHB1ENR.GPIOGEN.value     = true;
    GPIOG.OSPEEDR.OSPEEDR13.value = 0b11;
    GPIOG.MODER.MODER13.value     = 0b01;
    GPIOG.OTYPER.OT13.value       = 0b00;
    GPIOG.PUPDR.PUPDR13.value     = 0b00;
    
    mainProgram();
}

extern(C) void mainProgram()
{        
    while(true)
    {
        GPIOG.ODR.ODR13.value = !GPIOG.ODR.ODR13.value;
        trace.writeLine(GPIOG.ODR.ODR13.value); //mostly for delay
    }
}