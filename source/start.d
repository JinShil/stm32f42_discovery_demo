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
import gpioa;
import gpiob;
import gpioc;
import gpiof;
import gpiog;

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
private ushort[240*320] graphicsBuffer;

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
    RCC.CR.PLLON.value = false;
    
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
    
    /*##-1- System Clock Configuration #########################################*/  
    /* Enable HSE Oscillator and activate PLL with HSE as source */
    
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
    RCC.PLLCFGR.PLLM.value = 8;
    RCC.PLLCFGR.PLLN.value = 360;
    RCC.PLLCFGR.PLLP.value = 0;
    RCC.PLLCFGR.PLLQ.value = 7;
    
    RCC.CR.PLLON.value = true;
    while(!RCC.CR.PLLRDY.value){ }
    
    // Enable the Over-drive to extend the clock frequency to 180 Mhz
    PWR.CR.ODEN.value = true;
    while(!PWR.CSR.ODRDY.value) { }
    
    PWR.CR.ODSWEN.value = true;
    while(!PWR.CSR.ODSWRDY.value) { }

    // Configure Flash prefetch, Instruction cache, Data cache and wait state
    FLASH.ACR.PRFTEN.value = true;
    FLASH.ACR.ICEN.value = true;
    FLASH.ACR.DCEN.value = true;
    FLASH.ACR.LATENCY.value = 5;
    
    // Select the main PLL as system clock source
    RCC.CFGR.SW.value = 0b10; // PLL
    while(RCC.CFGR.SWS.value != RCC.CFGR.SW.value) { }
    
    /*##-2- LTDC Clock Configuration ###########################################*/  
    /* LCD clock configuration */
    /* PLLSAI_VCO Input = HSE_VALUE/PLL_M = 1 MHz */
    /* PLLSAI_VCO Output = PLLSAI_VCO Input * PLLSAIN = 192 MHz */
    /* PLLLCDCLK = PLLSAI_VCO Output/PLLSAIR = 192/4 = 48 MHz */
    /* LTDC clock frequency = PLLLCDCLK / RCC_PLLSAIDIVR_8 = 48/8 = 6 MHz */
    RCC.CR.PLLISAION.value = false;
    while(RCC.CR.PLLSAIRDY.value) { }
    
    RCC.PLLSAICFGR.PLLSAIN.value = 192;
    RCC.PLLSAICFGR.PLLSAIR.value = 4;
    RCC.DCKCFGR.PLLSAIDIVR.value = 0b10;  // divide by 8
    
    RCC.CR.PLLISAION.value = true;
    while(!RCC.CR.PLLSAIRDY.value) { }

  /*
   +------------------------+-----------------------+----------------------------+
   +                       LCD pins assignment                                   +
   +------------------------+-----------------------+----------------------------+
   |  LCD_TFT R2 <-> PC.10  |  LCD_TFT G2 <-> PA.06 |  LCD_TFT B2 <-> PD.06      |
   |  LCD_TFT R3 <-> PB.00  |  LCD_TFT G3 <-> PG.10 |  LCD_TFT B3 <-> PG.11      |
   |  LCD_TFT R4 <-> PA.11  |  LCD_TFT G4 <-> PB.10 |  LCD_TFT B4 <-> PG.12      |
   |  LCD_TFT R5 <-> PA.12  |  LCD_TFT G5 <-> PB.11 |  LCD_TFT B5 <-> PA.03      |
   |  LCD_TFT R6 <-> PB.01  |  LCD_TFT G6 <-> PC.07 |  LCD_TFT B6 <-> PB.08      |
   |  LCD_TFT R7 <-> PG.06  |  LCD_TFT G7 <-> PD.03 |  LCD_TFT B7 <-> PB.09      |
   -------------------------------------------------------------------------------
            |  LCD_TFT HSYNC <-> PC.06  | LCDTFT VSYNC <->  PA.04 |
            |  LCD_TFT CLK   <-> PG.07  | LCD_TFT DE   <->  PF.10 |
             -----------------------------------------------------

  */
    
    RCC.APB2ENR.LTDCEN.value = true;
    //RCC.AHB1ENR.DMA2DEN.value = true;
    RCC.AHB1ENR.GPIOAEN.value = true;
    RCC.AHB1ENR.GPIOBEN.value = true;
    RCC.AHB1ENR.GPIOCEN.value = true;
    RCC.AHB1ENR.GPIOFEN.value = true;
    RCC.AHB1ENR.GPIOGEN.value = true;
    
    // GPIO pins for the LCD
    // LTDC alternate function code = 0x0E
    mixin(LTDCPinL("A", "3"));
    mixin(LTDCPinL("A", "4"));
    mixin(LTDCPinL("A", "6"));
    mixin(LTDCPinH("A", "11"));
    mixin(LTDCPinH("A", "12"));
    
    mixin(LTDCPinL("B", "0"));
    mixin(LTDCPinL("B", "1"));
    mixin(LTDCPinH("B", "8"));
    mixin(LTDCPinH("B", "9"));
    mixin(LTDCPinH("B", "10"));
    mixin(LTDCPinH("B", "11"));
    
    mixin(LTDCPinL("C", "6"));
    mixin(LTDCPinL("C", "7"));
    mixin(LTDCPinH("C", "10"));
    
    mixin(LTDCPinH("F", "10"));
    
    mixin(LTDCPinL("G", "6"));
    mixin(LTDCPinL("G", "7"));
    mixin(LTDCPinH("G", "10"));
    mixin(LTDCPinH("G", "11"));
    mixin(LTDCPinH("G", "12"));
    
    
//     LTDC.SSCR.HSW.value = 29;
//     LTDC.SSCR.VSH.value = 2;
//     LTDC.BPCR.AHBP.value = 143;
//     LTDC.BPCR.AVBP.value = 34;
//     LTDC.AWCR.AAW.value = 783;
//     LTDC.AWCR.AAH.value = 514;
//     LTDC.TWCR.TOTAL.value = 799;
//     LTDC.TWCR.TOTAL.value = 524;
//     LTDC.GCR.HSPOL.value = true;  // active low
//     LTDC.GCR.VSPOL.value = true;  // active low
//     LTDC.GCR.DEPOL.value = true;  // active low
//     LTDC.GCR.PCPOL.value = false; // input pixel clock
    
    // background color black
//     LTDC.BCCR.BCBLUE = 0;
//     LTDC.BCCR.BCGREEN = 0;
//     LTDC.BCCR.BCRED = 0;
  
    while(true)
    {
        trace.writeLine("x");
    }
}