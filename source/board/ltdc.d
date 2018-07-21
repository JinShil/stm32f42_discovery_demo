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

module board.ltdc;

nothrow:
@safe:

import stm32f42.gpio;
import stm32f42.rcc;
import stm32f42.ltdc;

import trace = stm32f42.trace;

private enum width  = 240;
private enum height = 320;

__gshared ushort[width * height] frameBuffer = void;

private @inline pragma(inline, true) ushort[] getFrameBuffer() @trusted
{
    return frameBuffer;
}

@inline pragma(inline, true) package uint getWidth()
{
    return width;
}

@inline pragma(inline, true) package uint getHeight()
{
    return height;
}

package void init()
{
    // A3  = B5
    // A4  = VSYNC
    // A6  = G2
    // A11 = R4
    // A12 = R5
    RCC.AHB1ENR.GPIOAEN = true;

    with(GPIOA.OSPEEDR)
    {
        setValue
        !(
              OSPEEDR3,  0b11
            , OSPEEDR4,  0b11
            , OSPEEDR6,  0b11
            , OSPEEDR11, 0b11
            , OSPEEDR12, 0b11
        );
    }

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

    with(GPIOA.PUPDR)
    {
        setValue
        !(
              PUPDR3,  0b00  // No pull
            , PUPDR4,  0b00
            , PUPDR6,  0b00
            , PUPDR11, 0b00
            , PUPDR12, 0b00
        );
    }

    with(GPIOA.OTYPER)
    {
        setValue
        !(
              OT3,  0  // push-pull
            , OT4,  0
            , OT6,  0
            , OT11, 0
            , OT12, 0
        );
    }

    with(GPIOA.AFRL)
    {
        setValue
        !(
              AFRL3,  0x0E  // Alternate function LTDC
            , AFRL4,  0x0E
            , AFRL6,  0x0E
        );
    }

    with(GPIOA.AFRH)
    {
        setValue
        !(
              AFRH11,  0x0E  // Alternate function LTDC
            , AFRH12,  0x0E
        );
    }

    // B0  = R3
    // B1  = R6
    // B8  = B6
    // B9  = B7
    // B10 = G4
    // B11 = G5
    RCC.AHB1ENR.GPIOBEN = true;

    with(GPIOB.OSPEEDR)
    {
        setValue
        !(
              OSPEEDR0,  0b11
            , OSPEEDR1,  0b11
            , OSPEEDR8,  0b11
            , OSPEEDR9,  0b11
            , OSPEEDR10, 0b11
            , OSPEEDR11, 0b11
        );
    }

    with(GPIOB.MODER)
    {
        setValue
        !(
              MODER0,  0b10  // Alternate function mode
            , MODER1,  0b10
            , MODER8,  0b10
            , MODER9,  0b10
            , MODER10, 0b10
            , MODER11, 0b10
        );
    }

    with(GPIOB.PUPDR)
    {
        setValue
        !(
              PUPDR0,  0b00  // No pull
            , PUPDR1,  0b00
            , PUPDR8,  0b00
            , PUPDR9,  0b00
            , PUPDR10, 0b00
            , PUPDR11, 0b00
        );
    }

    with(GPIOB.OTYPER)
    {
        setValue
        !(
              OT0,  0  // push-pull
            , OT1,  0
            , OT8,  0
            , OT9,  0
            , OT10, 0
            , OT11, 0
        );
    }

    with(GPIOB.AFRL)
    {
        setValue
        !(
              AFRL0,  0x09  // Alternate function LTDC
            , AFRL1,  0x09
        );
    }

    with(GPIOB.AFRH)
    {
        setValue
        !(
              AFRH8,  0x0E  // Alternate function LTDC
            , AFRH9,  0x0E
            , AFRH10, 0x0E
            , AFRH11, 0x0E
        );
    }

    // C6  = HSYNC
    // C7  = G6
    // C10 = R2
    RCC.AHB1ENR.GPIOCEN = true;

    with(GPIOC.OSPEEDR)
    {
        setValue
        !(
              OSPEEDR6,  0b11
            , OSPEEDR7,  0b11
            , OSPEEDR10, 0b11
        );
    }

    with(GPIOC.MODER)
    {
        setValue
        !(
              MODER6,  0b10  // Alternate function mode
            , MODER7,  0b10
            , MODER10, 0b10
        );
    }

    with(GPIOC.PUPDR)
    {
        setValue
        !(
              PUPDR6,  0b00  // No pull
            , PUPDR7,  0b00
            , PUPDR10, 0b00
        );
    }

    with(GPIOC.OTYPER)
    {
        setValue
        !(
              OT6,  0  // push-pull
            , OT7,  0
            , OT10, 0
        );
    }

    with(GPIOC.AFRL)
    {
        setValue
        !(
              AFRL6,  0x0E  // Alternate function LTDC
            , AFRL7,  0x0E
        );
    }

    GPIOC.AFRH.AFRH10 = 0x0E;

    // D3  = G7
    // D6  = B2
    RCC.AHB1ENR.GPIODEN = true;

    with(GPIOD.OSPEEDR)
    {
        setValue
        !(
              OSPEEDR3,  0b11
            , OSPEEDR6,  0b11
        );
    }

    with(GPIOD.MODER)
    {
        setValue
        !(
              MODER3,  0b10  // Alternate function mode
            , MODER6,  0b10
        );
    }

    with(GPIOD.PUPDR)
    {
        setValue
        !(
              PUPDR3,  0b00  // No pull
            , PUPDR6,  0b00
        );
    }

    with(GPIOD.OTYPER)
    {
        setValue
        !(
              OT3,  0  // push-pull
            , OT6,  0
        );
    }

    with(GPIOD.AFRL)
    {
        setValue
        !(
              AFRL3,  0x0E  // Alternate function LTDC
            , AFRL6,  0x0E
        );
    }

    RCC.AHB1ENR.GPIOFEN = true;

    // F10 = Data Enable
    GPIOF.OSPEEDR.OSPEEDR10 = 0b10;
    GPIOF.MODER.MODER10 = 0b10;
    GPIOF.PUPDR.PUPDR10 = 0b00;
    GPIOF.OTYPER.OT10 = 0;
    GPIOF.AFRH.AFRH10 = 0x0E;

    // G6  = R7
    // G7  = DOTCLK
    // G10 = G3
    // G11 = B3
    // G12 = B4
    RCC.AHB1ENR.GPIOGEN = true;

    with(GPIOG.OSPEEDR)
    {
        setValue
        !(
              OSPEEDR6,  0b11
            , OSPEEDR7,  0b11
            , OSPEEDR10, 0b11
            , OSPEEDR11, 0b11
            , OSPEEDR12, 0b11
        );
    }

    with(GPIOG.MODER)
    {
        setValue
        !(
              MODER6,  0b10  // Alternate function mode
            , MODER7,  0b10
            , MODER10, 0b10
            , MODER11, 0b10
            , MODER12, 0b10
        );
    }

    with(GPIOG.PUPDR)
    {
        setValue
        !(
              PUPDR6,  0b00  // No pull
            , PUPDR7,  0b00
            , PUPDR10, 0b00
            , PUPDR11, 0b00
            , PUPDR12, 0b00
        );
    }

    with(GPIOG.OTYPER)
    {
        setValue
        !(
              OT6,  0  // push-pull
            , OT7,  0
            , OT10, 0
            , OT11, 0
            , OT12, 0
        );
    }

    with(GPIOG.AFRL)
    {
        setValue
        !(
              AFRL6,  0x0E  // Alternate function LTDC
            , AFRL7,  0x0E
        );
    }

    with(GPIOG.AFRH)
    {
        setValue
        !(
              AFRH10, 0x09  // Alternate function LTDC
            , AFRH11, 0x0E
            , AFRH12, 0x09
        );
    }

    /* Enable Pixel Clock */
    /* PLLSAI_VCO Input = HSE_VALUE/PLL_M = 1 Mhz */
    /* PLLSAI_VCO Output = PLLSAI_VCO Input * PLLSAI_N = 192 Mhz */
    /* PLLLCDCLK = PLLSAI_VCO Output/PLLSAI_R = 192/4 = 96 Mhz */
    /* LTDC clock frequency = PLLLCDCLK / RCC_PLLSAIDivR = 96/4 = 24 Mhz */
    with(RCC.PLLSAICFGR)
    {
        setValue
        !(
              PLLSAIN, 192
            //, PLLSAIQ, 7
            , PLLSAIR, 4
        );
    }

    RCC.DCKCFGR.PLLSAIDIVR = 0b10; //divide by 4

    RCC.CR.PLLISAION = true;
    while(!RCC.CR.PLLSAIRDY) { }

    RCC.APB2ENR.LTDCEN = true;

    enum hsync  = 10;
    enum hbp    = 20;
    enum hfp    = 20;

    enum vsync  = 2;
    enum vbp    = 2;
    enum vfp    = 4;

    with(LTDC.SSCR)
    {
        setValue
        !(
              HSW, hsync - 1
            , VSH, vsync - 1
        );
    }

    with(LTDC.BPCR)
    {
        setValue
        !(
              AHBP, hsync + hbp - 1
            , AVBP, vsync + vbp - 1
        );
    }

    with(LTDC.AWCR)
    {
        setValue
        !(
              AAW, hsync + hbp + width - 1
            , AAH, vsync + vbp + height - 1
        );
    }

    with(LTDC.TWCR)
    {
        setValue
        !(
              TOTALW, hsync + hbp + width + hfp - 1
            , TOTALH, vsync + vbp + height + vfp - 1
        );
    }

    with(LTDC.GCR)
    {
        setValue
        !(
              HSPOL, 0  // active low
            , VSPOL, 0  // active low
            , DEPOL, 0  // active low
            , PCPOL, 1  // active high
        );
    }

    with(LTDC.BCCR)
    {
        setValue
        !(
              BCRED,   0xFF
            , BCGREEN, 0
            , BCBLUE,  0
        );
    }

    //Layer1 configuration
    with(LTDC.L1WHPCR)
    {
        setValue
        !(
              WHSTPOS, hsync + hbp
            , WHSPPOS, hsync + hbp + width - 1
        );
    }

    with(LTDC.L1WVPCR)
    {
        setValue
        !(
              WVSTPOS, vsync + vbp
            , WVSPPOS, vsync + vbp + height - 1
        );
    }

    LTDC.L1PFCR.PF = 0b010;      //RGB565
    LTDC.L1CACR.CONSTA = 0xFF;

    with(LTDC.L1BFCR)
    {
        setValue
        !(
              BF1, 0b100  // constant alpha
            , BF2, 0b100  // constant alpha
        );
    }

    LTDC.L1CFBAR.CFBADD = cast(uint)(getFrameBuffer().ptr);

    /* the length of one line of pixels in bytes + 3 then :
    Line Length = Active high width x number of bytes per pixel + 3
    Active high width         = LCD_PIXEL_WIDTH
    number of bytes per pixel = 2    (pixel_format : RGB565)
    */
    with(LTDC.L1CFBLR)
    {
        setValue
        !(
              CFBLL, width * 2 + 3
            , CFBP,  width * 2
        );
    }

    LTDC.L1CFBLNR.CFBLNBR = height;

    LTDC.GCR.DEN = true;      //enable dithering

    LTDC.L1CR.LEN = true;     //enable layer 1

    LTDC.SRCR.IMR = true;     //reload configuration

    LTDC.GCR.LTDCEN = true;   //enable controller
}

package void fillSpan(int x, int y, uint spanWidth, ushort color)
{
    int start = y * width + x;
    for(int i = 0; i < spanWidth; i++)
    {
        getFrameBuffer()[start + i] = color;
    }
}
