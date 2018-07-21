module board.statusLED;

nothrow:
@safe:

import stm32f42.rcc;
import stm32f42.gpio;

package void init()
{
    RCC.AHB1ENR.GPIOGEN     = true;
    GPIOG.OSPEEDR.OSPEEDR13 = 0b11;
    GPIOG.MODER.MODER13     = 0b01;
    GPIOG.OTYPER.OT13       = 0b00;
    GPIOG.PUPDR.PUPDR13     = 0b00;
}

public @inline pragma(inline, true) void on()
{
    GPIOG.ODR.ODR13 = true;
}

public @inline pragma(inline, true) void off()
{
    GPIOG.ODR.ODR13 = false;
}

public @inline pragma(inline, true) void toggle()
{
    GPIOG.ODR.ODR13 = !GPIOG.ODR.ODR13;
}