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

import stm32f42.gpio;
import stm32f42.rcc;
import stm32f42.ltdc;

import trace = stm32f42.trace;

__gshared ushort frameBuffer[240 * 320] = void;

package void init()
{	
//	// A3  = B5
//	// A4  = VSYNC
//	// A6  = G2
//	// A11 = R4
//	// A12 = R5
//	RCC.AHB1ENR.GPIOAEN.value = true;
//	
//	with(GPIOA.OSPEEDR)
//	{
//		setValue
//		!(
//			  OSPEEDR3,  0b11
//			, OSPEEDR4,  0b11
//			, OSPEEDR6,  0b11
//			, OSPEEDR11, 0b11
//			, OSPEEDR12, 0b11
//		);
//	}
//	
//	with(GPIOA.MODER)
//	{
//		setValue
//		!(
//			  MODER3,  0b11  // Alternate function mode
//			, MODER4,  0b11
//			, MODER6,  0b11
//			, MODER11, 0b11
//			, MODER12, 0b11
//		);
//	}
//	
//	with(GPIOA.PUPDR)
//	{
//		setValue
//		!(
//			  PUPDR3,  0b00  // No pull
//			, PUPDR4,  0b00
//			, PUPDR6,  0b00
//			, PUPDR11, 0b00
//			, PUPDR12, 0b00
//		);
//	}
//	
//	with(GPIOA.OTYPER)
//	{
//		setValue
//		!(
//			  OT3,  0  // push-pull
//			, OT4,  0
//			, OT6,  0
//			, OT11, 0
//			, OT12, 0
//		);
//	}
//	
//	with(GPIOA.AFRL)
//	{
//		setValue
//		!(
//			  AFRL3,  0x0E  // Alternate function LTDC
//			, AFRL4,  0x0E 
//			, AFRL6,  0x0E 
//		);
//	}
//	
//	with(GPIOA.AFRH)
//	{
//		setValue
//		!(
//			  AFRH11,  0x0E  // Alternate function LTDC
//			, AFRH12,  0x0E 
//		);
//	}
//	
//	// B0  = R3
//	// B1  = R6
//	// B8  = B6
//	// B9  = B7
//	// B10 = G4
//	// B11 = G5
//	RCC.AHB1ENR.GPIOBEN.value = true;
//	
//	with(GPIOB.OSPEEDR)
//	{
//		setValue
//		!(
//			  OSPEEDR0,  0b11
//			, OSPEEDR1,  0b11
//			, OSPEEDR8,  0b11
//			, OSPEEDR9,  0b11
//			, OSPEEDR10, 0b11
//			, OSPEEDR11, 0b11
//		);
//	}
//	
//	with(GPIOB.MODER)
//	{
//		setValue
//		!(
//			  MODER0,  0b11  // Alternate function mode
//			, MODER1,  0b11
//			, MODER8,  0b11
//			, MODER9,  0b11
//			, MODER10, 0b11
//			, MODER11, 0b11
//		);
//	}
//	
//	with(GPIOB.PUPDR)
//	{
//		setValue
//		!(
//			  PUPDR0,  0b00  // No pull
//			, PUPDR1,  0b00
//			, PUPDR8,  0b00
//			, PUPDR9,  0b00
//			, PUPDR10, 0b00
//			, PUPDR11, 0b00
//		);
//	}
//	
//	with(GPIOB.OTYPER)
//	{
//		setValue
//		!(
//			  OT0,  0  // push-pull
//			, OT1,  0
//			, OT8,  0
//			, OT9,  0
//			, OT10, 0
//			, OT11, 0
//		);
//	}
//	
//	with(GPIOB.AFRL)
//	{
//		setValue
//		!(
//			  AFRL0,  0x09  // Alternate function LTDC
//			, AFRL1,  0x09 
//		);
//	}
//	
//	with(GPIOB.AFRH)
//	{
//		setValue
//		!(
//			  AFRH8,  0x0E  // Alternate function LTDC
//			, AFRH9,  0x0E 
//			, AFRH10, 0x0E 
//			, AFRH11, 0x0E 
//		);
//	}
//	
//	// C6  = HSYNC
//	// C7  = G6
//	// C10 = R2
//	RCC.AHB1ENR.GPIOCEN.value = true;
//	
//	with(GPIOC.OSPEEDR)
//	{
//		setValue
//		!(
//			  OSPEEDR6,  0b11
//			, OSPEEDR7,  0b11
//			, OSPEEDR10, 0b11
//		);
//	}
//	
//	with(GPIOC.MODER)
//	{
//		setValue
//		!(
//			  MODER6,  0b11  // Alternate function mode
//			, MODER7,  0b11
//			, MODER10, 0b11
//		);
//	}
//	
//	with(GPIOC.PUPDR)
//	{
//		setValue
//		!(
//			  PUPDR6,  0b00  // No pull
//			, PUPDR7,  0b00
//			, PUPDR10, 0b00
//		);
//	}
//	
//	with(GPIOC.OTYPER)
//	{
//		setValue
//		!(
//			  OT6,  0  // push-pull
//			, OT7,  0
//			, OT10, 0
//		);
//	}
//	
//	with(GPIOC.AFRL)
//	{
//		setValue
//		!(
//			  AFRL6,  0x0E  // Alternate function LTDC
//			, AFRL7,  0x0E 
//		);
//	}
//	
//	GPIOC.AFRH.AFRH10.value = 0x0E;
//	
//	// D3  = G7
//	// D6  = B2
//	RCC.AHB1ENR.GPIODEN.value = true;
//	
//	with(GPIOD.OSPEEDR)
//	{
//		setValue
//		!(
//			  OSPEEDR3,  0b11
//			, OSPEEDR6,  0b11
//		);
//	}
//	
//	with(GPIOD.MODER)
//	{
//		setValue
//		!(
//			  MODER3,  0b11  // Alternate function mode
//			, MODER6,  0b11
//		);
//	}
//	
//	with(GPIOD.PUPDR)
//	{
//		setValue
//		!(
//			  PUPDR3,  0b00  // No pull
//			, PUPDR6,  0b00
//		);
//	}
//	
//	with(GPIOD.OTYPER)
//	{
//		setValue
//		!(
//			  OT3,  0  // push-pull
//			, OT6,  0
//		);
//	}
//	
//	with(GPIOD.AFRL)
//	{
//		setValue
//		!(
//			  AFRL3,  0x0E  // Alternate function LTDC
//			, AFRL6,  0x0E 
//		);
//	}
//	
//	RCC.AHB1ENR.GPIOFEN.value = true;
//	
//	// F10 = Enable
//	GPIOF.OSPEEDR.OSPEEDR10.value = 0b11;
//	GPIOF.MODER.MODER10.value = 0b11;
//	GPIOF.PUPDR.PUPDR10.value = 0b00;
//	GPIOF.OTYPER.OT10.value = 0;
//	GPIOF.AFRH.AFRH10.value = 0x0E;
//	
//	// G6  = R7
//	// G7  = DOTCLK
//	// G10 = G3
//	// G11 = B3
//	// G12 = B4
//	RCC.AHB1ENR.GPIOGEN.value = true;
//	
//	with(GPIOG.OSPEEDR)
//	{
//		setValue
//		!(
//			  OSPEEDR6,  0b11
//			, OSPEEDR7,  0b11
//			, OSPEEDR10, 0b11
//			, OSPEEDR11, 0b11
//			, OSPEEDR12, 0b11
//		);
//	}
//	
//	with(GPIOG.MODER)
//	{
//		setValue
//		!(
//			  MODER6,  0b11  // Alternate function mode
//			, MODER7,  0b11
//			, MODER10, 0b11
//			, MODER11, 0b11
//			, MODER12, 0b11
//		);
//	}
//	
//	with(GPIOG.PUPDR)
//	{
//		setValue
//		!(
//			  PUPDR6,  0b00  // No pull
//			, PUPDR7,  0b00
//			, PUPDR10, 0b00
//			, PUPDR11, 0b00
//			, PUPDR12, 0b00
//		);
//	}
//	
//	with(GPIOG.OTYPER)
//	{
//		setValue
//		!(
//			  OT6,  0  // push-pull
//			, OT7,  0
//			, OT10, 0
//			, OT11, 0
//			, OT12, 0
//		);
//	}
//	
//	with(GPIOG.AFRL)
//	{
//		setValue
//		!(
//			  AFRL6,  0x0E  // Alternate function LTDC
//			, AFRL7,  0x0E 
//		);
//	}
//	
//	with(GPIOG.AFRH)
//	{
//		setValue
//		!(
//			  AFRH10, 0x09  // Alternate function LTDC
//			, AFRH11, 0x0E 
//			, AFRH12, 0x09 
//		);
//	}
	
	RCC.APB2ENR.LTDCEN.value = true;
	RCC.AHB1ENR.DMA2DEN.value = true;
	
	with(LTDC.GCR)
	{
		setValue
		!(
			  HSPOL, 0  // active low
			, VSPOL, 0  // active low
			, DEPOL, 0  // active low
			, PCPOL, 0  // input pixel clock
		);
	}
	
	with(LTDC.BCCR)
	{
		setValue
		!(
			  BCBLUE, 0  
			, BCBLUE, 0  
			, BCBLUE, 0  
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
	
	RCC.DCKCFGR.PLLSAIDIVR.value = 0b10; //divide by 8;
	
	RCC.CR.PLLISAION.value = true; 
	while(!RCC.CR.PLLSAIRDY.value) { }
	
	with(LTDC.SSCR)
	{
		setValue
		!(
			  HSW, 9 
			, VSH, 1  
		);
	}
	
	with(LTDC.BPCR)
	{
		setValue
		!(
			  AHBP, 29 
			, AVBP, 3  
		);
	}

	with(LTDC.AWCR)
	{
		setValue
		!(
			  AAW, 269 
			, AAH, 323  
		);
	}

	with(LTDC.TWCR)
	{
		setValue
		!(
			  TOTALW, 279 
			, TOTALH, 327  
		);
	}	
	
	//Layer configuration
	with(LTDC.L1WHPCR)
	{
		setValue
		!(
			  WHSTPOS, 30 
			, WHSPPOS, 269  
		);
	}
	
	with(LTDC.L1WVPCR)
	{
		setValue
		!(
			  WVSTPOS, 4 
			, WVSPPOS, 323  
		);
	}
	
	LTDC.L1PFCR.PF.value = 0b010;  //RGB565
	LTDC.L1CACR.CONSTA.value = 0xFF;
	
	with(LTDC.L1DCCR)
	{
		setValue
		!(
			  DCALPHA, 0 
			, DCRED,   0  
			, DCGREEN, 0  
			, DCBLUE,  0  
		);
	}
	
	with(LTDC.L1BFCR)
	{
		setValue
		!(
			  BF1, 0b101  // constant alpha
			, BF2, 0b101  // constant alpha
		);
	}
	
	/* the length of one line of pixels in bytes + 3 then :
    Line Length = Active high width x number of bytes per pixel + 3 
    Active high width         = LCD_PIXEL_WIDTH 
    number of bytes per pixel = 2    (pixel_format : RGB565) 
    */
	with(LTDC.L1CFBLR)
	{
		setValue
		!(
			  CFBLL, 240 * 2 + 3  
			, CFBP,  240 * 2
		);
	}
	
	LTDC.L1CFBLNR.CFBLNBR.value = 320;
	
	LTDC.L1CFBAR.CFBADD.value = cast(uint)(frameBuffer.ptr);
	
	LTDC.GCR.DEN.value = true;      //enable dithering
	
	LTDC.L1CR.LEN.value = true;     //enable layer
	LTDC.SRCR.IMR.value = 1;        //reload configuration
	
	LTDC.GCR.LTDCEN.value = true;   //enable controller
}

package void fill(ushort color)
{
	for(int i = 0; i < 10000; i++)
	{
		frameBuffer[i] = color;
	}
}
