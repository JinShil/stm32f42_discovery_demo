module board.statusLED;

import stm32f42.rcc;
import stm32f42.gpio;

import gcc.attribute;

package void init()
{
	RCC.AHB1ENR.GPIOGEN     = true;
    GPIOG.OSPEEDR.OSPEEDR13 = 0b11;
    GPIOG.MODER.MODER13     = 0b01;
    GPIOG.OTYPER.OT13       = 0b00;
    GPIOG.PUPDR.PUPDR13     = 0b00;
}

public @inline void on()
{
	GPIOG.ODR.ODR13 = true;
}

public @inline void off()
{
	GPIOG.ODR.ODR13 = false;
}

public @inline void toggle()
{
	GPIOG.ODR.ODR13.value = !GPIOG.ODR.ODR13.value;
}