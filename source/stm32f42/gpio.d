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

module stm32f42.gpio;

nothrow:

import stm32f42.bus;
import stm32f42.mmio;

alias GPIOA = PeripheralTemplate!0;
alias GPIOB = PeripheralTemplate!1;
alias GPIOC = PeripheralTemplate!2;
alias GPIOD = PeripheralTemplate!3;
alias GPIOE = PeripheralTemplate!4;
alias GPIOF = PeripheralTemplate!5;
alias GPIOG = PeripheralTemplate!6;
alias GPIOH = PeripheralTemplate!7;
alias GPIOI = PeripheralTemplate!8;
alias GPIOJ = PeripheralTemplate!9;
alias GPIOK = PeripheralTemplate!10;

/****************************************************************************************
 GPIO Peripheral
*/
private final abstract class PeripheralTemplate(int port) : Peripheral!(AHB1, 0x400 * port)
{
    /************************************************************************************
     GPIO port mode register
    */
    final abstract class MODER : Register!(0x00, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Port 15 
         These bits are written by software to configure the I/O direction mode.
         00: Input (reset state)
         01: General purpose output mode
         10: Alternate function mode
         11: Analog mode
        */
        alias MODER15 = BitField!(31, 30, Mutability.rw);

        /********************************************************************************
         Port 14 
         These bits are written by software to configure the I/O direction mode.
         00: Input (reset state)
         01: General purpose output mode
         10: Alternate function mode
         11: Analog mode
        */
        alias MODER14 = BitField!(29, 28, Mutability.rw);

        /********************************************************************************
         Port 13 
         These bits are written by software to configure the I/O direction mode.
         00: Input (reset state)
         01: General purpose output mode
         10: Alternate function mode
         11: Analog mode
        */
        alias MODER13 = BitField!(27, 26, Mutability.rw);

        /********************************************************************************
         Port 12 
         These bits are written by software to configure the I/O direction mode.
         00: Input (reset state)
         01: General purpose output mode
         10: Alternate function mode
         11: Analog mode
        */
        alias MODER12 = BitField!(25, 24, Mutability.rw);

        /********************************************************************************
         Port 11 
         These bits are written by software to configure the I/O direction mode.
         00: Input (reset state)
         01: General purpose output mode
         10: Alternate function mode
         11: Analog mode
        */
        alias MODER11 = BitField!(23, 22, Mutability.rw);

        /********************************************************************************
         Port 10 
         These bits are written by software to configure the I/O direction mode.
         00: Input (reset state)
         01: General purpose output mode
         10: Alternate function mode
         11: Analog mode
        */
        alias MODER10 = BitField!(21, 20, Mutability.rw);

        /********************************************************************************
         Port 9 
         These bits are written by software to configure the I/O direction mode.
         00: Input (reset state)
         01: General purpose output mode
         10: Alternate function mode
         11: Analog mode
        */
        alias MODER9 = BitField!(19, 18, Mutability.rw);

        /********************************************************************************
         Port 8 
         These bits are written by software to configure the I/O direction mode.
         00: Input (reset state)
         01: General purpose output mode
         10: Alternate function mode
         11: Analog mode
        */
        alias MODER8 = BitField!(17, 16, Mutability.rw);

        /********************************************************************************
         Port 7 
         These bits are written by software to configure the I/O direction mode.
         00: Input (reset state)
         01: General purpose output mode
         10: Alternate function mode
         11: Analog mode
        */
        alias MODER7 = BitField!(15, 14, Mutability.rw);

        /********************************************************************************
         Port 6 
         These bits are written by software to configure the I/O direction mode.
         00: Input (reset state)
         01: General purpose output mode
         10: Alternate function mode
         11: Analog mode
        */
        alias MODER6 = BitField!(13, 12, Mutability.rw);

        /********************************************************************************
         Port 5 
         These bits are written by software to configure the I/O direction mode.
         00: Input (reset state)
         01: General purpose output mode
         10: Alternate function mode
         11: Analog mode
        */
        alias MODER5 = BitField!(11, 10, Mutability.rw);

        /********************************************************************************
         Port 4 
         These bits are written by software to configure the I/O direction mode.
         00: Input (reset state)
         01: General purpose output mode
         10: Alternate function mode
         11: Analog mode
        */
        alias MODER4 = BitField!(9, 8, Mutability.rw);

        /********************************************************************************
         Port 3 
         These bits are written by software to configure the I/O direction mode.
         00: Input (reset state)
         01: General purpose output mode
         10: Alternate function mode
         11: Analog mode
        */
        alias MODER3 = BitField!(7, 6, Mutability.rw);

        /********************************************************************************
         Port 2 
         These bits are written by software to configure the I/O direction mode.
         00: Input (reset state)
         01: General purpose output mode
         10: Alternate function mode
         11: Analog mode
        */
        alias MODER2 = BitField!(5, 4, Mutability.rw);

        /********************************************************************************
         Port 1 
         These bits are written by software to configure the I/O direction mode.
         00: Input (reset state)
         01: General purpose output mode
         10: Alternate function mode
         11: Analog mode
        */
        alias MODER1 = BitField!(3, 2, Mutability.rw);

        /********************************************************************************
         Port 0 
         These bits are written by software to configure the I/O direction mode.
         00: Input (reset state)
         01: General purpose output mode
         10: Alternate function mode
         11: Analog mode
        */
        alias MODER0 = BitField!(1, 0, Mutability.rw);

    }
    /************************************************************************************
     GPIO port output type register
    */
    final abstract class OTYPER : Register!(0x04, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Port 15 configuration bits 
         These bits are written by software to configure the output type of the I/O port.
         0: Output push-pull (reset state)
         1: Output open-drain
        */
        alias OT15 = Bit!(15, Mutability.rw);

        /********************************************************************************
         Port 14 configuration bits 
         These bits are written by software to configure the output type of the I/O port.
         0: Output push-pull (reset state)
         1: Output open-drain
        */
        alias OT14 = Bit!(14, Mutability.rw);

        /********************************************************************************
         Port 13 configuration bits 
         These bits are written by software to configure the output type of the I/O port.
         0: Output push-pull (reset state)
         1: Output open-drain
        */
        alias OT13 = Bit!(13, Mutability.rw);

        /********************************************************************************
         Port 12 configuration bits 
         These bits are written by software to configure the output type of the I/O port.
         0: Output push-pull (reset state)
         1: Output open-drain
        */
        alias OT12 = Bit!(12, Mutability.rw);

        /********************************************************************************
         Port 11 configuration bits 
         These bits are written by software to configure the output type of the I/O port.
         0: Output push-pull (reset state)
         1: Output open-drain
        */
        alias OT11 = Bit!(11, Mutability.rw);

        /********************************************************************************
         Port 10 configuration bits 
         These bits are written by software to configure the output type of the I/O port.
         0: Output push-pull (reset state)
         1: Output open-drain
        */
        alias OT10 = Bit!(10, Mutability.rw);

        /********************************************************************************
         Port 9 configuration bits 
         These bits are written by software to configure the output type of the I/O port.
         0: Output push-pull (reset state)
         1: Output open-drain
        */
        alias OT9 = Bit!(9, Mutability.rw);

        /********************************************************************************
         Port 8 configuration bits 
         These bits are written by software to configure the output type of the I/O port.
         0: Output push-pull (reset state)
         1: Output open-drain
        */
        alias OT8 = Bit!(8, Mutability.rw);

        /********************************************************************************
         Port 7 configuration bits 
         These bits are written by software to configure the output type of the I/O port.
         0: Output push-pull (reset state)
         1: Output open-drain
        */
        alias OT7 = Bit!(7, Mutability.rw);

        /********************************************************************************
         Port 6 configuration bits 
         These bits are written by software to configure the output type of the I/O port.
         0: Output push-pull (reset state)
         1: Output open-drain
        */
        alias OT6 = Bit!(6, Mutability.rw);

        /********************************************************************************
         Port 5 configuration bits 
         These bits are written by software to configure the output type of the I/O port.
         0: Output push-pull (reset state)
         1: Output open-drain
        */
        alias OT5 = Bit!(5, Mutability.rw);

        /********************************************************************************
         Port 4 configuration bits 
         These bits are written by software to configure the output type of the I/O port.
         0: Output push-pull (reset state)
         1: Output open-drain
        */
        alias OT4 = Bit!(4, Mutability.rw);

        /********************************************************************************
         Port 3 configuration bits 
         These bits are written by software to configure the output type of the I/O port.
         0: Output push-pull (reset state)
         1: Output open-drain
        */
        alias OT3 = Bit!(3, Mutability.rw);

        /********************************************************************************
         Port 2 configuration bits 
         These bits are written by software to configure the output type of the I/O port.
         0: Output push-pull (reset state)
         1: Output open-drain
        */
        alias OT2 = Bit!(2, Mutability.rw);

        /********************************************************************************
         Port 1 configuration bits 
         These bits are written by software to configure the output type of the I/O port.
         0: Output push-pull (reset state)
         1: Output open-drain
        */
        alias OT1 = Bit!(1, Mutability.rw);

        /********************************************************************************
         Port 0 configuration bits 
         These bits are written by software to configure the output type of the I/O port.
         0: Output push-pull (reset state)
         1: Output open-drain
        */
        alias OT0 = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     GPIO port output speed register
    */
    final abstract class OSPEEDR : Register!(0x08, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Port 15 configuration bits 
         These bits are written by software to configure the I/O output speed.
         00: Low speed
         01: Medium speed
         10: Fast speed
         11: High speed
         Note: Refer to the product datasheets for the values of OSPEEDRy bits versus VDD
         range and external load.
        */
        alias OSPEEDR15 = BitField!(31, 30, Mutability.rw);

        /********************************************************************************
         Port 14 configuration bits 
         These bits are written by software to configure the I/O output speed.
         00: Low speed
         01: Medium speed
         10: Fast speed
         11: High speed
         Note: Refer to the product datasheets for the values of OSPEEDRy bits versus VDD
         range and external load.
        */
        alias OSPEEDR14 = BitField!(29, 28, Mutability.rw);

        /********************************************************************************
         Port 13 configuration bits 
         These bits are written by software to configure the I/O output speed.
         00: Low speed
         01: Medium speed
         10: Fast speed
         11: High speed
         Note: Refer to the product datasheets for the values of OSPEEDRy bits versus VDD
         range and external load.
        */
        alias OSPEEDR13 = BitField!(27, 26, Mutability.rw);

        /********************************************************************************
         Port 12 configuration bits 
         These bits are written by software to configure the I/O output speed.
         00: Low speed
         01: Medium speed
         10: Fast speed
         11: High speed
         Note: Refer to the product datasheets for the values of OSPEEDRy bits versus VDD
         range and external load.
        */
        alias OSPEEDR12 = BitField!(25, 24, Mutability.rw);

        /********************************************************************************
         Port 11 configuration bits 
         These bits are written by software to configure the I/O output speed.
         00: Low speed
         01: Medium speed
         10: Fast speed
         11: High speed
         Note: Refer to the product datasheets for the values of OSPEEDRy bits versus VDD
         range and external load.
        */
        alias OSPEEDR11 = BitField!(23, 22, Mutability.rw);

        /********************************************************************************
         Port 10 configuration bits 
         These bits are written by software to configure the I/O output speed.
         00: Low speed
         01: Medium speed
         10: Fast speed
         11: High speed
         Note: Refer to the product datasheets for the values of OSPEEDRy bits versus VDD
         range and external load.
        */
        alias OSPEEDR10 = BitField!(21, 20, Mutability.rw);

        /********************************************************************************
         Port 9 configuration bits 
         These bits are written by software to configure the I/O output speed.
         00: Low speed
         01: Medium speed
         10: Fast speed
         11: High speed
         Note: Refer to the product datasheets for the values of OSPEEDRy bits versus VDD
         range and external load.
        */
        alias OSPEEDR9 = BitField!(19, 18, Mutability.rw);

        /********************************************************************************
         Port 8 configuration bits 
         These bits are written by software to configure the I/O output speed.
         00: Low speed
         01: Medium speed
         10: Fast speed
         11: High speed
         Note: Refer to the product datasheets for the values of OSPEEDRy bits versus VDD
         range and external load.
        */
        alias OSPEEDR8 = BitField!(17, 16, Mutability.rw);

        /********************************************************************************
         Port 7 configuration bits 
         These bits are written by software to configure the I/O output speed.
         00: Low speed
         01: Medium speed
         10: Fast speed
         11: High speed
         Note: Refer to the product datasheets for the values of OSPEEDRy bits versus VDD
         range and external load.
        */
        alias OSPEEDR7 = BitField!(15, 14, Mutability.rw);

        /********************************************************************************
         Port 6 configuration bits 
         These bits are written by software to configure the I/O output speed.
         00: Low speed
         01: Medium speed
         10: Fast speed
         11: High speed
         Note: Refer to the product datasheets for the values of OSPEEDRy bits versus VDD
         range and external load.
        */
        alias OSPEEDR6 = BitField!(13, 12, Mutability.rw);

        /********************************************************************************
         Port 5 configuration bits 
         These bits are written by software to configure the I/O output speed.
         00: Low speed
         01: Medium speed
         10: Fast speed
         11: High speed
         Note: Refer to the product datasheets for the values of OSPEEDRy bits versus VDD
         range and external load.
        */
        alias OSPEEDR5 = BitField!(11, 10, Mutability.rw);

        /********************************************************************************
         Port 4 configuration bits 
         These bits are written by software to configure the I/O output speed.
         00: Low speed
         01: Medium speed
         10: Fast speed
         11: High speed
         Note: Refer to the product datasheets for the values of OSPEEDRy bits versus VDD
         range and external load.
        */
        alias OSPEEDR4 = BitField!(9, 8, Mutability.rw);

        /********************************************************************************
         Port 3 configuration bits 
         These bits are written by software to configure the I/O output speed.
         00: Low speed
         01: Medium speed
         10: Fast speed
         11: High speed
         Note: Refer to the product datasheets for the values of OSPEEDRy bits versus VDD
         range and external load.
        */
        alias OSPEEDR3 = BitField!(7, 6, Mutability.rw);

        /********************************************************************************
         Port 2 configuration bits 
         These bits are written by software to configure the I/O output speed.
         00: Low speed
         01: Medium speed
         10: Fast speed
         11: High speed
         Note: Refer to the product datasheets for the values of OSPEEDRy bits versus VDD
         range and external load.
        */
        alias OSPEEDR2 = BitField!(5, 4, Mutability.rw);

        /********************************************************************************
         Port 1 configuration bits 
         These bits are written by software to configure the I/O output speed.
         00: Low speed
         01: Medium speed
         10: Fast speed
         11: High speed
         Note: Refer to the product datasheets for the values of OSPEEDRy bits versus VDD
         range and external load.
        */
        alias OSPEEDR1 = BitField!(3, 2, Mutability.rw);

        /********************************************************************************
         Port 0 configuration bits 
         These bits are written by software to configure the I/O output speed.
         00: Low speed
         01: Medium speed
         10: Fast speed
         11: High speed
         Note: Refer to the product datasheets for the values of OSPEEDRy bits versus VDD
         range and external load.
        */
        alias OSPEEDR0 = BitField!(1, 0, Mutability.rw);

    }
    /************************************************************************************
     GPIO port pull-up/pull-down register
    */
    final abstract class PUPDR : Register!(0x0C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Port 15 configuration bits 
         These bits are written by software to configure the I/O pull-up or pull-down
         00: No pull-up, pull-down
         01: Pull-up
         10: Pull-down
         11: Reserved
         Note: Refer to the product datasheets for the values of PUPDRy bits versus VDD
         range and external load.
        */
        alias PUPDR15 = BitField!(31, 30, Mutability.rw);

        /********************************************************************************
         Port 14 configuration bits 
         These bits are written by software to configure the I/O pull-up or pull-down
         00: No pull-up, pull-down
         01: Pull-up
         10: Pull-down
         11: Reserved
         Note: Refer to the product datasheets for the values of PUPDRy bits versus VDD
         range and external load.
        */
        alias PUPDR14 = BitField!(29, 28, Mutability.rw);

        /********************************************************************************
         Port 13 configuration bits 
         These bits are written by software to configure the I/O pull-up or pull-down
         00: No pull-up, pull-down
         01: Pull-up
         10: Pull-down
         11: Reserved
         Note: Refer to the product datasheets for the values of PUPDRy bits versus VDD
         range and external load.
        */
        alias PUPDR13 = BitField!(27, 26, Mutability.rw);

        /********************************************************************************
         Port 12 configuration bits 
         These bits are written by software to configure the I/O pull-up or pull-down
         00: No pull-up, pull-down
         01: Pull-up
         10: Pull-down
         11: Reserved
         Note: Refer to the product datasheets for the values of PUPDRy bits versus VDD
         range and external load.
        */
        alias PUPDR12 = BitField!(25, 24, Mutability.rw);

        /********************************************************************************
         Port 11 configuration bits 
         These bits are written by software to configure the I/O pull-up or pull-down
         00: No pull-up, pull-down
         01: Pull-up
         10: Pull-down
         11: Reserved
         Note: Refer to the product datasheets for the values of PUPDRy bits versus VDD
         range and external load.
        */
        alias PUPDR11 = BitField!(23, 22, Mutability.rw);

        /********************************************************************************
         Port 10 configuration bits 
         These bits are written by software to configure the I/O pull-up or pull-down
         00: No pull-up, pull-down
         01: Pull-up
         10: Pull-down
         11: Reserved
         Note: Refer to the product datasheets for the values of PUPDRy bits versus VDD
         range and external load.
        */
        alias PUPDR10 = BitField!(21, 20, Mutability.rw);

        /********************************************************************************
         Port 9 configuration bits 
         These bits are written by software to configure the I/O pull-up or pull-down
         00: No pull-up, pull-down
         01: Pull-up
         10: Pull-down
         11: Reserved
         Note: Refer to the product datasheets for the values of PUPDRy bits versus VDD
         range and external load.
        */
        alias PUPDR9 = BitField!(19, 18, Mutability.rw);

        /********************************************************************************
         Port 8 configuration bits 
         These bits are written by software to configure the I/O pull-up or pull-down
         00: No pull-up, pull-down
         01: Pull-up
         10: Pull-down
         11: Reserved
         Note: Refer to the product datasheets for the values of PUPDRy bits versus VDD
         range and external load.
        */
        alias PUPDR8 = BitField!(17, 16, Mutability.rw);

        /********************************************************************************
         Port 7 configuration bits 
         These bits are written by software to configure the I/O pull-up or pull-down
         00: No pull-up, pull-down
         01: Pull-up
         10: Pull-down
         11: Reserved
         Note: Refer to the product datasheets for the values of PUPDRy bits versus VDD
         range and external load.
        */
        alias PUPDR7 = BitField!(15, 14, Mutability.rw);

        /********************************************************************************
         Port 6 configuration bits 
         These bits are written by software to configure the I/O pull-up or pull-down
         00: No pull-up, pull-down
         01: Pull-up
         10: Pull-down
         11: Reserved
         Note: Refer to the product datasheets for the values of PUPDRy bits versus VDD
         range and external load.
        */
        alias PUPDR6 = BitField!(13, 12, Mutability.rw);

        /********************************************************************************
         Port 5 configuration bits 
         These bits are written by software to configure the I/O pull-up or pull-down
         00: No pull-up, pull-down
         01: Pull-up
         10: Pull-down
         11: Reserved
         Note: Refer to the product datasheets for the values of PUPDRy bits versus VDD
         range and external load.
        */
        alias PUPDR5 = BitField!(11, 10, Mutability.rw);

        /********************************************************************************
         Port 4 configuration bits 
         These bits are written by software to configure the I/O pull-up or pull-down
         00: No pull-up, pull-down
         01: Pull-up
         10: Pull-down
         11: Reserved
         Note: Refer to the product datasheets for the values of PUPDRy bits versus VDD
         range and external load.
        */
        alias PUPDR4 = BitField!(9, 8, Mutability.rw);

        /********************************************************************************
         Port 3 configuration bits 
         These bits are written by software to configure the I/O pull-up or pull-down
         00: No pull-up, pull-down
         01: Pull-up
         10: Pull-down
         11: Reserved
         Note: Refer to the product datasheets for the values of PUPDRy bits versus VDD
         range and external load.
        */
        alias PUPDR3 = BitField!(7, 6, Mutability.rw);

        /********************************************************************************
         Port 2 configuration bits 
         These bits are written by software to configure the I/O pull-up or pull-down
         00: No pull-up, pull-down
         01: Pull-up
         10: Pull-down
         11: Reserved
         Note: Refer to the product datasheets for the values of PUPDRy bits versus VDD
         range and external load.
        */
        alias PUPDR2 = BitField!(5, 4, Mutability.rw);

        /********************************************************************************
         Port 1 configuration bits 
         These bits are written by software to configure the I/O pull-up or pull-down
         00: No pull-up, pull-down
         01: Pull-up
         10: Pull-down
         11: Reserved
         Note: Refer to the product datasheets for the values of PUPDRy bits versus VDD
         range and external load.
        */
        alias PUPDR1 = BitField!(3, 2, Mutability.rw);

        /********************************************************************************
         Port 0 configuration bits 
         These bits are written by software to configure the I/O pull-up or pull-down
         00: No pull-up, pull-down
         01: Pull-up
         10: Pull-down
         11: Reserved
         Note: Refer to the product datasheets for the values of PUPDRy bits versus VDD
         range and external load.
        */
        alias PUPDR0 = BitField!(1, 0, Mutability.rw);

    }
    /************************************************************************************
     GPIO port input data register
    */
    final abstract class IDR : Register!(0x10, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Port input data 
         These bits are read-only and can be accessed in word mode only. They contain the input
         value of the corresponding I/O port.
        */
        alias IDR15 = Bit!(15, Mutability.r);

        /********************************************************************************
         Port input data 
         These bits are read-only and can be accessed in word mode only. They contain the input
         value of the corresponding I/O port.
        */
        alias IDR14 = Bit!(14, Mutability.r);

        /********************************************************************************
         Port input data 
         These bits are read-only and can be accessed in word mode only. They contain the input
         value of the corresponding I/O port.
        */
        alias IDR13 = Bit!(13, Mutability.r);

        /********************************************************************************
         Port input data 
         These bits are read-only and can be accessed in word mode only. They contain the input
         value of the corresponding I/O port.
        */
        alias IDR12 = Bit!(12, Mutability.r);

        /********************************************************************************
         Port input data 
         These bits are read-only and can be accessed in word mode only. They contain the input
         value of the corresponding I/O port.
        */
        alias IDR11 = Bit!(11, Mutability.r);

        /********************************************************************************
         Port input data 
         These bits are read-only and can be accessed in word mode only. They contain the input
         value of the corresponding I/O port.
        */
        alias IDR10 = Bit!(10, Mutability.r);

        /********************************************************************************
         Port input data 
         These bits are read-only and can be accessed in word mode only. They contain the input
         value of the corresponding I/O port.
        */
        alias IDR9 = Bit!(9, Mutability.r);

        /********************************************************************************
         Port input data 
         These bits are read-only and can be accessed in word mode only. They contain the input
         value of the corresponding I/O port.
        */
        alias IDR8 = Bit!(8, Mutability.r);

        /********************************************************************************
         Port input data 
         These bits are read-only and can be accessed in word mode only. They contain the input
         value of the corresponding I/O port.
        */
        alias IDR7 = Bit!(7, Mutability.r);

        /********************************************************************************
         Port input data 
         These bits are read-only and can be accessed in word mode only. They contain the input
         value of the corresponding I/O port.
        */
        alias IDR6 = Bit!(6, Mutability.r);

        /********************************************************************************
         Port input data 
         These bits are read-only and can be accessed in word mode only. They contain the input
         value of the corresponding I/O port.
        */
        alias IDR5 = Bit!(5, Mutability.r);

        /********************************************************************************
         Port input data 
         These bits are read-only and can be accessed in word mode only. They contain the input
         value of the corresponding I/O port.
        */
        alias IDR4 = Bit!(4, Mutability.r);

        /********************************************************************************
         Port input data 
         These bits are read-only and can be accessed in word mode only. They contain the input
         value of the corresponding I/O port.
        */
        alias IDR3 = Bit!(3, Mutability.r);

        /********************************************************************************
         Port input data 
         These bits are read-only and can be accessed in word mode only. They contain the input
         value of the corresponding I/O port.
        */
        alias IDR2 = Bit!(2, Mutability.r);

        /********************************************************************************
         Port input data 
         These bits are read-only and can be accessed in word mode only. They contain the input
         value of the corresponding I/O port.
        */
        alias IDR1 = Bit!(1, Mutability.r);

        /********************************************************************************
         Port input data 
         These bits are read-only and can be accessed in word mode only. They contain the input
         value of the corresponding I/O port.
        */
        alias IDR0 = Bit!(0, Mutability.r);

    }
    /************************************************************************************
     GPIO port output data register
    */
    final abstract class ODR : Register!(0x14, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Port output data 
         These bits can be read and written by software.
         Note: For atomic bit set/reset, the ODR bits can be individually set and reset by writing to the BSRR register.
        */
        alias ODR15 = Bit!(15, Mutability.rw);

        /********************************************************************************
         Port output data 
         These bits can be read and written by software.
         Note: For atomic bit set/reset, the ODR bits can be individually set and reset by writing to the BSRR register.
        */
        alias ODR14 = Bit!(14, Mutability.rw);

        /********************************************************************************
         Port output data 
         These bits can be read and written by software.
         Note: For atomic bit set/reset, the ODR bits can be individually set and reset by writing to the BSRR register.
        */
        alias ODR13 = Bit!(13, Mutability.rw);

        /********************************************************************************
         Port output data 
         These bits can be read and written by software.
         Note: For atomic bit set/reset, the ODR bits can be individually set and reset by writing to the BSRR register.
        */
        alias ODR12 = Bit!(12, Mutability.rw);

        /********************************************************************************
         Port output data 
         These bits can be read and written by software.
         Note: For atomic bit set/reset, the ODR bits can be individually set and reset by writing to the BSRR register.
        */
        alias ODR11 = Bit!(11, Mutability.rw);

        /********************************************************************************
         Port output data 
         These bits can be read and written by software.
         Note: For atomic bit set/reset, the ODR bits can be individually set and reset by writing to the BSRR register.
        */
        alias ODR10 = Bit!(10, Mutability.rw);

        /********************************************************************************
         Port output data 
         These bits can be read and written by software.
         Note: For atomic bit set/reset, the ODR bits can be individually set and reset by writing to the BSRR register.
        */
        alias ODR9 = Bit!(9, Mutability.rw);

        /********************************************************************************
         Port output data 
         These bits can be read and written by software.
         Note: For atomic bit set/reset, the ODR bits can be individually set and reset by writing to the BSRR register.
        */
        alias ODR8 = Bit!(8, Mutability.rw);

        /********************************************************************************
         Port output data 
         These bits can be read and written by software.
         Note: For atomic bit set/reset, the ODR bits can be individually set and reset by writing to the BSRR register.
        */
        alias ODR7 = Bit!(7, Mutability.rw);

        /********************************************************************************
         Port output data 
         These bits can be read and written by software.
         Note: For atomic bit set/reset, the ODR bits can be individually set and reset by writing to the BSRR register.
        */
        alias ODR6 = Bit!(6, Mutability.rw);

        /********************************************************************************
         Port output data 
         These bits can be read and written by software.
         Note: For atomic bit set/reset, the ODR bits can be individually set and reset by writing to the BSRR register.
        */
        alias ODR5 = Bit!(5, Mutability.rw);

        /********************************************************************************
         Port output data 
         These bits can be read and written by software.
         Note: For atomic bit set/reset, the ODR bits can be individually set and reset by writing to the BSRR register.
        */
        alias ODR4 = Bit!(4, Mutability.rw);

        /********************************************************************************
         Port output data 
         These bits can be read and written by software.
         Note: For atomic bit set/reset, the ODR bits can be individually set and reset by writing to the BSRR register.
        */
        alias ODR3 = Bit!(3, Mutability.rw);

        /********************************************************************************
         Port output data 
         These bits can be read and written by software.
         Note: For atomic bit set/reset, the ODR bits can be individually set and reset by writing to the BSRR register.
        */
        alias ODR2 = Bit!(2, Mutability.rw);

        /********************************************************************************
         Port output data 
         These bits can be read and written by software.
         Note: For atomic bit set/reset, the ODR bits can be individually set and reset by writing to the BSRR register.
        */
        alias ODR1 = Bit!(1, Mutability.rw);

        /********************************************************************************
         Port output data 
         These bits can be read and written by software.
         Note: For atomic bit set/reset, the ODR bits can be individually set and reset by writing to the BSRR register.
        */
        alias ODR0 = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     GPIO port bit set/reset register
    */
    final abstract class BSRR : Register!(0x18, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Port reset bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Resets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BR15 = Bit!(31, Mutability.w);

        /********************************************************************************
         Port reset bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Resets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BR14 = Bit!(30, Mutability.w);

        /********************************************************************************
         Port reset bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Resets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BR13 = Bit!(29, Mutability.w);

        /********************************************************************************
         Port reset bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Resets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BR12 = Bit!(28, Mutability.w);

        /********************************************************************************
         Port reset bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Resets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BR11 = Bit!(27, Mutability.w);

        /********************************************************************************
         Port reset bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Resets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BR10 = Bit!(26, Mutability.w);

        /********************************************************************************
         Port reset bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Resets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BR9 = Bit!(25, Mutability.w);

        /********************************************************************************
         Port reset bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Resets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BR8 = Bit!(24, Mutability.w);

        /********************************************************************************
         Port reset bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Resets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BR7 = Bit!(23, Mutability.w);

        /********************************************************************************
         Port reset bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Resets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BR6 = Bit!(22, Mutability.w);

        /********************************************************************************
         Port reset bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Resets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BR5 = Bit!(21, Mutability.w);

        /********************************************************************************
         Port reset bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Resets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BR4 = Bit!(20, Mutability.w);

        /********************************************************************************
         Port reset bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Resets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BR3 = Bit!(19, Mutability.w);

        /********************************************************************************
         Port reset bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Resets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BR2 = Bit!(18, Mutability.w);

        /********************************************************************************
         Port reset bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Resets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BR1 = Bit!(17, Mutability.w);

        /********************************************************************************
         Port reset bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Resets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BR0 = Bit!(16, Mutability.w);

        /********************************************************************************
         Port set bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Sets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BS15 = Bit!(15, Mutability.w);

        /********************************************************************************
         Port set bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Sets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BS14 = Bit!(14, Mutability.w);

        /********************************************************************************
         Port set bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Sets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BS13 = Bit!(13, Mutability.w);

        /********************************************************************************
         Port set bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Sets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BS12 = Bit!(12, Mutability.w);

        /********************************************************************************
         Port set bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Sets the corresponding ODR bit 
         Note: If both BS and BR are set, BS has priority.
        */
        alias BS11 = Bit!(11, Mutability.w);

        /********************************************************************************
         Port set bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Sets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BS10 = Bit!(10, Mutability.w);

        /********************************************************************************
         Port set bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Sets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BS9 = Bit!(9, Mutability.w);

        /********************************************************************************
         Port set bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Sets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BS8 = Bit!(8, Mutability.w);

        /********************************************************************************
         Port set bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Sets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BS7 = Bit!(7, Mutability.w);

        /********************************************************************************
         Port set bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Sets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BS6 = Bit!(6, Mutability.w);

        /********************************************************************************
         Port set bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Sets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BS5 = Bit!(5, Mutability.w);

        /********************************************************************************
         Port set bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Sets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BS4 = Bit!(4, Mutability.w);

        /********************************************************************************
         Port set bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Sets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BS3 = Bit!(3, Mutability.w);

        /********************************************************************************
         Port set bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Sets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BS2 = Bit!(2, Mutability.w);

        /********************************************************************************
         Port set bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Sets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BS1 = Bit!(1, Mutability.w);

        /********************************************************************************
         Port set bit 
         These bits are write-only and can be accessed in word, half-word or byte mode. A read to these bits returns the value 0x0000.
         0: No action on the corresponding ODR bit
         1: Sets the corresponding ODR bit
         Note: If both BS and BR are set, BS has priority.
        */
        alias BS0 = Bit!(0, Mutability.w);

    }
    /************************************************************************************
     GPIO port configuration lock register
     This register is used to lock the configuration of the port bits when a correct write sequence
     is applied to bit 16 (LCKK). The value of bits [15:0] is used to lock the configuration of the
     GPIO. During the write sequence, the value of LCKR[15:0] must not change. When the
     LOCK sequence has been applied on a port bit, the value of this port bit can no longer be
     modified until the next reset.
     Note: A specific write sequence is used to write to the GPIOx_LCKR register. Only word access
     (32-bit long) is allowed during this write sequence.
     Each lock bit freezes a specific configuration register (control and alternate function
     registers).
    */
    final abstract class LCKR : Register!(0x1C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Lock key 
         This bit can be read any time. It can only be modified using the lock key write sequence.
         0: Port configuration lock key not active
         1: Port configuration lock key active. The GPIOx_LCKR register is locked until an MCU reset
         occurs.
         LOCK key write sequence:
         WR LCKR[16] = ??+ LCKR[15:0]
         WR LCKR[16] = ??+ LCKR[15:0]
         WR LCKR[16] = ??+ LCKR[15:0]
         RD LCKR
         RD LCKR[16] = ??(this read operation is optional but it confirms that the lock is active)
         Note: During the LOCK key write sequence, the value of LCK[15:0] must not change.
         Any error in the lock sequence aborts the lock.
         After the first lock sequence on any bit of the port, any read access on the LCKK bit will
         return ??until the next CPU reset.
        */
        alias LCKK = Bit!(16, Mutability.rw);

        /********************************************************************************
         Port lock bit 
         These bits are read/write but can only be written when the LCKK bit is ?.
         0: Port configuration not locked
         1: Port configuration locked
        */
        alias LCK15 = Bit!(15, Mutability.rw);

        /********************************************************************************
         Port lock bit 
         These bits are read/write but can only be written when the LCKK bit is ?.
         0: Port configuration not locked
         1: Port configuration locked
        */
        alias LCK14 = Bit!(14, Mutability.rw);

        /********************************************************************************
         Port lock bit 
         These bits are read/write but can only be written when the LCKK bit is ?.
         0: Port configuration not locked
         1: Port configuration locked
        */
        alias LCK13 = Bit!(13, Mutability.rw);

        /********************************************************************************
         Port lock bit 
         These bits are read/write but can only be written when the LCKK bit is ?.
         0: Port configuration not locked
         1: Port configuration locked
        */
        alias LCK12 = Bit!(12, Mutability.rw);

        /********************************************************************************
         Port lock bit 
         These bits are read/write but can only be written when the LCKK bit is ?.
         0: Port configuration not locked
         1: Port configuration locked
        */
        alias LCK11 = Bit!(11, Mutability.rw);

        /********************************************************************************
         Port lock bit 
         These bits are read/write but can only be written when the LCKK bit is ?.
         0: Port configuration not locked
         1: Port configuration locked
        */
        alias LCK10 = Bit!(10, Mutability.rw);

        /********************************************************************************
         Port lock bit 
         These bits are read/write but can only be written when the LCKK bit is ?.
         0: Port configuration not locked
         1: Port configuration locked
        */
        alias LCK9 = Bit!(9, Mutability.rw);

        /********************************************************************************
         Port lock bit 
         These bits are read/write but can only be written when the LCKK bit is ?.
         0: Port configuration not locked
         1: Port configuration locked
        */
        alias LCK8 = Bit!(8, Mutability.rw);

        /********************************************************************************
         Port lock bit 
         These bits are read/write but can only be written when the LCKK bit is ?.
         0: Port configuration not locked
         1: Port configuration locked
        */
        alias LCK7 = Bit!(7, Mutability.rw);

        /********************************************************************************
         Port lock bit 
         These bits are read/write but can only be written when the LCKK bit is ?.
         0: Port configuration not locked
         1: Port configuration locked
        */
        alias LCK6 = Bit!(6, Mutability.rw);

        /********************************************************************************
         Port lock bit 
         These bits are read/write but can only be written when the LCKK bit is ?.
         0: Port configuration not locked
         1: Port configuration locked
        */
        alias LCK5 = Bit!(5, Mutability.rw);

        /********************************************************************************
         Port lock bit 
         These bits are read/write but can only be written when the LCKK bit is ?.
         0: Port configuration not locked
         1: Port configuration locked
        */
        alias LCK4 = Bit!(4, Mutability.rw);

        /********************************************************************************
         Port lock bit 
         These bits are read/write but can only be written when the LCKK bit is ?.
         0: Port configuration not locked
         1: Port configuration locked
        */
        alias LCK3 = Bit!(3, Mutability.rw);

        /********************************************************************************
         Port lock bit 
         These bits are read/write but can only be written when the LCKK bit is ?.
         0: Port configuration not locked
         1: Port configuration locked
        */
        alias LCK2 = Bit!(2, Mutability.rw);

        /********************************************************************************
         Port lock bit 
         These bits are read/write but can only be written when the LCKK bit is ?.
         0: Port configuration not locked
         1: Port configuration locked
        */
        alias LCK1 = Bit!(1, Mutability.rw);

        /********************************************************************************
         Port lock bit 
         These bits are read/write but can only be written when the LCKK bit is ?.
         0: Port configuration not locked
         1: Port configuration locked
        */
        alias LCK0 = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     GPIO alternate function low register
    */
    final abstract class AFRL : Register!(0x20, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Alternate function selection 
         These bits are written by software to configure alternate function I/Os
         0000: AF0
         0001: AF1
         0010: AF2
         0011: AF3
         0100: AF4
         0101: AF5
         0110: AF6
         0111: AF7
         1000: AF8
         1001: AF9
         1010: AF10
         1011: AF11
         1100: AF12
         1101: AF13
         1110: AF14
         1111: AF15
        */
        alias AFRL7 = BitField!(31, 28, Mutability.rw);

        /********************************************************************************
         Alternate function selection 
         These bits are written by software to configure alternate function I/Os
         0000: AF0
         0001: AF1
         0010: AF2
         0011: AF3
         0100: AF4
         0101: AF5
         0110: AF6
         0111: AF7
         1000: AF8
         1001: AF9
         1010: AF10
         1011: AF11
         1100: AF12
         1101: AF13
         1110: AF14
         1111: AF15
        */
        alias AFRL6 = BitField!(27, 24, Mutability.rw);

        /********************************************************************************
         Alternate function selection 
         These bits are written by software to configure alternate function I/Os
         0000: AF0
         0001: AF1
         0010: AF2
         0011: AF3
         0100: AF4
         0101: AF5
         0110: AF6
         0111: AF7
         1000: AF8
         1001: AF9
         1010: AF10
         1011: AF11
         1100: AF12
         1101: AF13
         1110: AF14
         1111: AF15
        */
        alias AFRL5 = BitField!(23, 20, Mutability.rw);

        /********************************************************************************
         Alternate function selection 
         These bits are written by software to configure alternate function I/Os
         0000: AF0
         0001: AF1
         0010: AF2
         0011: AF3
         0100: AF4
         0101: AF5
         0110: AF6
         0111: AF7
         1000: AF8
         1001: AF9
         1010: AF10
         1011: AF11
         1100: AF12
         1101: AF13
         1110: AF14
         1111: AF15
        */
        alias AFRL4 = BitField!(19, 16, Mutability.rw);

        /********************************************************************************
         Alternate function selection 
         These bits are written by software to configure alternate function I/Os
         0000: AF0
         0001: AF1
         0010: AF2
         0011: AF3
         0100: AF4
         0101: AF5
         0110: AF6
         0111: AF7
         1000: AF8
         1001: AF9
         1010: AF10
         1011: AF11
         1100: AF12
         1101: AF13
         1110: AF14
         1111: AF15
        */
        alias AFRL3 = BitField!(15, 12, Mutability.rw);

        /********************************************************************************
         Alternate function selection 
         These bits are written by software to configure alternate function I/Os
         0000: AF0
         0001: AF1
         0010: AF2
         0011: AF3
         0100: AF4
         0101: AF5
         0110: AF6
         0111: AF7
         1000: AF8
         1001: AF9
         1010: AF10
         1011: AF11
         1100: AF12
         1101: AF13
         1110: AF14
         1111: AF15
        */
        alias AFRL2 = BitField!(11, 8, Mutability.rw);

        /********************************************************************************
         Alternate function selection 
         These bits are written by software to configure alternate function I/Os
         0000: AF0
         0001: AF1
         0010: AF2
         0011: AF3
         0100: AF4
         0101: AF5
         0110: AF6
         0111: AF7
         1000: AF8
         1001: AF9
         1010: AF10
         1011: AF11
         1100: AF12
         1101: AF13
         1110: AF14
         1111: AF15
        */
        alias AFRL1 = BitField!(7, 4, Mutability.rw);

        /********************************************************************************
         Alternate function selection 
         These bits are written by software to configure alternate function I/Os
         0000: AF0
         0001: AF1
         0010: AF2
         0011: AF3
         0100: AF4
         0101: AF5
         0110: AF6
         0111: AF7
         1000: AF8
         1001: AF9
         1010: AF10
         1011: AF11
         1100: AF12
         1101: AF13
         1110: AF14
         1111: AF15
        */
        alias AFRL0 = BitField!(3, 0, Mutability.rw);

    }
    /************************************************************************************
     GPIO alternate function high register
    */
    final abstract class AFRH : Register!(0x24, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Alternate function selection 
         These bits are written by software to configure alternate function I/Os
         0000: AF0
         0001: AF1
         0010: AF2
         0011: AF3
         0100: AF4
         0101: AF5
         0110: AF6
         0111: AF7
         1000: AF8
         1001: AF9
         1010: AF10
         1011: AF11
         1100: AF12
         1101: AF13
         1110: AF14
         1111: AF15
        */
        alias AFRH15 = BitField!(31, 28, Mutability.rw);

        /********************************************************************************
         Alternate function selection 
         These bits are written by software to configure alternate function I/Os
         0000: AF0
         0001: AF1
         0010: AF2
         0011: AF3
         0100: AF4
         0101: AF5
         0110: AF6
         0111: AF7
         1000: AF8
         1001: AF9
         1010: AF10
         1011: AF11
         1100: AF12
         1101: AF13
         1110: AF14
         1111: AF15
        */
        alias AFRH14 = BitField!(27, 24, Mutability.rw);

        /********************************************************************************
         Alternate function selection 
         These bits are written by software to configure alternate function I/Os
         0000: AF0
         0001: AF1
         0010: AF2
         0011: AF3
         0100: AF4
         0101: AF5
         0110: AF6
         0111: AF7
         1000: AF8
         1001: AF9
         1010: AF10
         1011: AF11
         1100: AF12
         1101: AF13
         1110: AF14
         1111: AF15
        */
        alias AFRH13 = BitField!(23, 20, Mutability.rw);

        /********************************************************************************
         Alternate function selection 
         These bits are written by software to configure alternate function I/Os
         0000: AF0
         0001: AF1
         0010: AF2
         0011: AF3
         0100: AF4
         0101: AF5
         0110: AF6
         0111: AF7
         1000: AF8
         1001: AF9
         1010: AF10
         1011: AF11
         1100: AF12
         1101: AF13
         1110: AF14
         1111: AF15
        */
        alias AFRH12 = BitField!(19, 16, Mutability.rw);

        /********************************************************************************
         Alternate function selection 
         These bits are written by software to configure alternate function I/Os
         0000: AF0
         0001: AF1
         0010: AF2
         0011: AF3
         0100: AF4
         0101: AF5
         0110: AF6
         0111: AF7
         1000: AF8
         1001: AF9
         1010: AF10
         1011: AF11
         1100: AF12
         1101: AF13
         1110: AF14
         1111: AF15
        */
        alias AFRH11 = BitField!(15, 12, Mutability.rw);

        /********************************************************************************
         Alternate function selection 
         These bits are written by software to configure alternate function I/Os
         0000: AF0
         0001: AF1
         0010: AF2
         0011: AF3
         0100: AF4
         0101: AF5
         0110: AF6
         0111: AF7
         1000: AF8
         1001: AF9
         1010: AF10
         1011: AF11
         1100: AF12
         1101: AF13
         1110: AF14
         1111: AF15
        */
        alias AFRH10 = BitField!(11, 8, Mutability.rw);

        /********************************************************************************
         Alternate function selection 
         These bits are written by software to configure alternate function I/Os
         0000: AF0
         0001: AF1
         0010: AF2
         0011: AF3
         0100: AF4
         0101: AF5
         0110: AF6
         0111: AF7
         1000: AF8
         1001: AF9
         1010: AF10
         1011: AF11
         1100: AF12
         1101: AF13
         1110: AF14
         1111: AF15
        */
        alias AFRH9 = BitField!(7, 4, Mutability.rw);

        /********************************************************************************
         Alternate function selection 
         These bits are written by software to configure alternate function I/Os
         0000: AF0
         0001: AF1
         0010: AF2
         0011: AF3
         0100: AF4
         0101: AF5
         0110: AF6
         0111: AF7
         1000: AF8
         1001: AF9
         1010: AF10
         1011: AF11
         1100: AF12
         1101: AF13
         1110: AF14
         1111: AF15
        */
        alias AFRH8 = BitField!(3, 0, Mutability.rw);

    }
}
