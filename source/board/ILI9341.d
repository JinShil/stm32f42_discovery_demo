module board.ILI9341;

import stm32f42.gpio;
import stm32f42.rcc;

import spi5 = board.spi5;

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

private void gpioConfig()
{
	RCC.APB2ENR.LTDCEN.value = true;
	
	// A3  = B5
	// A4  = VSYNC
	// A6  = G2
	// A11 = R4
	// A12 = R5
	RCC.AHB1ENR.GPIOAEN.value = true;
	
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
			  MODER3,  0b11  // Alternate function mode
			, MODER4,  0b11
			, MODER6,  0b11
			, MODER11, 0b11
			, MODER12, 0b11
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
	
	// B0  = R3
	// B1  = R6
	// B8  = B6
	// B9  = B7
	// B10 = G4
	// B11 = G5
	RCC.AHB1ENR.GPIOBEN.value = true;
	
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
			  MODER0,  0b11  // Alternate function mode
			, MODER1,  0b11
			, MODER8,  0b11
			, MODER9,  0b11
			, MODER10, 0b11
			, MODER11, 0b11
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
	
	// C6  = HSYNC
	// C7  = G6
	// C10 = R2
	RCC.AHB1ENR.GPIOCEN.value = true;
	
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
			  MODER6,  0b11  // Alternate function mode
			, MODER7,  0b11
			, MODER10, 0b11
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
	
	// D3  = G7
	// D6  = B2
	RCC.AHB1ENR.GPIODEN.value = true;
	
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
			  MODER3,  0b11  // Alternate function mode
			, MODER6,  0b11
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
	
	RCC.AHB1ENR.GPIOFEN.value = true;
	
	// F10 = Enable
	GPIOF.OSPEEDR.OSPEEDR10.value = 0b11;
	GPIOF.MODER.MODER10.value = 0b11;
	GPIOF.PUPDR.PUPDR10.value = 0b00;
	GPIOF.OTYPER.OT10.value = 0;
	
	// G6  = R7
	// G7  = DOTCLK
	// G10 = G3
	// G11 = B3
	// G12 = B4
	RCC.AHB1ENR.GPIOGEN.value = true;
	
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
			  MODER6,  0b11  // Alternate function mode
			, MODER7,  0b11
			, MODER10, 0b11
			, MODER11, 0b11
			, MODER12, 0b11
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
	
	//TODO: Need to set alternate functions
	
}

public void init()
{
	gpioConfig();
	
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
	
	//Display On
	writeCommand(0x29);
	
	//GRAM
	writeCommand(0x2C);
}