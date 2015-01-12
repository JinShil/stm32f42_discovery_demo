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
import gpioi;
import gpioj;
import gpiok;

// These are marked extern(C) to avoid name mangling, so we can refer to them in our linker script
alias ISR = void function(); // Alias Interrupt Service Routine function pointers
extern(C) immutable ISR ResetHandler = &OnReset; // Pointer to entry point, OnReset
extern(C) immutable ISR HardFaultHandler = &OnHardFault; // Pointer to hard fault handler, OnHardFault

// Handle any hard faults here
void OnHardFault()
{
    trace.writeLine("hard fault");
    
    // Display a message notifying us that a hard fault occurred
    //trace.writeLine("Hard Fault");
    // Enter an infinite loop so we can use the debugger
    // to examine registers, memory, etc...
    while(true)
    { }
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
        handler_address: .word main";
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

// RGB565 buffer
private ushort[320*240] graphicsBuffer;

void LTDCPinValues(SPEED, MODE, OT, PUPD, AF)()
{
    SPEED.value = 0b11;
    MODE.value = 0b10;
    OT.value = 0;
    PUPD.value = 0;
    AF.value = 0x0E;
}

string LTDCPin(string port ,string pin)
{
    return "GPIO" ~ port ~ ".OSPEEDR.OSPEEDR" ~ pin ~ ".value = 0b11;"
         ~ "GPIO" ~ port ~ ".MODER.MODER" ~ pin ~ ".value = 0b10;"
         ~ "GPIO" ~ port ~ ".OTYPER.OT" ~ pin ~ ".value = 0;"
         ~ "GPIO" ~ port ~ ".PUPDR.PUPDR" ~ pin ~ ".value = 0;";
}

string LTDCPinL(string port, string pin)
{
    return "GPIO" ~ port ~ ".AFRL.AFRL" ~ pin ~ ".value = 0x0E;"
        ~ LTDCPin(port, pin);
}

string LTDCPinH(string port, string pin)
{
    return "GPIO" ~ port ~ ".AFRH.AFRH" ~ pin ~ ".value = 0x0E;"
        ~ LTDCPin(port, pin);
}

extern(C) void main()
{    
    // copy data segment out of ROM and into RAM
    memcpy(&__data_start__, &__text_end__, &__data_end__ - &__data_start__);
    
    // zero out variables initialized to void
    memset(&__bss_start__, 0, &__bss_end__ - &__bss_start__);
    
    
    //LTDCPin!(GPIOK.AFRL.AFRL1);
    
    
    // bring up MCU
    // this code was ported from the STM32F4 peripheral library 
    // (system_stm32f4xx.c)
    //-------------------------------------------------------------
    
    // put RCC in a starting state
    RCC.CR.HSION.value = true;
    
    RCC.CFGR.MCO2.value = 0;
    RCC.CFGR.MCO2PRE.value = 0;
    RCC.CFGR.MCO1PRE.value = 0;
    RCC.CFGR.MCO1PRE.value = 0;
    RCC.CFGR.I2SSRC.value = 0;
    RCC.CFGR.MCO1.value = 0;
    RCC.CFGR.RTCPRE.value = 0;
    RCC.CFGR.PPRE2.value = 0;
    RCC.CFGR.PPRE1.value = 0;
    RCC.CFGR.HPRE.value = 0;
    RCC.CFGR.SW.value = 0b00;  // HSI
    
    RCC.CR.HSEON.value = false;
    RCC.CR.CSSON.value = false;
    
    RCC.PLLCFGR.PLLQ.value = 0b0100;
    RCC.PLLCFGR.PLLSRC.value = false; // HSI
    RCC.PLLCFGR.PLLP.value = 0;
    RCC.PLLCFGR.PLLN.value = 192;
    RCC.PLLCFGR.PLLM.value = 16;
    
    RCC.CR.HSEBYP.value = false;
    
    // disable all interrupts
    RCC.CIR.CSSC.value = false;
    RCC.CIR.PLLSAIRDYC.value = false;
    RCC.CIR.PLLI2SRDYC.value = false;
    RCC.CIR.PLLRDYC.value = false;
    RCC.CIR.HSERDYC.value = false;
    RCC.CIR.HSIRDYC.value = false;
    RCC.CIR.LSERDYC.value = false;
    RCC.CIR.LSIRDYC.value = false;
    RCC.CIR.PLLSAIRDYIE.value = false;
    RCC.CIR.PLLI2SRDYIE.value = false;
    RCC.CIR.PLLRDYIE.value = false;
    RCC.CIR.HSERDYIE.value = false;
    RCC.CIR.HSIRDYIE.value = false;
    RCC.CIR.LSERDYIE.value = false;
    RCC.CIR.LSIRDYIE.value = false;
    
    // Bring up HSE
    RCC.CR.HSEON.value = true;
    
    while(!RCC.CR.HSERDY.value)
    { }
    
    // Select regulator voltage output Scale 1 mode
    RCC.APB1ENR.PWREN.value = true;
    
    // HCLK = SYSCLK
    RCC.CFGR.HPRE.value = 0;
    RCC.CFGR.PPRE2.value = 0b100; // divide by 2
    RCC.CFGR.PPRE1.value = 0b101; // divide by 4
    
    // configure PLL
    RCC.CR.PLLON.value = false;
    RCC.PLLCFGR.PLLSRC.value = true; // HSE
    RCC.PLLCFGR.PLLM.value = 25;
    RCC.PLLCFGR.PLLN.value = 360;
    RCC.PLLCFGR.PLLP.value = 0;
    RCC.PLLCFGR.PLLQ.value = 7;
    RCC.CR.PLLON.value = true;
    
    while(!RCC.CR.PLLRDY.value)
    { }
    
    
    // Enable the Over-drive to extend the clock frequency to 180 Mhz
    PWR.CR.ODEN.value = true;
    while(!PWR.CSR.ODRDY.value)
    { }
   
    
    PWR.CR.ODSWEN.value = true;
    while(!PWR.CSR.ODSWRDY.value)
    { }
    
    // Configure Flash prefetch, Instruction cache, Data cache and wait state
    FLASH.ACR.PRFTEN.value = true;
    FLASH.ACR.ICEN.value = true;
    FLASH.ACR.DCEN.value = true;
    FLASH.ACR.LATENCY.value = 5;
    
    // Select the main PLL as system clock source
    RCC.CFGR.SW.value = 0b10; // PLL
    while(RCC.CFGR.SWS.value != RCC.CFGR.SW.value)
    { }
   
    
    /*
    +------------------------+-----------------------+----------------------------+
    +                       LCD pins assignment                                   +
    +------------------------+-----------------------+----------------------------+
    |  LCD_TFT R0 <-> PI.15  |  LCD_TFT G0 <-> PJ.07 |  LCD_TFT B0 <-> PJ.12      |
    |  LCD_TFT R1 <-> PJ.00  |  LCD_TFT G1 <-> PJ.08 |  LCD_TFT B1 <-> PJ.13      |
    |  LCD_TFT R2 <-> PJ.01  |  LCD_TFT G2 <-> PJ.09 |  LCD_TFT B2 <-> PJ.14      |
    |  LCD_TFT R3 <-> PJ.02  |  LCD_TFT G3 <-> PJ.10 |  LCD_TFT B3 <-> PJ.15      |
    |  LCD_TFT R4 <-> PJ.03  |  LCD_TFT G4 <-> PJ.11 |  LCD_TFT B4 <-> PK.03      |
    |  LCD_TFT R5 <-> PJ.04  |  LCD_TFT G5 <-> PK.00 |  LCD_TFT B5 <-> PK.04      |
    |  LCD_TFT R6 <-> PJ.05  |  LCD_TFT G6 <-> PK.01 |  LCD_TFT B6 <-> PK.05      |
    |  LCD_TFT R7 <-> PJ.06  |  LCD_TFT G7 <-> PK.02 |  LCD_TFT B7 <-> PK.06      |
    -------------------------------------------------------------------------------
            |  LCD_TFT HSYNC <-> PI.12  | LCDTFT VSYNC <->  PI.13 |
            |  LCD_TFT CLK   <-> PI.14  | LCD_TFT DE   <->  PK.07 |
            -----------------------------------------------------
    */
    
    RCC.APB2ENR.LTDCEN.value = true;
    RCC.AHB1ENR.DMA2DEN.value = true;
    RCC.AHB1ENR.GPIOIEN.value = true;
    RCC.AHB1ENR.GPIOJEN.value = true;
    RCC.AHB1ENR.GPIOKEN.value = true;
    
    // GPIO pins for the LCD
    // LTDC alternate function code = 0x0E
    mixin(LTDCPinH("I", "12"));
    mixin(LTDCPinH("I", "13"));
    mixin(LTDCPinH("I", "14"));
    mixin(LTDCPinH("I", "15"));
    
    mixin(LTDCPinL("J", "0"));
    mixin(LTDCPinL("J", "1"));
    mixin(LTDCPinL("J", "2"));
    mixin(LTDCPinL("J", "3"));
    mixin(LTDCPinL("J", "4"));
    mixin(LTDCPinL("J", "5"));
    mixin(LTDCPinL("J", "6"));
    mixin(LTDCPinL("J", "7"));
    mixin(LTDCPinH("J", "8"));
    mixin(LTDCPinH("J", "9"));
    mixin(LTDCPinH("J", "10"));
    mixin(LTDCPinH("J", "11"));
    mixin(LTDCPinH("J", "12"));
    mixin(LTDCPinH("J", "13"));
    mixin(LTDCPinH("J", "14"));
    mixin(LTDCPinH("J", "15"));
   
    mixin(LTDCPinL("K", "0"));
    mixin(LTDCPinL("K", "1"));
    mixin(LTDCPinL("K", "2"));
    mixin(LTDCPinL("K", "3"));
    mixin(LTDCPinL("K", "4"));
    mixin(LTDCPinL("K", "5"));
    mixin(LTDCPinL("K", "6"));
    mixin(LTDCPinL("K", "7"));
    
    while(true)
    {
        trace.writeLine("x");
    }
}