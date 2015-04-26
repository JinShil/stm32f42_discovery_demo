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

module main;

import stm32f42.rcc;
import stm32f42.gpio;
import trace = stm32f42.trace;

void main()
{        
     // blinky
    RCC.AHB1ENR.GPIOGEN.value     = true;
    GPIOG.OSPEEDR.OSPEEDR13.value = 0b11;
    GPIOG.MODER.MODER13.value     = 0b01;
    GPIOG.OTYPER.OT13.value       = 0b00;
    GPIOG.PUPDR.PUPDR13.value     = 0b00;

    while(true)
    {
        GPIOG.ODR.ODR13.value = !GPIOG.ODR.ODR13.value;
        trace.writeLine("x"); //mostly for delay
    }
}