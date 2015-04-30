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

module board.spi5;

import stm32f42.rcc;
import stm32f42.gpio;
import stm32f42.spi;

import trace = stm32f42.trace;

package void init()
{
	RCC.AHB1ENR.GPIOFEN.value = true;
	
	//Pins F7,F8,F9 speed
	with(GPIOF.OSPEEDR)
	{
		setValue
		!(
			  OSPEEDR7, 0b11
			, OSPEEDR9, 0b11
		);
	}
	
	//Pins F7,F8,F9 Alternate Function Mode
	with(GPIOF.MODER)
	{
		setValue
		!(
			  MODER7, 0b10
			, MODER9, 0b10
		);
	}
	
	//Pins F7,F8,F9 no pull
	with(GPIOF.PUPDR)
	{
		setValue
		!(
			  PUPDR7, 0b00
			, PUPDR9, 0b00
		);
	}
    
    //Pins F7,F8,F9 push-pull
	with(GPIOF.OTYPER)
	{
		setValue
		!(
			  OT7, 0b00
			, OT9, 0b00
		);
	}
	
	// alternate function SPI5
	GPIOF.AFRL.AFRL7.value = 0x05;  
	GPIOF.AFRH.AFRH9.value = 0x05;
		
	RCC.APB2ENR.SPI5EN.value = true;
	
	// disable before configuring
	SPI5.CR1.SPE.value = false;
	
	SPI5.I2SCFGR.I2SMOD.value = 0;  //SPI mode
	
	with(SPI5.CR2)
	{
		setValue
		!(
			  SSOE, 1      
			, FRF,  0   // Motorola mode
		);
	}
	
	with(SPI5.CR1)
	{
		setValue
		!(
			  BIDIMODE, 0       // two-line unidirectional
			, BR,       0b001   // fPCLK/16
			, CPHA,     0       // clock phase first edge
			, CPOL,     0       // clock polarity low
			, DFF,      0       // 8-bit data frame format
			, LSBFIRST, 0       // MSB first
			, SSM,      false   // Software slave management
			, MSTR,     1       // master mode
			, CRCEN,    false   // disable CRC
		);
	}

	//enable
	SPI5.CR1.SPE.value = true;
}

package void transmit(ubyte value)
{	
	//wait until TX register is empty
	while(!SPI5.SR.TXE.value) {}
	
	// transmit a new byte
	SPI5.DR.DR.value = value;
}