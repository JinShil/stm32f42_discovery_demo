module board.statusLED;

import stm32f42.rcc;
import stm32f42.gpio;

import gcc.attribute;

package void init()
{
	RCC.AHB1ENR.GPIOGEN.value     = true;
    GPIOG.OSPEEDR.OSPEEDR13.value = 0b11;
    GPIOG.MODER.MODER13.value     = 0b01;
    GPIOG.OTYPER.OT13.value       = 0b00;
    GPIOG.PUPDR.PUPDR13.value     = 0b00;
}

public @inline void on()
{
	GPIOG.ODR.ODR13.value = true;
}

public @inline void off()
{
	GPIOG.ODR.ODR13.value = false;
}

public @inline void toggle()
{
	GPIOG.ODR.ODR13.value = !GPIOG.ODR.ODR13.value;
}