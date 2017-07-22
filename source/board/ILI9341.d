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

module board.ILI9341;

import stm32f42.gpio;
import stm32f42.rcc;

import spi5 = board.spi5;
import trace = stm32f42.trace;
import statusLED = board.statusLED;

private void csLow()
{
	GPIOC.ODR.ODR2.value = 0;
}

private void csHigh()
{
	GPIOC.ODR.ODR2.value = 1;
}

private void csInit()
{
	RCC.AHB1ENR.GPIOCEN.value = true;
	
	GPIOC.MODER.MODER2.value = 0b01;      // output
	GPIOC.PUPDR.PUPDR2.value = 0b00;      // no pull
	GPIOC.OSPEEDR.OSPEEDR2.value = 0b11;
	GPIOC.OTYPER.OT2.value = 0b00;        // push-pull
}

private void wrxLow()
{
	GPIOD.ODR.ODR13.value = 0;
}

private void wrxHigh()
{
	GPIOD.ODR.ODR13.value = 1;
}

private void wrxInit()
{
	RCC.AHB1ENR.GPIODEN.value = true;
	
	GPIOD.MODER.MODER13.value = 0b01;      // output
	GPIOD.PUPDR.PUPDR13.value = 0b00;      // no pull
	GPIOD.OSPEEDR.OSPEEDR13.value = 0b11;
	GPIOD.OTYPER.OT13.value = 0b00;        // push-pull
}

private void rdxLow()
{
	GPIOD.ODR.ODR12.value = 0;
}

private void rdxHigh()
{
	GPIOD.ODR.ODR12.value = 1;
}

private void rdxInit()
{
	RCC.AHB1ENR.GPIODEN.value = true;
	
	GPIOD.MODER.MODER12.value = 0b01;      // output
	GPIOD.PUPDR.PUPDR12.value = 0b00;      // no pull
	GPIOD.OSPEEDR.OSPEEDR12.value = 0b11;
	GPIOD.OTYPER.OT12.value = 0b00;        // push-pull
}

private void writeCommand(ubyte value)
{
	wrxLow();  // low to send command
	csLow();
	
	spi5.transmit(value);
}

private void write(ubyte command)
{
	writeCommand(command);
	csHigh();
	wrxLow();
}

private void write(ubyte command, ubyte arg0)
{
	writeCommand(command);
	
	wrxHigh();  // high to send data
	spi5.transmit(arg0);
	csHigh();
	wrxLow();
}

private void write(ubyte command, ubyte arg0, ubyte arg1)
{
	writeCommand(command);
	
	wrxHigh();  // high to send data
	spi5.transmit(arg0);
	spi5.transmit(arg1);
	csHigh();
	wrxLow();
}

private void write(ubyte command, ubyte arg0, ubyte arg1, ubyte arg2)
{
	writeCommand(command);
	
	wrxHigh();  // high to send data
	spi5.transmit(arg0);
	spi5.transmit(arg1);
	spi5.transmit(arg2);
	csHigh();
	wrxLow();
}

private void write(ubyte command, ubyte arg0, ubyte arg1, ubyte arg2, ubyte arg3)
{
	writeCommand(command);
	
	wrxHigh();  // high to send data
	spi5.transmit(arg0);
	spi5.transmit(arg1);
	spi5.transmit(arg2);
	spi5.transmit(arg3);
	csHigh();
	wrxLow();
}

private void write(ubyte command, ubyte arg0, ubyte arg1, ubyte arg2, ubyte arg3, ubyte arg4)
{
	writeCommand(command);
	
	wrxHigh();  // high to send data
	spi5.transmit(arg0);
	spi5.transmit(arg1);
	spi5.transmit(arg2);
	spi5.transmit(arg3);
	spi5.transmit(arg4);
	csHigh();
	wrxLow();
}

package void init()
{	
	wrxInit();
	rdxInit();
	csInit();
	
	csLow();
	csHigh();
	
	spi5.init();
	
	rdxHigh();
	
	//Reset
    //write(0x01);
	//trace.writeLine("Reset");
	
	write(0xCA, 0xC3, 0x08, 0x50);
	
	//PowerB
	write(0xCF, 0x00, 0xC1, 0x30);
	
	//Power_SEQ
	write(0xED, 0x64, 0x03, 0x12, 0x81);
	
	//DTCA
	write(0xE8, 0x85, 0x00, 0x78);
	
    //PowerA		
	write(0xCB, 0x39, 0x2C, 0x00, 0x34, 0x02);
	
	//PRC
	write(0xF7, 0x20);
	
	//DTCB
	write(0xEA, 0x00, 0x00);
	
	//FRMCTR1
	write(0xB1, 0x00, 0x1B);
	
	//DFC
	write(0xB6, 0x0A, 0xA2);
	
	//POWER1
	write(0xC0, 0x23);
	
	//POWER2
	write(0xC1, 0x10);
	
	//VCOM1
	write(0xC5, 0x45, 0x15);
	
	//VCOM2
	write(0xC7, 0x90);
	
	//MAC
	write(0x36, 0xC8);
	
	//Pixel Format
	//write(0x3A, 0x55);
	
	//3GAMMA
	write(0xF2, 0x00);
	
	//FRC
	write(0xB1, 0x00, 0x18);
	
	//RGB Interface
	write(0xB0, 0xC2);
		
	//DFC
	write(0xB6, 0x0A, 0xA7, 0x27, 0x04);
	
	//Column address
	write(0x2A, 0x00, 0x00, 0x00, 0xEF);
	
	//Page address
	write(0x2B, 0x00, 0x00, 0x01, 0x3F);
	
	//LCD interface
	write(0xF6, 0x01, 0x00, 0x06);
	
	//GRAM
	write(0x2C);
	//trace.writeLine("GRAM");
	
	//GAMMA
	write(0x26, 0x01);
	
	//PGAMMA
	writeCommand(0xE0);
	wrxHigh();  // high to send data
	spi5.transmit(0x0F);
	spi5.transmit(0x29);
	spi5.transmit(0x24);
	spi5.transmit(0x0C);
	spi5.transmit(0x0E);
	spi5.transmit(0x09);
	spi5.transmit(0x4E);
	spi5.transmit(0x78);
	spi5.transmit(0x3C);
	spi5.transmit(0x09);
	spi5.transmit(0x13);
	spi5.transmit(0x05);
	spi5.transmit(0x17);
	spi5.transmit(0x11);
	spi5.transmit(0x00);
	csHigh();
	wrxLow();
	
	//NGAMMA
	writeCommand(0xE1);
	wrxHigh();  // high to send data
	spi5.transmit(0x00);
	spi5.transmit(0x16);
	spi5.transmit(0x1B);
	spi5.transmit(0x04);
	spi5.transmit(0x11);
	spi5.transmit(0x07);
	spi5.transmit(0x31);
	spi5.transmit(0x33);
	spi5.transmit(0x42);
	spi5.transmit(0x05);
	spi5.transmit(0x0C);
	spi5.transmit(0x0A);
	spi5.transmit(0x28);
	spi5.transmit(0x2F);
	spi5.transmit(0x0F);
	csHigh();
	wrxLow();
	
	
	//Sleep out
	write(0x11);
	//Delay 1000000;
	//trace.writeLine("Delay");
	
	//Display On
	write(0x29);

	//GRAM
	//write(0x2C);
}