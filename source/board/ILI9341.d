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
	GPIOD.ODR.ODR13.value = 0;
}

private void rdxHigh()
{
	GPIOD.ODR.ODR13.value = 1;
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
	
	csHigh();
}

private void writeData(ubyte value)
{
	wrxHigh();  // high to send data
	csLow();
	
	spi5.transmit(value);
	
	csHigh();
}

private void write(ubyte command, ubyte arg0)
{
	writeCommand(command);
	writeData(arg0);
}

private void write(ubyte command, ubyte arg0, ubyte arg1)
{
	write(command, arg0);
	writeData(arg1);
}

private void write(ubyte command, ubyte arg0, ubyte arg1, ubyte arg2)
{
	write(command, arg0, arg1);
	writeData(arg2);
}

private void write(ubyte command, ubyte arg0, ubyte arg1, ubyte arg2, ubyte arg3)
{
	write(command, arg0, arg1, arg2);
	writeData(arg3);
}

private void write(ubyte command, ubyte arg0, ubyte arg1, ubyte arg2, ubyte arg3, ubyte arg4)
{
	write(command, arg0, arg1, arg2, arg3);
	writeData(arg4);
}

package void init()
{	
	wrxInit();
	rdxInit();
	csInit();
	
	csLow();
	csHigh();
	
	spi5.init();
		
	write(0xCA, 0xC3, 0x08, 0x50);
	
	//PowerB
	write(0xCF, 0x00, 0xC1, 0x30);
	
	//Power_SEQ
	write(0xED, 0x64, 0x03, 0x12, 0x81);
	
	//DTCA
	write(0xE8, 0x85, 0x00, 0x78);
	
	//POWERA
	write(0xCB, 0x39, 0x2C, 0x00, 0x34, 0x02);
	
	//PRC
	write(0xF7, 0x20);
	
	//DTCB
	write(0xEA, 0x00, 0x00);
	
	//FRC
	write(0xB1, 0x00, 0x1B);
	
	//DFC
	write(0xB6, 0x0A, 0xA2);
	
	//POWER1
	write(0xC0, 0x10);
	
	//POWER2
	write(0xC1, 0x10);
	
	//VCOM1
	write(0xC5, 0x45, 0x15);
	
	//VCOM2
	write(0xC7, 0x90);
	
	//MAC
	write(0x36, 0xC8);
	
	//3GAMMA
	write(0xF2, 0x00);
	
	//RGB Interface
	write(0xB0, 0xC2);
	
	//DFC
	write(0xB6, 0x0A, 0xA7, 0x27, 0x04);
	
	//Column address
	write(0x2A, 0x00, 0x00, 0x00, 0xEF);
	
	//Page address
	write(0x2B, 0x00, 0x00, 0x01, 0x3F);
	
	//Interface
	write(0xF6, 0x01, 0x00, 0x06);
	
	//GRAM
	writeCommand(0x2C);
	//Delay 1000000
	trace.writeLine("Delay");
	
	//GAMMA
	write(0x26, 0x01);
	
	//PGAMMA
	writeCommand(0xE0);
	writeData(0x0f);
	writeData(0x29);
	writeData(0x24);
	writeData(0x0C);
	writeData(0x0E);
	writeData(0x09);
	writeData(0x4E);
	writeData(0x78);
	writeData(0x3C);
	writeData(0x09);
	writeData(0x13);
	writeData(0x05);
	writeData(0x17);
	writeData(0x11);
	writeData(0x00);
	
	//NGAMMA
	writeCommand(0xE1);
	writeData(0x00);
	writeData(0x16);
	writeData(0x1B);
	writeData(0x04);
	writeData(0x11);
	writeData(0x07);
	writeData(0x31);
	writeData(0x33);
	writeData(0x42);
	writeData(0x05);
	writeData(0x0C);
	writeData(0x0A);
	writeData(0x28);
	writeData(0x2F);
	writeData(0x0F);
	
	//Sleep out
	writeCommand(0x11);
	//Delay 1000000;
	trace.writeLine("Delay");
	
	//Display On
	writeCommand(0x29);
	
	//GRAM
	writeCommand(0x2C);
}

public void on()
{
	writeCommand(0x29);
}

public void off()
{
	writeCommand(0x28);
}