module board.spi5;

import stm32f42.rcc;
import stm32f42.gpio;
import stm32f42.spi;

public void init()
{
	RCC.APB2ENR.SPI5EN.value = true;
	RCC.AHB1ENR.GPIOFEN.value = true;
	
	//Pins F7,F8,F9 Alternate Function Mode
	with(GPIOF.MODER)
	{
		setValue
		!(
			  MODER7, 0b11
			, MODER8, 0b11
			, MODER9, 0b11
		);
	}
	
	//Pins F7,F8,F9 Pull Down
	with(GPIOF.PUPDR)
	{
		setValue
		!(
			  PUPDR7, 0b10
			, PUPDR8, 0b10
			, PUPDR9, 0b10
		);
	}
	
	//Pins F7,F8,F9 speed
	with(GPIOF.OSPEEDR)
	{
		setValue
		!(
			  OSPEEDR7, 0b11
			, OSPEEDR8, 0b11
			, OSPEEDR9, 0b11
		);
	}
    
    //Pins F7,F8,F9 push-pull
	with(GPIOF.OTYPER)
	{
		setValue
		!(
			  OT7, 0b00
			, OT8, 0b00
			, OT9, 0b00
		);
	}
	
	//TODO: Need to set alternate function
	
	// disable before configuring
	SPI5.CR1.SPE.value = false;
	
	/* SPI baudrate is set to 5.6 MHz (PCLK2/SPI_BaudRatePrescaler = 90/16 = 5.625 MHz) 
       to verify these constraints:
       - ILI9341 LCD SPI interface max baudrate is 10MHz for write and 6.66MHz for read
       - l3gd20 SPI interface max baudrate is 10MHz for write/read
       - PCLK2 frequency is set to 90 MHz 
    */  
	with(SPI5.CR1)
	{
		setValue
		!(
			  BIDIMODE, 0       // two-line unidirectional
			, BR,       0b011   // fPCLK/16
			, CPHA,     0       // clock phase first edge
			, CPOL,     0       // clock polarity low
			, DFF,      0       // 8-bit data frame format
			, LSBFIRST, 0       // MSB first
			, SSM,      true    // Software slave management
			, MSTR,     1       // master mode
		);
	}
	
	SPI5.CR2.FRF.value = 0;     // Motorola mode
	
	//enable
	SPI5.CR1.SPE.value = true;
}

void transmit(ubyte value)
{
	//wait until TX register is empty
	while(!SPI5.SR.TXE.value) {}
	
	// transmit a new byte
	SPI5.DR.DR.value = value;
}