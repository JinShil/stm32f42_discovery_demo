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

nothrow:
@safe:

import stm32f42.rcc;
import stm32f42.gpio;
import stm32f42.spi;

import trace = stm32f42.trace;

package void init()
{
    RCC.APB2ENR.SPI5EN = true;
    RCC.AHB1ENR.GPIOFEN = true;

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

    //Pins F7,F8,F9 Alternate Function Mode
    with(GPIOF.MODER)
    {
        setValue
        !(
              MODER7, 0b10
            , MODER8, 0b10
            , MODER9, 0b10
        );
    }

    //Pins F7,F8,F9 no pull
    with(GPIOF.PUPDR)
    {
        setValue
        !(
              PUPDR7, 0b00
            , PUPDR8, 0b00
            , PUPDR9, 0b00
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

    // alternate function SPI5
    GPIOF.AFRL.AFRL7 = 0x05;
    GPIOF.AFRH.AFRH8 = 0x05;
    GPIOF.AFRH.AFRH9 = 0x05;

    // disable before configuring
    SPI5.CR1.SPE = false;


    with(SPI5.CR1)
    {
        setValue
        !(
              BIDIMODE, 0       // two-line unidirectional
            , BR,       0b100   // fPCLK/32
            , SSM,      1       // Software slave management
            , MSTR,     1       // master mode
        );
    }

    // Needed because of SSM
    SPI5.CR2.SSOE = true;

    //enable
    SPI5.CR1.SPE = true;
}

package void transmit(ubyte value)
{
    // transmit a new byte
    SPI5.DR.DR = value;

    //wait until TX register is empty
    while(!SPI5.SR.TXE || SPI5.SR.BSY) {}
}