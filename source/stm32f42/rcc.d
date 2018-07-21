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

module stm32f42.rcc;

nothrow:

import stm32f42.mmio;
import stm32f42.bus;

/****************************************************************************************
 Reset and clock control
*/
final abstract class RCC : Peripheral!(AHB1, 0x3800)
{
    /************************************************************************************
     RCC clock control register
    */
    final abstract class CR : Register!(0x00, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         PLLSAI clock ready flag 
         Set by hardware to indicate that the PLLSAI is locked.
         0: PLLSAI unlocked
         1: PLLSAI locked
        */
        alias PLLSAIRDY = Bit!(29, Mutability.r);

        /********************************************************************************
         PLLSAI enable 
         Set and cleared by software to enable PLLSAI.
         Cleared by hardware when entering Stop or Standby mode.
         0: PLLSAI OFF
         1: PLLSAI ON
        */
        alias PLLISAION = Bit!(28, Mutability.rw);

        /********************************************************************************
         PLLI2S clock ready flag 
         Set by hardware to indicate that the PLLI2S is locked.
         0: PLLI2S unlocked
         1: PLLI2S locked
        */
        alias PLLI2SRDY = Bit!(27, Mutability.r);

        /********************************************************************************
         PLLI2S enable 
         Set and cleared by software to enable PLLI2S.
         Cleared by hardware when entering Stop or Standby mode.
         0: PLLI2S OFF
         1: PLLI2S ON
        */
        alias PLLI2SON = Bit!(26, Mutability.rw);

        /********************************************************************************
         Main PLL (PLL) clock ready flag 
         Set by hardware to indicate that PLL is locked.
         0: PLL unlocked
         1: PLL locked
        */
        alias PLLRDY = Bit!(25, Mutability.r);

        /********************************************************************************
         Main PLL (PLL) enable 
         Set and cleared by software to enable PLL.
         Cleared by hardware when entering Stop or Standby mode. This bit cannot be reset if PLL
         clock is used as the system clock.
         0: PLL OFF
         1: PLL ON
        */
        alias PLLON = Bit!(24, Mutability.rw);

        /********************************************************************************
         Clock security system enable 
         Set and cleared by software to enable the clock security system. When CSSON is set, the
         clock detector is enabled by hardware when the HSE oscillator is ready, and disabled by
         hardware if an oscillator failure is detected.
         0: Clock security system OFF (Clock detector OFF)
         1: Clock security system ON (Clock detector ON if HSE oscillator is stable, OFF if not)
        */
        alias CSSON = Bit!(19, Mutability.rw);

        /********************************************************************************
         HSE clock bypass 
         Set and cleared by software to bypass the oscillator with an external clock. The external
         clock must be enabled with the HSEON bit, to be used by the device.
         The HSEBYP bit can be written only if the HSE oscillator is disabled.
         0: HSE oscillator not bypassed
         1: HSE oscillator bypassed with an external clock
        */
        alias HSEBYP = Bit!(18, Mutability.rw);

        /********************************************************************************
         HSE clock ready flag 
         Set by hardware to indicate that the HSE oscillator is stable. After the HSEON bit is cleared,
         HSERDY goes low after 6 HSE oscillator clock cycles.
         0: HSE oscillator not ready
         1: HSE oscillator ready
        */
        alias HSERDY = Bit!(17, Mutability.r);

        /********************************************************************************
         HSE clock enable 
         Set and cleared by software.
         Cleared by hardware to stop the HSE oscillator when entering Stop or Standby mode. This
         bit cannot be reset if the HSE oscillator is used directly or indirectly as the system clock.
         0: HSE oscillator OFF
         1: HSE oscillator ON
        */
        alias HSEON = Bit!(16, Mutability.rw);

        /********************************************************************************
         Internal high-speed clock calibration 
         These bits are initialized automatically at startup.
        */
        alias HSICAL = BitField!(15, 8, Mutability.r);

        /********************************************************************************
         Internal high-speed clock trimming 
         These bits provide an additional user-programmable trimming value that is added to the
         HSICAL[7:0] bits. It can be programmed to adjust to variations in voltage and temperature
         that influence the frequency of the internal HSI RC.
        */
        alias HSITRIM = BitField!(7, 3, Mutability.rw);

        /********************************************************************************
         Internal high-speed clock ready flag 
         Set by hardware to indicate that the HSI oscillator is stable. After the HSION bit is cleared,
         HSIRDY goes low after 6 HSI clock cycles.
         0: HSI oscillator not ready
         1: HSI oscillator ready
        */
        alias HSIRDY = Bit!(1, Mutability.r);

        /********************************************************************************
         Internal high-speed clock enable 
         Set and cleared by software.
         Set by hardware to force the HSI oscillator ON when leaving the Stop or Standby mode or in
         case of a failure of the HSE oscillator used directly or indirectly as the system clock. This bit
         cannot be cleared if the HSI is used directly or indirectly as the system clock.
         0: HSI oscillator OFF
         1: HSI oscillator ON
        */
        alias HSION = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     RCC PLL configuration register
     This register is used to configure the PLL clock outputs according to the formulas:
     • f(VCO clock) = f(PLL clock input) × (PLLN / PLLM)
     • f(PLL general clock output) = f(VCO clock) / PLLP
     • f(USB OTG FS, SDIO, RNG clock output) = f(VCO clock) / PLLQ
    */
    final abstract class PLLCFGR : Register!(0x04, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Main PLL (PLL) division factor for USB OTG FS, SDIO and random number generator 
         clocks
         Set and cleared by software to control the frequency of USB OTG FS clock, the random
         number generator clock and the SDIO clock. These bits should be written only if PLL is
         disabled.
         Caution: The USB OTG FS requires a 48 MHz clock to work correctly. The SDIO and the
         random number generator need a frequency lower than or equal to 48 MHz to work
         correctly.
         USB OTG FS clock frequency = VCO frequency / PLLQ with 2 ≤ PLLQ ≤ 15
         0000: PLLQ = 0, wrong configuration
         0001: PLLQ = 1, wrong configuration
         0010: PLLQ = 2
         0011: PLLQ = 3
         0100: PLLQ = 4
         ...
         1111: PLLQ = 15
        */
        alias PLLQ = BitField!(27, 24, Mutability.rw);

        /********************************************************************************
         Main PLL(PLL) and audio PLL (PLLI2S) entry clock source 
         Set and cleared by software to select PLL and PLLI2S clock source. This bit can be written
         only when PLL and PLLI2S are disabled.
         0: HSI clock selected as PLL and PLLI2S clock entry
         1: HSE oscillator clock selected as PLL and PLLI2S clock entry
        */
        alias PLLSRC = Bit!(22, Mutability.rw);

        /********************************************************************************
         Main PLL (PLL) division factor for main system clock 
         Set and cleared by software to control the frequency of the general PLL output clock. These
         bits can be written only if PLL is disabled.
         Caution: The software has to set these bits correctly not to exceed 180 MHz on this domain.
         PLL output clock frequency = VCO frequency / PLLP with PLLP = 2, 4, 6, or 8
         00: PLLP = 2
         01: PLLP = 4
         10: PLLP = 6
         11: PLLP = 8
        */
        alias PLLP = BitField!(17, 16, Mutability.rw);

        /********************************************************************************
         Main PLL (PLL) multiplication factor for VCO 
         Set and cleared by software to control the multiplication factor of the VCO. These bits can
         be written only when PLL is disabled. Only half-word and word accesses are allowed to
         write these bits.
         Caution: The software has to set these bits correctly to ensure that the VCO output
         frequency is between 192 and 432 MHz. Below an example of PLLN bitfield
         forbidden values for PLL input equal to FPLL_IN = 1 MHz:
         VCO output frequency = VCO input frequency × PLLN with 192 ≤ PLLN ≤ 432
         000000000: PLLN = 0, wrong configuration
         000000001: PLLN = 1, wrong configuration
         ...
         011000000: PLLN = 192
         ...
         110110000: PLLN = 432
         110110001: PLLN = 433, wrong configuration
         ...
         111111111: PLLN = 511, wrong configuration
        */
        alias PLLN = BitField!(14, 6, Mutability.rw);

        /********************************************************************************
         Division factor for the main PLL (PLL) and audio PLL (PLLI2S) input clock 
         Set and cleared by software to divide the PLL and PLLI2S input clock before the VCO.
         These bits can be written only when the PLL and PLLI2S are disabled.
         Caution: The software has to set these bits correctly to ensure that the VCO input frequency
         ranges from 1 to 2 MHz. It is recommended to select a frequency of 2 MHz to limit
         PLL jitter.
         VCO input frequency = PLL input clock frequency / PLLM with 2 ≤ PLLM ≤ 63
         000000: PLLM = 0, wrong configuration
         000001: PLLM = 1, wrong configuration
         000010: PLLM = 2
         000011: PLLM = 3
         000100: PLLM = 4
         ...
         111110: PLLM = 62
         111111: PLLM = 63
        */
        alias PLLM = BitField!(5, 0, Mutability.rw);

    }
    /************************************************************************************
     RCC clock configuration register
     1 or 2 wait states inserted only if the access occurs during a clock source switch.
    */
    final abstract class CFGR : Register!(0x08, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Microcontroller clock output 2 
         Set and cleared by software. Clock source selection may generate glitches on MCO2. It is
         highly recommended to configure these bits only after reset before enabling the external
         oscillators and the PLLs.
         00: System clock (SYSCLK) selected
         01: PLLI2S clock selected
         10: HSE oscillator clock selected
         11: PLL clock selected
        */
        alias MCO2 = BitField!(31, 30, Mutability.rw);

        /********************************************************************************
         MCO2 prescaler 
         Set and cleared by software to configure the prescaler of the MCO2. Modification of this
         prescaler may generate glitches on MCO2. It is highly recommended to change this
         prescaler only after reset before enabling the external oscillators and the PLLs.
         0xx: no division
         100: division by 2
         101: division by 3
         110: division by 4
         111: division by 5
        */
        alias MCO2PRE = BitField!(27, 29, Mutability.rw);

        /********************************************************************************
         MCO1 prescaler 
         Set and cleared by software to configure the prescaler of the MCO1. Modification of this
         prescaler may generate glitches on MCO1. It is highly recommended to change this
         prescaler only after reset before enabling the external oscillators and the PLL.
         0xx: no division
         100: division by 2
         101: division by 3
         110: division by 4
         111: division by 5
        */
        alias MCO1PRE = BitField!(24, 26, Mutability.rw);

        /********************************************************************************
         I2S clock selection 
         Set and cleared by software. This bit allows to select the I2S clock source between the
         PLLI2S clock and the external clock. It is highly recommended to change this bit only after
         reset and before enabling the I2S module.
         0: PLLI2S clock used as I2S clock source
         1: External clock mapped on the I2S_CKIN pin used as I2S clock source
        */
        alias I2SSRC = Bit!(23, Mutability.rw);

        /********************************************************************************
         Microcontroller clock output 1 
         Set and cleared by software. Clock source selection may generate glitches on MCO1. It is
         highly recommended to configure these bits only after reset before enabling the external
         oscillators and PLL.
         00: HSI clock selected
         01: LSE oscillator selected
         10: HSE oscillator clock selected
         11: PLL clock selected
        */
        alias MCO1 = BitField!(22, 21, Mutability.rw);

        /********************************************************************************
         HSE division factor for RTC clock 
         Set and cleared by software to divide the HSE clock input clock to generate a 1 MHz clock
         for RTC.
         Caution: The software has to set these bits correctly to ensure that the clock supplied to the
         RTC is 1 MHz. These bits must be configured if needed before selecting the RTC
         clock source.
         00000: no clock
         00001: no clock
         00010: HSE/2
         00011: HSE/3
         00100: HSE/4
         ...
         11110: HSE/30
         11111: HSE/31
        */
        alias RTCPRE = BitField!(20, 16, Mutability.rw);

        /********************************************************************************
         APB high-speed prescaler (APB2) 
         Set and cleared by software to control APB high-speed clock division factor.
         Caution: The software has to set these bits correctly not to exceed 90 MHz on this domain.
         The clocks are divided with the new prescaler factor from 1 to 16 AHB cycles after
         PPRE2 write.
         0xx: AHB clock not divided
         100: AHB clock divided by 2
         101: AHB clock divided by 4
         110: AHB clock divided by 8
         111: AHB clock divided by 16
        */
        alias PPRE2 = BitField!(15, 13, Mutability.rw);

        /********************************************************************************
         APB Low speed prescaler (APB1) 
         Set and cleared by software to control APB low-speed clock division factor.
         Caution: The software has to set these bits correctly not to exceed 45 MHz on this domain.
         The clocks are divided with the new prescaler factor from 1 to 16 AHB cycles after
         PPRE1 write.
         0xx: AHB clock not divided
         100: AHB clock divided by 2
         101: AHB clock divided by 4
         110: AHB clock divided by 8
         111: AHB clock divided by 16
        */
        alias PPRE1 = BitField!(12, 10, Mutability.rw);

        /********************************************************************************
         AHB prescaler 
         Set and cleared by software to control AHB clock division factor.
         Caution: The clocks are divided with the new prescaler factor from 1 to 16 AHB cycles after
         HPRE write.
         Caution: The AHB clock frequency must be at least 25 MHz when the Ethernet is used.
         0xxx: system clock not divided
         1000: system clock divided by 2
         1001: system clock divided by 4
         1010: system clock divided by 8
         1011: system clock divided by 16
         1100: system clock divided by 64
         1101: system clock divided by 128
         1110: system clock divided by 256
         1111: system clock divided by 512
        */
        alias HPRE = BitField!(7, 4, Mutability.rw);

        /********************************************************************************
         System clock switch status 
         Set and cleared by hardware to indicate which clock source is used as the system clock.
         00: HSI oscillator used as the system clock
         01: HSE oscillator used as the system clock
         10: PLL used as the system clock
         11: not applicable
        */
        alias SWS = BitField!(3, 2, Mutability.rw);

        /********************************************************************************
         System clock switch 
         Set and cleared by software to select the system clock source.
         Set by hardware to force the HSI selection when leaving the Stop or Standby mode or in
         case of failure of the HSE oscillator used directly or indirectly as the system clock.
         00: HSI oscillator selected as system clock
         01: HSE oscillator selected as system clock
         10: PLL selected as system clock
         11: not allowed
        */
        alias SW = BitField!(1, 0, Mutability.rw);

    }
    /************************************************************************************
     RCC clock interrupt register
    */
    final abstract class CIR : Register!(0x0C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Clock security system interrupt clear 
         This bit is set by software to clear the CSSF flag.
         0: No effect
         1: Clear CSSF flag
        */
        alias CSSC = Bit!(23, Mutability.w);

        /********************************************************************************
         PLLSAI Ready Interrupt Clear 
         This bit is set by software to clear PLLSAIRDYF flag. It is reset by hardware when the
         PLLSAIRDYF is cleared.
         0: PLLSAIRDYF not cleared
         1: PLLSAIRDYF cleared
        */
        alias PLLSAIRDYC = Bit!(22, Mutability.w);

        /********************************************************************************
         PLLI2S ready interrupt clear 
         This bit is set by software to clear the PLLI2SRDYF flag.
         0: No effect
         1: PLLI2SRDYF cleared
        */
        alias PLLI2SRDYC = Bit!(21, Mutability.w);

        /********************************************************************************
         Main PLL(PLL) ready interrupt clear 
         This bit is set by software to clear the PLLRDYF flag.
         0: No effect
         1: PLLRDYF cleared
        */
        alias PLLRDYC = Bit!(20, Mutability.w);

        /********************************************************************************
         HSE ready interrupt clear 
         This bit is set by software to clear the HSERDYF flag.
         0: No effect
         1: HSERDYF cleared
        */
        alias HSERDYC = Bit!(19, Mutability.w);

        /********************************************************************************
         HSI ready interrupt clear 
         This bit is set software to clear the HSIRDYF flag.
         0: No effect
         1: HSIRDYF cleared
        */
        alias HSIRDYC = Bit!(18, Mutability.w);

        /********************************************************************************
         LSE ready interrupt clear 
         This bit is set by software to clear the LSERDYF flag.
         0: No effect
         1: LSERDYF cleared
        */
        alias LSERDYC = Bit!(17, Mutability.w);

        /********************************************************************************
         LSI ready interrupt clear 
         This bit is set by software to clear the LSIRDYF flag.
         0: No effect
         1: LSIRDYF cleared
        */
        alias LSIRDYC = Bit!(16, Mutability.w);

        /********************************************************************************
         PLLSAI Ready Interrupt Enable 
         This bit is set and reset by software to enable/disable interrupt caused by PLLSAI lock.
         0: PLLSAI lock interrupt disabled
         1: PLLSAI lock interrupt enabled
        */
        alias PLLSAIRDYIE = Bit!(14, Mutability.rw);

        /********************************************************************************
         PLLI2S ready interrupt enable 
         This bit is set and cleared by software to enable/disable interrupt caused by PLLI2S lock.
         0: PLLI2S lock interrupt disabled
         1: PLLI2S lock interrupt enabled
        */
        alias PLLI2SRDYIE = Bit!(13, Mutability.rw);

        /********************************************************************************
         Main PLL (PLL) ready interrupt enable 
         This bit is set and cleared by software to enable/disable interrupt caused by PLL lock.
         0: PLL lock interrupt disabled
         1: PLL lock interrupt enabled
        */
        alias PLLRDYIE = Bit!(12, Mutability.rw);

        /********************************************************************************
         HSE ready interrupt enable 
         This bit is set and cleared by software to enable/disable interrupt caused by the HSE
         oscillator stabilization.
         0: HSE ready interrupt disabled
         1: HSE ready interrupt enabled
        */
        alias HSERDYIE = Bit!(11, Mutability.rw);

        /********************************************************************************
         HSI ready interrupt enable 
         This bit is set and cleared by software to enable/disable interrupt caused by the HSI
         oscillator stabilization.
         0: HSI ready interrupt disabled
         1: HSI ready interrupt enabled
        */
        alias HSIRDYIE = Bit!(10, Mutability.rw);

        /********************************************************************************
         LSE ready interrupt enable 
         This bit is set and cleared by software to enable/disable interrupt caused by the LSE
         oscillator stabilization.
         0: LSE ready interrupt disabled
         1: LSE ready interrupt enabled
        */
        alias LSERDYIE = Bit!(9, Mutability.rw);

        /********************************************************************************
         LSI ready interrupt enable 
         This bit is set and cleared by software to enable/disable interrupt caused by LSI oscillator
         stabilization.
         0: LSI ready interrupt disabled
         1: LSI ready interrupt enabled
        */
        alias LSIRDYIE = Bit!(8, Mutability.rw);

        /********************************************************************************
         Clock security system interrupt flag 
         This bit is set by hardware when a failure is detected in the HSE oscillator.
         It is cleared by software by setting the CSSC bit.
         0: No clock security interrupt caused by HSE clock failure
         1: Clock security interrupt caused by HSE clock failure
        */
        alias CSSF = Bit!(7, Mutability.r);

        /********************************************************************************
         PLLSAI Ready Interrupt flag 
         This bit is set by hardware when the PLLSAI is locked and PLLSAIRDYDIE is set.
         It is cleared by software by setting the PLLSAIRDYC bit.
         0: No clock ready interrupt caused by PLLSAI lock
         1: Clock ready interrupt caused by PLLSAI lock
        */
        alias PLLSAIRDYF = Bit!(6, Mutability.r);

        /********************************************************************************
         PLLI2S ready interrupt flag 
         This bit is set by hardware when the PLLI2S is locked and PLLI2SRDYDIE is set.
         It is cleared by software by setting the PLLRI2SDYC bit.
         0: No clock ready interrupt caused by PLLI2S lock
         1: Clock ready interrupt caused by PLLI2S lock
        */
        alias PLLI2SRDYF = Bit!(5, Mutability.r);

        /********************************************************************************
         Main PLL (PLL) ready interrupt flag 
         This bit is set by hardware when PLL is locked and PLLRDYDIE is set.
         It is cleared by software setting the PLLRDYC bit.
         0: No clock ready interrupt caused by PLL lock
         1: Clock ready interrupt caused by PLL lock
        */
        alias PLLRDYF = Bit!(4, Mutability.r);

        /********************************************************************************
         HSE ready interrupt flag 
         This bit is set by hardware when External High Speed clock becomes stable and
         HSERDYDIE is set.
         It is cleared by software by setting the HSERDYC bit.
         0: No clock ready interrupt caused by the HSE oscillator
         1: Clock ready interrupt caused by the HSE oscillator
        */
        alias HSERDYF = Bit!(3, Mutability.r);

        /********************************************************************************
         HSI ready interrupt flag 
         This bit is set by hardware when the Internal High Speed clock becomes stable and
         HSIRDYDIE is set.
         It is cleared by software by setting the HSIRDYC bit.
         0: No clock ready interrupt caused by the HSI oscillator
         1: Clock ready interrupt caused by the HSI oscillator
        */
        alias HSIRDYF = Bit!(2, Mutability.r);

        /********************************************************************************
         LSE ready interrupt flag 
         This bit is set by hardware when the External Low Speed clock becomes stable and
         LSERDYDIE is set.
         It is cleared by software by setting the LSERDYC bit.
         0: No clock ready interrupt caused by the LSE oscillator
         1: Clock ready interrupt caused by the LSE oscillator
        */
        alias LSERDYF = Bit!(1, Mutability.r);

        /********************************************************************************
         LSI ready interrupt flag 
         This bit is set by hardware when the internal low speed clock becomes stable and
         LSIRDYDIE is set.
         It is cleared by software by setting the LSIRDYC bit.
         0: No clock ready interrupt caused by the LSI oscillator
         1: Clock ready interrupt caused by the LSI oscillator
        */
        alias LSIRDYF = Bit!(0, Mutability.r);

    }
    /************************************************************************************
     RCC AHB1 peripheral reset register
    */
    final abstract class AHB1RSTR : Register!(0x10, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         USB OTG HS module reset 
         This bit is set and cleared by software.
         0: does not reset the USB OTG HS module
         1: resets the USB OTG HS module
        */
        alias OTGHSRST = Bit!(29, Mutability.rw);

        /********************************************************************************
         Ethernet MAC reset 
         This bit is set and cleared by software.
         0: does not reset Ethernet MAC
         1: resets Ethernet MAC
        */
        alias ETHMACRST = Bit!(25, Mutability.rw);

        /********************************************************************************
         DMA2D reset 
         This bit is set and reset by software.
         0: does not reset DMA2D
         1: resets DMA2D
        */
        alias DMA2DRST = Bit!(23, Mutability.rw);

        /********************************************************************************
         DMA2 reset 
         This bit is set and cleared by software.
         0: does not reset DMA2
         1: resets DMA2
        */
        alias DMA2RST = Bit!(22, Mutability.rw);

        /********************************************************************************
         DMA2 reset 
         This bit is set and cleared by software.
         0: does not reset DMA2
         1: resets DMA2
        */
        alias DMA1RST = Bit!(21, Mutability.rw);

        /********************************************************************************
         CRC reset 
         This bit is set and cleared by software.
         0: does not reset CRC
         1: resets CRC
        */
        alias CRCRST = Bit!(12, Mutability.rw);

        /********************************************************************************
         IO port K reset 
         This bit is set and cleared by software.
         0: does not reset IO port K
         1: resets IO port K
        */
        alias GPIOKRST = Bit!(10, Mutability.rw);

        /********************************************************************************
         IO port J reset 
         This bit is set and cleared by software.
         0: does not reset IO port J
         1: resets IO port J
        */
        alias GPIOJRST = Bit!(9, Mutability.rw);

        /********************************************************************************
         IO port I reset 
         This bit is set and cleared by software.
         0: does not reset IO port I
         1: resets IO port I
        */
        alias GPIOIRST = Bit!(8, Mutability.rw);

        /********************************************************************************
         IO port H reset 
         This bit is set and cleared by software.
         0: does not reset IO port H
         1: resets IO port H
        */
        alias GPIOHRST = Bit!(7, Mutability.rw);

        /********************************************************************************
         IO port G reset 
         This bit is set and cleared by software.
         0: does not reset IO port G
         1: resets IO port G
        */
        alias GPIOGRST = Bit!(6, Mutability.rw);

        /********************************************************************************
         IO port F reset 
         This bit is set and cleared by software.
         0: does not reset IO port F
         1: resets IO port F
        */
        alias GPIOFRST = Bit!(5, Mutability.rw);

        /********************************************************************************
         IO port E reset 
         This bit is set and cleared by software.
         0: does not reset IO port E
         1: resets IO port E
        */
        alias GPIOERST = Bit!(4, Mutability.rw);

        /********************************************************************************
         IO port D reset 
         This bit is set and cleared by software.
         0: does not reset IO port D
         1: resets IO port D
        */
        alias GPIODRST = Bit!(3, Mutability.rw);

        /********************************************************************************
         IO port C reset 
         This bit is set and cleared by software.
         0: does not reset IO port C
         1: resets IO port C
        */
        alias GPIOCRST = Bit!(2, Mutability.rw);

        /********************************************************************************
         IO port B reset 
         This bit is set and cleared by software.
         0: does not reset IO port B
         1:resets IO port B
        */
        alias GPIOBRST = Bit!(1, Mutability.rw);

        /********************************************************************************
         IO port A reset 
         This bit is set and cleared by software.
         0: does not reset IO port A
         1: resets IO port A
        */
        alias GPIOARST = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     RCC AHB2 peripheral reset register
    */
    final abstract class AHB2RSTR : Register!(0x14, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         USB OTG FS module reset 
         Set and cleared by software.
         0: does not reset the USB OTG FS module
         1: resets the USB OTG FS module
        */
        alias OTGFSRST = Bit!(7, Mutability.rw);

        /********************************************************************************
         Random number generator module reset 
         Set and cleared by software.
         0: does not reset the random number generator module
         1: resets the random number generator module
        */
        alias RNGRST = Bit!(6, Mutability.rw);

        /********************************************************************************
         Hash module reset 
         Set and cleared by software.
         0: does not reset the HASH module
         1: resets the HASH module
        */
        alias HASHRST = Bit!(5, Mutability.rw);

        /********************************************************************************
         Cryptographic module reset 
         Set and cleared by software.
         0: does not reset the cryptographic module
         1: resets the cryptographic module
        */
        alias CRYPRST = Bit!(4, Mutability.rw);

        /********************************************************************************
         Camera interface reset 
         Set and cleared by software.
         0: does not reset the Camera interface
         1: resets the Camera interface
        */
        alias DCMIRST = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     RCC AHB3 peripheral reset register
    */
    final abstract class AHB3RSTR : Register!(0x18, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Flexible memory controller module reset 
         Set and cleared by software.
         0: does not reset the FMC module
         1: resets the FMC module
        */
        alias FMCRST = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     RCC APB1 peripheral reset register
    */
    final abstract class APB1RSTR : Register!(0x20, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         UART8 reset 
         Set and cleared by software.
         0: does not reset UART8
         1: resets UART8
        */
        alias UART8RST = Bit!(31, Mutability.rw);

        /********************************************************************************
         UART7 reset 
         Set and cleared by software.
         0: does not reset UART7
         1: resets UART7
        */
        alias UART7RST = Bit!(30, Mutability.rw);

        /********************************************************************************
         DAC reset 
         Set and cleared by software.
         0: does not reset the DAC interface
         1: resets the DAC interface
        */
        alias DACRST = Bit!(29, Mutability.rw);

        /********************************************************************************
         Power interface reset 
         Set and cleared by software.
         0: does not reset the power interface
         1: resets the power interface
        */
        alias PWRRST = Bit!(28, Mutability.rw);

        /********************************************************************************
         CAN2 reset 
         Set and cleared by software.
         0: does not reset CAN2
         1: resets CAN2
        */
        alias CAN2RST = Bit!(26, Mutability.rw);

        /********************************************************************************
         CAN1 reset 
         Set and cleared by software.
         0: does not reset CAN1
         1: resets CAN1
        */
        alias CAN1RST = Bit!(25, Mutability.rw);

        /********************************************************************************
         I2C3 reset 
         Set and cleared by software.
         0: does not reset I2C3
         1: resets I2C3
        */
        alias I2C3RST = Bit!(23, Mutability.rw);

        /********************************************************************************
         I2C2 reset 
         Set and cleared by software.
         0: does not reset I2C2
         1: resets I2C2
        */
        alias I2C2RST = Bit!(22, Mutability.rw);

        /********************************************************************************
         I2C1 reset 
         Set and cleared by software.
         0: does not reset I2C1
         1: resets I2C1
        */
        alias I2C1RST = Bit!(21, Mutability.rw);

        /********************************************************************************
         UART5 reset 
         Set and cleared by software.
         0: does not reset UART5
         1: resets UART5
        */
        alias UART5RST = Bit!(20, Mutability.rw);

        /********************************************************************************
         USART4 reset 
         Set and cleared by software.
         0: does not reset UART4
         1: resets UART4
        */
        alias UART4RST = Bit!(19, Mutability.rw);

        /********************************************************************************
         USART3 reset 
         Set and cleared by software.
         0: does not reset USART3
         1: resets USART3
        */
        alias USART3RST = Bit!(18, Mutability.rw);

        /********************************************************************************
         USART2 reset 
         Set and cleared by software.
         0: does not reset USART2
         1: resets USART2
        */
        alias USART2RST = Bit!(17, Mutability.rw);

        /********************************************************************************
         SPI3 reset 
         Set and cleared by software.
         0: does not reset SPI3
         1: resets SPI3
        */
        alias SPI3RST = Bit!(15, Mutability.rw);

        /********************************************************************************
         SPI2 reset 
         Set and cleared by software.
         0: does not reset SPI2
         1: resets SPI2
        */
        alias SPI2RST = Bit!(14, Mutability.rw);

        /********************************************************************************
         Window watchdog reset 
         Set and cleared by software.
         0: does not reset the window watchdog
         1: resets the window watchdog
        */
        alias WWDGRST = Bit!(11, Mutability.rw);

        /********************************************************************************
         TIM14 reset 
         Set and cleared by software.
         0: does not reset TIM14
         1: resets TIM14
        */
        alias TIM14RST = Bit!(8, Mutability.rw);

        /********************************************************************************
         TIM13 reset 
         Set and cleared by software.
         0: does not reset TIM13
         1: resets TIM13
        */
        alias TIM13RST = Bit!(7, Mutability.rw);

        /********************************************************************************
         TIM12 reset 
         Set and cleared by software.
         0: does not reset TIM12
         1: resets TIM12
        */
        alias TIM12RST = Bit!(6, Mutability.rw);

        /********************************************************************************
         TIM7 reset 
         Set and cleared by software.
         0: does not reset TIM7
         1: resets TIM7
        */
        alias TIM7RST = Bit!(5, Mutability.rw);

        /********************************************************************************
         TIM6 reset 
         Set and cleared by software.
         0: does not reset TIM6
         1: resets TIM6
        */
        alias TIM6RST = Bit!(4, Mutability.rw);

        /********************************************************************************
         TIM5 reset 
         Set and cleared by software.
         0: does not reset TIM5
         1: resets TIM5
        */
        alias TIM5RST = Bit!(3, Mutability.rw);

        /********************************************************************************
         TIM4 reset 
         Set and cleared by software.
         0: does not reset TIM4
         1: resets TIM4
        */
        alias TIM4RST = Bit!(2, Mutability.rw);

        /********************************************************************************
         TIM3 reset 
         Set and cleared by software.
         0: does not reset TIM3
         1: resets TIM3
        */
        alias TIM3RST = Bit!(1, Mutability.rw);

        /********************************************************************************
         TIM2 reset 
         Set and cleared by software.
         0: does not reset TIM2
         1: resets TIM2
        */
        alias TIM2RST = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     RCC APB2 peripheral reset register
    */
    final abstract class APB2RSTR : Register!(0x24, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         LTDC reset 
         This bit is set and reset by software.
         0: does not reset LCD-TFT
         1: resets LCD-TFT
        */
        alias LTDCRST = Bit!(26, Mutability.rw);

        /********************************************************************************
         SAI1 reset 
         This bit is set and reset by software.
         0: does not reset SAI1
         1: resets SAI1
        */
        alias SAI1RST = Bit!(22, Mutability.rw);

        /********************************************************************************
         SPI6 reset 
         This bit is set and cleared by software.
         0: does not reset SPI6
         1: resets SPI6
        */
        alias SPI6RST = Bit!(21, Mutability.rw);

        /********************************************************************************
         SPI5 reset 
         This bit is set and cleared by software.
         0: does not reset SPI5
         1: resets SPI5
        */
        alias SPI5RST = Bit!(20, Mutability.rw);

        /********************************************************************************
         TIM11 reset 
         This bit is set and cleared by software.
         0: does not reset TIM11
         1: resets TIM14
        */
        alias TIM11RST = Bit!(18, Mutability.rw);

        /********************************************************************************
         TIM10 reset 
         This bit is set and cleared by software.
         0: does not reset TIM10
         1: resets TIM10
        */
        alias TIM10RST = Bit!(17, Mutability.rw);

        /********************************************************************************
         TIM9 reset 
         This bit is set and cleared by software.
         0: does not reset TIM9
         1: resets TIM9
        */
        alias TIM9RST = Bit!(16, Mutability.rw);

        /********************************************************************************
         System configuration controller reset 
         This bit is set and cleared by software.
         0: does not reset the System configuration controller
         1: resets the System configuration controller
        */
        alias SYSCFGRST = Bit!(14, Mutability.rw);

        /********************************************************************************
         SPI4 reset 
         This bit is set and cleared by software.
         0: does not reset SPI4
         1: resets SPI4
        */
        alias SPI4RST = Bit!(13, Mutability.rw);

        /********************************************************************************
         SPI1 reset 
         This bit is set and cleared by software.
         0: does not reset SPI1
         1: resets SPI1
        */
        alias SPI1RST = Bit!(12, Mutability.rw);

        /********************************************************************************
         SDIO reset 
         This bit is set and cleared by software.
         0: does not reset the SDIO module
         1: resets the SDIO module
        */
        alias SDIORST = Bit!(11, Mutability.rw);

        /********************************************************************************
         ADC interface reset (common to all ADCs) 
         This bit is set and cleared by software.
         0: does not reset the ADC interface
         1: resets the ADC interface
        */
        alias ADCRST = Bit!(8, Mutability.rw);

        /********************************************************************************
         USART6 reset 
         This bit is set and cleared by software.
         0: does not reset USART6
         1: resets USART6
        */
        alias USART6RST = Bit!(5, Mutability.rw);

        /********************************************************************************
         USART1 reset 
         This bit is set and cleared by software.
         0: does not reset USART1
         1: resets USART1
        */
        alias USART1RST = Bit!(4, Mutability.rw);

        /********************************************************************************
         TIM8 reset 
         This bit is set and cleared by software.
         0: does not reset TIM8
         1: resets TIM8
        */
        alias TIM8RST = Bit!(1, Mutability.rw);

        /********************************************************************************
         TIM1 reset 
         This bit is set and cleared by software.
         0: does not reset TIM1
         1: resets TIM1
        */
        alias TIM1RST = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     RCC AHB1 peripheral clock register
    */
    final abstract class AHB1ENR : Register!(0x30, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         USB OTG HSULPI clock enable 
         This bit is set and cleared by software.
         0: USB OTG HS ULPI clock disabled
         1: USB OTG HS ULPI clock enabled
        */
        alias OTGHSULPIEN = Bit!(30, Mutability.rw);

        /********************************************************************************
         USB OTG HS clock enable 
         This bit is set and cleared by software.
         0: USB OTG HS clock disabled
         1: USB OTG HS clock enabled
        */
        alias OTGHSEN = Bit!(29, Mutability.rw);

        /********************************************************************************
         Ethernet PTP clock enable 
         This bit is set and cleared by software.
         0: Ethernet PTP clock disabled
         1: Ethernet PTP clock enabled
        */
        alias ETHMACPTPEN = Bit!(28, Mutability.rw);

        /********************************************************************************
         Ethernet Reception clock enable 
         This bit is set and cleared by software.
         0: Ethernet Reception clock disabled
         1: Ethernet Reception clock enabled
        */
        alias ETHMACRXEN = Bit!(27, Mutability.rw);

        /********************************************************************************
         Ethernet Transmission clock enable 
         This bit is set and cleared by software.
         0: Ethernet Transmission clock disabled
         1: Ethernet Transmission clock enabled
        */
        alias ETHMACTXEN = Bit!(26, Mutability.rw);

        /********************************************************************************
         Ethernet MAC clock enable 
         This bit is set and cleared by software.
         0: Ethernet MAC clock disabled
         1: Ethernet MAC clock enabled
        */
        alias ETHMACEN = Bit!(25, Mutability.rw);

        /********************************************************************************
         DMA2D clock enable 
         This bit is set and cleared by software.
         0: DMA2D clock disabled
         1: DMA2D clock enabled
        */
        alias DMA2DEN = Bit!(23, Mutability.rw);

        /********************************************************************************
         DMA2 clock enable 
         This bit is set and cleared by software.
         0: DMA2 clock disabled
         1: DMA2 clock enabled
        */
        alias DMA2EN = Bit!(22, Mutability.rw);

        /********************************************************************************
         DMA1 clock enable 
         This bit is set and cleared by software.
         0: DMA1 clock disabled
         1: DMA1 clock enabled
        */
        alias DMA1EN = Bit!(21, Mutability.rw);

        /********************************************************************************
         CCM data RAM clock enable 
         This bit is set and cleared by software.
         0: CCM data RAM clock disabled
         1: CCM data RAM clock enabled
        */
        alias CCMDATARAMEN = Bit!(20, Mutability.rw);

        /********************************************************************************
         Backup SRAM interface clock enable 
         This bit is set and cleared by software.
         0: Backup SRAM interface clock disabled
         1: Backup SRAM interface clock enabled
        */
        alias BKPSRAMEN = Bit!(18, Mutability.rw);

        /********************************************************************************
         CRC clock enable 
         This bit is set and cleared by software.
         0: CRC clock disabled
         1: CRC clock enabled
        */
        alias CRCEN = Bit!(12, Mutability.rw);

        /********************************************************************************
         IO port K clock enable 
         This bit is set and cleared by software.
         0: IO port K clock disabled
         1: IO port K clock enabled
        */
        alias GPIOKEN = Bit!(10, Mutability.rw);

        /********************************************************************************
         IO port J clock enable 
         This bit is set and cleared by software.
         0: IO port J clock disabled
         1: IO port J clock enabled
        */
        alias GPIOJEN = Bit!(9, Mutability.rw);

        /********************************************************************************
         IO port I clock enable 
         This bit is set and cleared by software.
         0: IO port I clock disabled
         1: IO port I clock enabled
        */
        alias GPIOIEN = Bit!(8, Mutability.rw);

        /********************************************************************************
         IO port H clock enable 
         This bit is set and cleared by software.
         0: IO port H clock disabled
         1: IO port H clock enabled
        */
        alias GPIOHEN = Bit!(7, Mutability.rw);

        /********************************************************************************
         IO port G clock enable 
         This bit is set and cleared by software.
         0: IO port G clock disabled
         1: IO port G clock enabled
        */
        alias GPIOGEN = Bit!(6, Mutability.rw);

        /********************************************************************************
         IO port F clock enable 
         This bit is set and cleared by software.
         0: IO port F clock disabled
         1: IO port F clock enabled
        */
        alias GPIOFEN = Bit!(5, Mutability.rw);

        /********************************************************************************
         IO port E clock enable 
         This bit is set and cleared by software.
         0: IO port E clock disabled
         1: IO port E clock enabled
        */
        alias GPIOEEN = Bit!(4, Mutability.rw);

        /********************************************************************************
         IO port D clock enable 
         This bit is set and cleared by software.
         0: IO port D clock disabled
         1: IO port D clock enabled
        */
        alias GPIODEN = Bit!(3, Mutability.rw);

        /********************************************************************************
         IO port C clock enable 
         This bit is set and cleared by software.
         0: IO port C clock disabled
         1: IO port C clock enabled
        */
        alias GPIOCEN = Bit!(2, Mutability.rw);

        /********************************************************************************
         IO port B clock enable 
         This bit is set and cleared by software.
         0: IO port B clock disabled
         1: IO port B clock enabled
        */
        alias GPIOBEN = Bit!(1, Mutability.rw);

        /********************************************************************************
         IO port A clock enable 
         This bit is set and cleared by software.
         0: IO port A clock disabled
         1: IO port A clock enabled
        */
        alias GPIOAEN = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     RCC AHB2 peripheral clock enable register
    */
    final abstract class AHB2ENR : Register!(0x34, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         USB OTG FS clock enable 
         This bit is set and cleared by software.
         0: USB OTG FS clock disabled
         1: USB OTG FS clock enabled
        */
        alias OTGFSEN = Bit!(7, Mutability.rw);

        /********************************************************************************
         Random number generator clock enable 
         This bit is set and cleared by software.
         0: Random number generator clock disabled
         1: Random number generator clock enabled
        */
        alias RNGEN = Bit!(6, Mutability.rw);

        /********************************************************************************
         Hash modules clock enable 
         This bit is set and cleared by software.
         0: Hash modules clock disabled
         1: Hash modules clock enabled
        */
        alias HASHEN = Bit!(5, Mutability.rw);

        /********************************************************************************
         Cryptographic modules clock enable 
         This bit is set and cleared by software.
         0: cryptographic module clock disabled
         1: cryptographic module clock enabled
        */
        alias CRYPEN = Bit!(4, Mutability.rw);

        /********************************************************************************
         Camera interface enable 
         This bit is set and cleared by software.
         0: Camera interface clock disabled
         1: Camera interface clock enabled
        */
        alias DCMIEN = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     RCC AHB3 peripheral clock enable register
    */
    final abstract class AHB3ENR : Register!(0x38, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Flexible memory controller module clock enable 
         This bit is set and cleared by software.
         0: FMC module clock disabled
         1: FMC module clock enabled
        */
        alias FMCEN = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     RCC APB1 peripheral clock enable register
    */
    final abstract class APB1ENR : Register!(0x40, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         UART8 clock enable 
         This bit is set and cleared by software.
         0: UART8 clock disabled
         1: UART8 clock enabled
        */
        alias UART8EN = Bit!(31, Mutability.rw);

        /********************************************************************************
         UART7 clock enable 
         This bit is set and cleared by software.
         0: UART7 clock disabled
         1: UART7 clock enabled
        */
        alias UART7EN = Bit!(30, Mutability.rw);

        /********************************************************************************
         DAC interface clock enable 
         This bit is set and cleared by software.
         0: DAC interface clock disabled
         1: DAC interface clock enable
        */
        alias DACEN = Bit!(29, Mutability.rw);

        /********************************************************************************
         Power interface clock enable 
         This bit is set and cleared by software.
         0: Power interface clock disabled
         1: Power interface clock enable
        */
        alias PWREN = Bit!(28, Mutability.rw);

        /********************************************************************************
         CAN 2 clock enable 
         This bit is set and cleared by software.
         0: CAN 2 clock disabled
         1: CAN 2 clock enabled
        */
        alias CAN2EN = Bit!(26, Mutability.rw);

        /********************************************************************************
         CAN 1 clock enable 
         This bit is set and cleared by software.
         0: CAN 1 clock disabled
         1: CAN 1 clock enabled
        */
        alias CAN1EN = Bit!(25, Mutability.rw);

        /********************************************************************************
         I2C3 clock enable 
         This bit is set and cleared by software.
         0: I2C3 clock disabled
         1: I2C3 clock enabled
        */
        alias I2C3EN = Bit!(23, Mutability.rw);

        /********************************************************************************
         I2C2 clock enable 
         This bit is set and cleared by software.
         0: I2C2 clock disabled
         1: I2C2 clock enabled
        */
        alias I2C2EN = Bit!(22, Mutability.rw);

        /********************************************************************************
         I2C1 clock enable 
         This bit is set and cleared by software.
         0: I2C1 clock disabled
         1: I2C1 clock enabled
        */
        alias I2C1EN = Bit!(21, Mutability.rw);

        /********************************************************************************
         UART5 clock enable 
         This bit is set and cleared by software.
         0: UART5 clock disabled
         1: UART5 clock enabled
        */
        alias UART5EN = Bit!(20, Mutability.rw);

        /********************************************************************************
         UART4 clock enable 
         This bit is set and cleared by software.
         0: UART4 clock disabled
         1: UART4 clock enabled
        */
        alias UART4EN = Bit!(19, Mutability.rw);

        /********************************************************************************
         USART3 clock enable 
         This bit is set and cleared by software.
         0: USART3 clock disabled
         1: USART3 clock enabled
        */
        alias USART3EN = Bit!(18, Mutability.rw);

        /********************************************************************************
         USART2 clock enable 
         This bit is set and cleared by software.
         0: USART2 clock disabled
         1: USART2 clock enabled
        */
        alias USART2EN = Bit!(17, Mutability.rw);

        /********************************************************************************
         SPI3 clock enable 
         This bit is set and cleared by software.
         0: SPI3 clock disabled
         1: SPI3 clock enabled
        */
        alias SPI3EN = Bit!(15, Mutability.rw);

        /********************************************************************************
         SPI2 clock enable 
         This bit is set and cleared by software.
         0: SPI2 clock disabled
         1: SPI2 clock enabled
        */
        alias SPI2EN = Bit!(14, Mutability.rw);

        /********************************************************************************
         Window watchdog clock enable 
         This bit is set and cleared by software.
         0: Window watchdog clock disabled
         1: Window watchdog clock enabled
        */
        alias WWDGEN = Bit!(11, Mutability.rw);

        /********************************************************************************
         TIM14 clock enable 
         This bit is set and cleared by software.
         0: TIM14 clock disabled
         1: TIM14 clock enabled
        */
        alias TIM14EN = Bit!(8, Mutability.rw);

        /********************************************************************************
         TIM13 clock enable 
         This bit is set and cleared by software.
         0: TIM13 clock disabled
         1: TIM13 clock enabled
        */
        alias TIM13EN = Bit!(7, Mutability.rw);

        /********************************************************************************
         TIM12 clock enable 
         This bit is set and cleared by software.
         0: TIM12 clock disabled
         1: TIM12 clock enabled
        */
        alias TIM12EN = Bit!(6, Mutability.rw);

        /********************************************************************************
         TIM7 clock enable 
         This bit is set and cleared by software.
         0: TIM7 clock disabled
         1: TIM7 clock enabled
        */
        alias TIM7EN = Bit!(5, Mutability.rw);

        /********************************************************************************
         TIM6 clock enable 
         This bit is set and cleared by software.
         0: TIM6 clock disabled
         1: TIM6 clock enabled
        */
        alias TIM6EN = Bit!(4, Mutability.rw);

        /********************************************************************************
         TIM5 clock enable 
         This bit is set and cleared by software.
         0: TIM5 clock disabled
         1: TIM5 clock enabled
        */
        alias TIM5EN = Bit!(3, Mutability.rw);

        /********************************************************************************
         TIM4 clock enable 
         This bit is set and cleared by software.
         0: TIM4 clock disabled
         1: TIM4 clock enabled
        */
        alias TIM4EN = Bit!(2, Mutability.rw);

        /********************************************************************************
         TIM3 clock enable 
         This bit is set and cleared by software.
         0: TIM3 clock disabled
         1: TIM3 clock enabled
        */
        alias TIM3EN = Bit!(1, Mutability.rw);

        /********************************************************************************
         TIM2 clock enable 
         This bit is set and cleared by software.
         0: TIM2 clock disabled
         1: TIM2 clock enabled
        */
        alias TIM2EN = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     RCC APB2 peripheral clock enable register
    */
    final abstract class APB2ENR : Register!(0x44, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         LTDC clock enable 
         This bit is set and cleared by software.
         0: LTDC clock disabled
         1: LTDC clock enabled
        */
        alias LTDCEN = Bit!(26, Mutability.rw);

        /********************************************************************************
         SAI1 clock enable 
         This bit is set and cleared by software.
         0: SAI1 clock disabled
         1: SAI1 clock enabled
        */
        alias SAI1EN = Bit!(22, Mutability.rw);

        /********************************************************************************
         SPI6 clock enable 
         This bit is set and cleared by software.
         0: SPI6 clock disabled
         1: SPI6 clock enabled 
        */
        alias SPI6EN = Bit!(21, Mutability.rw);

        /********************************************************************************
         SPI5 clock enable 
         This bit is set and cleared by software.
         0: SPI5 clock disabled
         1: SPI5 clock enabled
        */
        alias SPI5EN = Bit!(20, Mutability.rw);

        /********************************************************************************
         TIM11 clock enable 
         This bit is set and cleared by software.
         0: TIM11 clock disabled
         1: TIM11 clock enabled
        */
        alias TIM11EN = Bit!(18, Mutability.rw);

        /********************************************************************************
         TIM10 clock enable 
         This bit is set and cleared by software.
         0: TIM10 clock disabled
         1: TIM10 clock enabled
        */
        alias TIM10EN = Bit!(17, Mutability.rw);

        /********************************************************************************
         TIM9 clock enable 
         This bit is set and cleared by software.
         0: TIM9 clock disabled
         1: TIM9 clock enabled
        */
        alias TIM9EN = Bit!(16, Mutability.rw);

        /********************************************************************************
         System configuration controller clock enable 
         This bit is set and cleared by software.
         0: System configuration controller clock disabled
         1: System configuration controller clock enabled
        */
        alias SYSCFGEN = Bit!(14, Mutability.rw);

        /********************************************************************************
         SPI4 clock enable 
         This bit is set and cleared by software.
         0: SPI4 clock disabled
         1: SPI4 clock enabled
        */
        alias SPI4EN = Bit!(13, Mutability.rw);

        /********************************************************************************
         SPI1 clock enable 
         This bit is set and cleared by software.
         0: SPI1 clock disabled
         1: SPI1 clock enabled
        */
        alias SPI1EN = Bit!(12, Mutability.rw);

        /********************************************************************************
         SDIO clock enable 
         This bit is set and cleared by software.
         0: SDIO module clock disabled
         1: SDIO module clock enabled
        */
        alias SDIOEN = Bit!(11, Mutability.rw);

        /********************************************************************************
         ADC3 clock enable 
         This bit is set and cleared by software.
         0: ADC3 clock disabled
         1: ADC3 clock disabled
        */
        alias ADC3EN = Bit!(10, Mutability.rw);

        /********************************************************************************
         ADC2 clock enable 
         This bit is set and cleared by software.
         0: ADC2 clock disabled
         1: ADC2 clock disabled
        */
        alias ADC2EN = Bit!(9, Mutability.rw);

        /********************************************************************************
         ADC1 clock enable 
         This bit is set and cleared by software.
         0: ADC1 clock disabled
         1: ADC1 clock disabled
        */
        alias ADC1EN = Bit!(8, Mutability.rw);

        /********************************************************************************
         USART6 clock enable 
         This bit is set and cleared by software.
         0: USART6 clock disabled
         1: USART6 clock enabled
        */
        alias USART6EN = Bit!(5, Mutability.rw);

        /********************************************************************************
         USART1 clock enable 
         This bit is set and cleared by software.
         0: USART1 clock disabled
         1: USART1 clock enabled
        */
        alias USART1EN = Bit!(4, Mutability.rw);

        /********************************************************************************
         TIM8 clock enable 
         This bit is set and cleared by software.
         0: TIM8 clock disabled
         1: TIM8 clock enabled
        */
        alias TIM8EN = Bit!(1, Mutability.rw);

        /********************************************************************************
         TIM1 clock enable 
         This bit is set and cleared by software.
         0: TIM1 clock disabled
         1: TIM1 clock enabled
        */
        alias TIM1EN = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     RCC AHB1 peripheral clock enable in low power mode register
    */
    final abstract class AHB1LPENR : Register!(0x50, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         USB OTG HS ULPI clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: USB OTG HS ULPI clock disabled during Sleep mode
         1: USB OTG HS ULPI clock enabled during Sleep mode
        */
        alias OTGHSULPILPEN = Bit!(30, Mutability.rw);

        /********************************************************************************
         USB OTG HS clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: USB OTG HS clock disabled during Sleep mode
         1: USB OTG HS clock enabled during Sleep mode 
        */
        alias OTGHSLPEN = Bit!(29, Mutability.rw);

        /********************************************************************************
         Ethernet PTP clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: Ethernet PTP clock disabled during Sleep mode
         1: Ethernet PTP clock enabled during Sleep mode
        */
        alias ETHMACPTPLPEN = Bit!(28, Mutability.rw);

        /********************************************************************************
         Ethernet reception clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: Ethernet reception clock disabled during Sleep mode
         1: Ethernet reception clock enabled during Sleep mode
        */
        alias ETHMACRXLPEN = Bit!(27, Mutability.rw);

        /********************************************************************************
         Ethernet transmission clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: Ethernet transmission clock disabled during sleep mode
         1: Ethernet transmission clock enabled during sleep mode
        */
        alias ETHMACTXLPEN = Bit!(26, Mutability.rw);

        /********************************************************************************
         Ethernet MAC clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: Ethernet MAC clock disabled during Sleep mode
         1: Ethernet MAC clock enabled during Sleep mode
        */
        alias ETHMACLPEN = Bit!(25, Mutability.rw);

        /********************************************************************************
         DMA2D clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: DMA2D clock disabled during Sleep mode
         1: DMA2D clock enabled during Sleep mode
        */
        alias DMA2DLPEN = Bit!(23, Mutability.rw);

        /********************************************************************************
         DMA2 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: DMA2 clock disabled during Sleep mode
         1: DMA2 clock enabled during Sleep mode
        */
        alias DMA2LPEN = Bit!(22, Mutability.rw);

        /********************************************************************************
         DMA1 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: DMA1 clock disabled during Sleep mode
         1: DMA1 clock enabled during Sleep mode
        */
        alias DMA1LPEN = Bit!(21, Mutability.rw);

        /********************************************************************************
         SRAM3 interface clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: SRAM3 interface clock disabled during Sleep mode
         1: SRAM3 interface clock enabled during Sleep mode
        */
        alias SRAM3LPEN = Bit!(19, Mutability.rw);

        /********************************************************************************
         Backup SRAM interface clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: Backup SRAM interface clock disabled during Sleep mode
         1: Backup SRAM interface clock enabled during Sleep mode
        */
        alias BKPSRAMLPEN = Bit!(18, Mutability.rw);

        /********************************************************************************
         SRAM2 interface clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: SRAM2 interface clock disabled during Sleep mode
         1: SRAM2 interface clock enabled during Sleep mode
        */
        alias SRAM2LPEN = Bit!(17, Mutability.rw);

        /********************************************************************************
         SRAM1 interface clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: SRAM1 interface clock disabled during Sleep mode
         1: SRAM1 interface clock enabled during Sleep mode
        */
        alias SRAM1LPEN = Bit!(16, Mutability.rw);

        /********************************************************************************
         Flash interface clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: Flash interface clock disabled during Sleep mode
         1: Flash interface clock enabled during Sleep mode
        */
        alias FLITFLPEN = Bit!(15, Mutability.rw);

        /********************************************************************************
         CRC clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: CRC clock disabled during Sleep mode
         1: CRC clock enabled during Sleep mode
        */
        alias CRCLPEN = Bit!(12, Mutability.rw);

        /********************************************************************************
         IO port K clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: IO port K clock disabled during Sleep mode
         1: IO port K clock enabled during Sleep mode
        */
        alias GPIOKLPEN = Bit!(10, Mutability.rw);

        /********************************************************************************
         IO port J clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: IO port J clock disabled during Sleep mode
         1: IO port J clock enabled during Sleep mode
        */
        alias GPIOJLPEN = Bit!(9, Mutability.rw);

        /********************************************************************************
         IO port I clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: IO port I clock disabled during Sleep mode
         1: IO port I clock enabled during Sleep mode
        */
        alias GPIOILPEN = Bit!(8, Mutability.rw);

        /********************************************************************************
         IO port H clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: IO port H clock disabled during Sleep mode
         1: IO port H clock enabled during Sleep mode
        */
        alias GPIOHLPEN = Bit!(7, Mutability.rw);

        /********************************************************************************
         IO port G clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: IO port G clock disabled during Sleep mode
         1: IO port G clock enabled during Sleep mode
        */
        alias GPIOGLPEN = Bit!(6, Mutability.rw);

        /********************************************************************************
         IO port F clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: IO port F clock disabled during Sleep mode
         1: IO port F clock enabled during Sleep mode
        */
        alias GPIOFLPEN = Bit!(5, Mutability.rw);

        /********************************************************************************
         IO port E clock enable during Sleep mode 
         Set and cleared by software.
         0: IO port E clock disabled during Sleep mode
         1: IO port E clock enabled during Sleep mode
        */
        alias GPIOELPEN = Bit!(4, Mutability.rw);

        /********************************************************************************
         IO port D clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: IO port D clock disabled during Sleep mode
         1: IO port D clock enabled during Sleep mode
        */
        alias GPIODLPEN = Bit!(3, Mutability.rw);

        /********************************************************************************
         IO port C clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: IO port C clock disabled during Sleep mode
         1: IO port C clock enabled during Sleep mode
        */
        alias GPIOCLPEN = Bit!(2, Mutability.rw);

        /********************************************************************************
         IO port B clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: IO port B clock disabled during Sleep mode
         1: IO port B clock enabled during Sleep mode
        */
        alias GPIOBLPEN = Bit!(1, Mutability.rw);

        /********************************************************************************
         IO port A clock enable during sleep mode 
         This bit is set and cleared by software.
         0: IO port A clock disabled during Sleep mode
         1: IO port A clock enabled during Sleep mode
        */
        alias GPIOALPEN = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     RCC AHB2 peripheral clock enable in low power mode register
    */
    final abstract class AHB2LPENR : Register!(0x54, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         USB OTG FS clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: USB OTG FS clock disabled during Sleep mode
         1: USB OTG FS clock enabled during Sleep mode
        */
        alias OTGFSLPEN = Bit!(7, Mutability.rw);

        /********************************************************************************
         Random number generator clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: Random number generator clock disabled during Sleep mode
         1: Random number generator clock enabled during Sleep mode
        */
        alias RNGLPEN = Bit!(6, Mutability.rw);

        /********************************************************************************
         Hash modules clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: Hash modules clock disabled during Sleep mode
         1: Hash modules clock enabled during Sleep mode
        */
        alias HASHLPEN = Bit!(5, Mutability.rw);

        /********************************************************************************
         Cryptography modules clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: cryptography modules clock disabled during Sleep mode
         1: cryptography modules clock enabled during Sleep mode
        */
        alias CRYPLPEN = Bit!(4, Mutability.rw);

        /********************************************************************************
         Camera interface enable during Sleep mode 
         This bit is set and cleared by software.
         0: Camera interface clock disabled during Sleep mode
         1: Camera interface clock enabled during Sleep mode
        */
        alias DCMILPEN = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     RCC AHB3 peripheral clock enable in low power mode register
    */
    final abstract class AHB3LPENR : Register!(0x58, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Flexible memory controller module clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: FMC module clock disabled during Sleep mode
         1: FMC module clock enabled during Sleep mode
        */
        alias FMCLPEN = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     RCC APB1 peripheral clock enable in low power mode register
    */
    final abstract class APB1LPENR : Register!(0x60, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         UART8 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: UART8 clock disabled during Sleep mode
         1: UART8 clock enabled during Sleep mode
        */
        alias UART8LPEN = Bit!(31, Mutability.rw);

        /********************************************************************************
         UART7 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: UART7 clock disabled during Sleep mode
         1: UART7 clock enabled during Sleep mode
        */
        alias UART7LPEN = Bit!(30, Mutability.rw);

        /********************************************************************************
         DAC interface clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: DAC interface clock disabled during Sleep mode
         1: DAC interface clock enabled during Sleep mode
        */
        alias DACLPEN = Bit!(29, Mutability.rw);

        /********************************************************************************
         Power interface clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: Power interface clock disabled during Sleep mode
         1: Power interface clock enabled during Sleep mode
        */
        alias PWRLPEN = Bit!(28, Mutability.rw);

        /********************************************************************************
         CAN 2 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: CAN 2 clock disabled during sleep mode
         1: CAN 2 clock enabled during sleep mode
        */
        alias CAN2LPEN = Bit!(26, Mutability.rw);

        /********************************************************************************
         CAN 1 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: CAN 1 clock disabled during Sleep mode
         1: CAN 1 clock enabled during Sleep mode
        */
        alias CAN1LPEN = Bit!(25, Mutability.rw);

        /********************************************************************************
         I2C3 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: I2C3 clock disabled during Sleep mode
         1: I2C3 clock enabled during Sleep mode
        */
        alias I2C3LPEN = Bit!(23, Mutability.rw);

        /********************************************************************************
         I2C2 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: I2C2 clock disabled during Sleep mode
         1: I2C2 clock enabled during Sleep mode
        */
        alias I2C2LPEN = Bit!(22, Mutability.rw);

        /********************************************************************************
         I2C1 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: I2C1 clock disabled during Sleep mode
         1: I2C1 clock enabled during Sleep mode
        */
        alias I2C1LPEN = Bit!(21, Mutability.rw);

        /********************************************************************************
         UART5 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: UART5 clock disabled during Sleep mode
         1: UART5 clock enabled during Sleep mode
        */
        alias UART5LPEN = Bit!(20, Mutability.rw);

        /********************************************************************************
         UART4 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: UART4 clock disabled during Sleep mode
         1: UART4 clock enabled during Sleep mode
        */
        alias UART4LPEN = Bit!(19, Mutability.rw);

        /********************************************************************************
         USART3 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: USART3 clock disabled during Sleep mode
         1: USART3 clock enabled during Sleep mode
        */
        alias USART3LPEN = Bit!(18, Mutability.rw);

        /********************************************************************************
         USART2 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: USART2 clock disabled during Sleep mode
         1: USART2 clock enabled during Sleep mode
        */
        alias USART2LPEN = Bit!(17, Mutability.rw);

        /********************************************************************************
         SPI3 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: SPI3 clock disabled during Sleep mode
         1: SPI3 clock enabled during Sleep mode
        */
        alias SPI3LPEN = Bit!(15, Mutability.rw);

        /********************************************************************************
         SPI2 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: SPI2 clock disabled during Sleep mode
         1: SPI2 clock enabled during Sleep mode
        */
        alias SPI2LPEN = Bit!(14, Mutability.rw);

        /********************************************************************************
         Window watchdog clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: Window watchdog clock disabled during sleep mode
         1: Window watchdog clock enabled during sleep mode
        */
        alias WWDGLPEN = Bit!(11, Mutability.rw);

        /********************************************************************************
         TIM14 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: TIM14 clock disabled during Sleep mode
         1: TIM14 clock enabled during Sleep mode
        */
        alias TIM14LPEN = Bit!(8, Mutability.rw);

        /********************************************************************************
         TIM13 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: TIM13 clock disabled during Sleep mode
         1: TIM13 clock enabled during Sleep mode
        */
        alias TIM13LPEN = Bit!(7, Mutability.rw);

        /********************************************************************************
         TIM12 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: TIM12 clock disabled during Sleep mode
         1: TIM12 clock enabled during Sleep mode
        */
        alias TIM12LPEN = Bit!(6, Mutability.rw);

        /********************************************************************************
         TIM7 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: TIM7 clock disabled during Sleep mode
         1: TIM7 clock enabled during Sleep mode
        */
        alias TIM7LPEN = Bit!(5, Mutability.rw);

        /********************************************************************************
         TIM6 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: TIM6 clock disabled during Sleep mode
         1: TIM6 clock enabled during Sleep mode
        */
        alias TIM6LPEN = Bit!(4, Mutability.rw);

        /********************************************************************************
         TIM5 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: TIM5 clock disabled during Sleep mode
         1: TIM5 clock enabled during Sleep mode
        */
        alias TIM5LPEN = Bit!(3, Mutability.rw);

        /********************************************************************************
         TIM4 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: TIM4 clock disabled during Sleep mode
         1: TIM4 clock enabled during Sleep mode
        */
        alias TIM4LPEN = Bit!(2, Mutability.rw);

        /********************************************************************************
         TIM3 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: TIM3 clock disabled during Sleep mode
         1: TIM3 clock enabled during Sleep mode
        */
        alias TIM3LPEN = Bit!(1, Mutability.rw);

        /********************************************************************************
         TIM2 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: TIM2 clock disabled during Sleep mode
         1: TIM2 clock enabled during Sleep mode
        */
        alias TIM2LPEN = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     RCC APB2 peripheral clock enabled in low power mode register
    */
    final abstract class APB2LPENR : Register!(0x64, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         LTDC clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: LTDC clock disabled during Sleep mode
         1: LTDC clock enabled during Sleep mode
        */
        alias LTDCLPEN = Bit!(26, Mutability.rw);

        /********************************************************************************
         SAI1 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: SAI1 clock disabled during Sleep mode
         1: SAI1 clock enabled during Sleep mode
        */
        alias SAI1LPEN = Bit!(22, Mutability.rw);

        /********************************************************************************
         SPI6 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: SPI6 clock disabled during Sleep mode
         1: SPI6 clock enabled during Sleep mode
        */
        alias SPI6LPEN = Bit!(21, Mutability.rw);

        /********************************************************************************
         SPI5 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: SPI5 clock disabled during Sleep mode
         1: SPI5 clock enabled during Sleep mode
        */
        alias SPI5LPEN = Bit!(20, Mutability.rw);

        /********************************************************************************
         TIM11 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: TIM11 clock disabled during Sleep mode
         1: TIM11 clock enabled during Sleep mode
        */
        alias TIM11LPEN = Bit!(18, Mutability.rw);

        /********************************************************************************
         TIM10 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: TIM10 clock disabled during Sleep mode
         1: TIM10 clock enabled during Sleep mode
        */
        alias TIM10LPEN = Bit!(17, Mutability.rw);

        /********************************************************************************
         TIM9 clock enable during sleep mode 
         This bit is set and cleared by software.
         0: TIM9 clock disabled during Sleep mode
         1: TIM9 clock enabled during Sleep mode
        */
        alias TIM9LPEN = Bit!(16, Mutability.rw);

        /********************************************************************************
         System configuration controller clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: System configuration controller clock disabled during Sleep mode
         1: System configuration controller clock enabled during Sleep mode
        */
        alias SYSCFGLPEN = Bit!(14, Mutability.rw);

        /********************************************************************************
         SPI4 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: SPI4 clock disabled during Sleep mode
         1: SPI4 clock enabled during Sleep mode
        */
        alias SPI4LPEN = Bit!(13, Mutability.rw);

        /********************************************************************************
         SPI1 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: SPI1 clock disabled during Sleep mode
         1: SPI1 clock enabled during Sleep mode
        */
        alias SPI1LPEN = Bit!(12, Mutability.rw);

        /********************************************************************************
         SDIO clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: SDIO module clock disabled during Sleep mode
         1: SDIO module clock enabled during Sleep mode
        */
        alias SDIOLPEN = Bit!(11, Mutability.rw);

        /********************************************************************************
         ADC 3 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: ADC 3 clock disabled during Sleep mode
         1: ADC 3 clock disabled during Sleep mode
        */
        alias ADC3LPEN = Bit!(10, Mutability.rw);

        /********************************************************************************
         ADC2 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: ADC2 clock disabled during Sleep mode
         1: ADC2 clock disabled during Sleep mode
        */
        alias ADC2LPEN = Bit!(9, Mutability.rw);

        /********************************************************************************
         ADC1 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: ADC1 clock disabled during Sleep mode
         1: ADC1 clock disabled during Sleep mode
        */
        alias ADC1LPEN = Bit!(8, Mutability.rw);

        /********************************************************************************
         USART6 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: USART6 clock disabled during Sleep mode
         1: USART6 clock enabled during Sleep mode
        */
        alias USART6LPEN = Bit!(5, Mutability.rw);

        /********************************************************************************
         USART1 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: USART1 clock disabled during Sleep mode
         1: USART1 clock enabled during Sleep mode
        */
        alias USART1LPEN = Bit!(4, Mutability.rw);

        /********************************************************************************
         TIM8 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: TIM8 clock disabled during Sleep mode
         1: TIM8 clock enabled during Sleep mode
        */
        alias TIM8LPEN = Bit!(1, Mutability.rw);

        /********************************************************************************
         TIM1 clock enable during Sleep mode 
         This bit is set and cleared by software.
         0: TIM1 clock disabled during Sleep mode
         1: TIM1 clock enabled during Sleep mode
        */
        alias TIM1LPEN = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     RCC Backup domain control register
     Wait states are inserted in case of successive accesses to this register.
     The LSEON, LSEBYP, RTCSEL and RTCEN bits in the RCC Backup domain control
     register (RCC_BDCR) are in the Backup domain. As a result, after Reset, these bits are
     write-protected and the DBP bit in the PWR power control register (PWR_CR) for
     STM32F42xxx and STM32F43xxx has to be set before these can be modified. Refer to
     Section 6.1.1: System reset on page 149 for further information. These bits are only reset
     after a Backup domain Reset (see Section 6.1.3: Backup domain reset). Any internal or
     external Reset will not have any effect on these bits.
    */
    final abstract class BDCR : Register!(0x70, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Backup domain software reset 
         This bit is set and cleared by software.
         0: Reset not activated
         1: Resets the entire Backup domain
         Note: The BKPSRAM is not affected by this reset, the only way of resetting the BKPSRAM is
         through the Flash interface when a protection level change from level 1 to level 0 is
         requested.
        */
        alias BDRST = Bit!(16, Mutability.rw);

        /********************************************************************************
         RTC clock enable 
         This bit is set and cleared by software.
         0: RTC clock disabled
         1: RTC clock enabled
        */
        alias RTCEN = Bit!(15, Mutability.rw);

        /********************************************************************************
         RTC clock source selection 
         These bits are set by software to select the clock source for the RTC. Once the RTC clock
         source has been selected, it cannot be changed anymore unless the Backup domain is
         reset. The BDRST bit can be used to reset them.
         00: No clock
         01: LSE oscillator clock used as the RTC clock
         10: LSI oscillator clock used as the RTC clock
         11: HSE oscillator clock divided by a programmable prescaler (selection through the
         RTCPRE[4:0] bits in the RCC clock configuration register (RCC_CFGR)) used as the RTC
         clock
        */
        alias RTCSEL = BitField!(9, 8, Mutability.rw);

        /********************************************************************************
         External low-speed oscillator bypass 
         This bit is set and cleared by software to bypass the oscillator. This bit can be written only
         when the LSE clock is disabled.
         0: LSE oscillator not bypassed
         1: LSE oscillator bypassed
        */
        alias LSEBYP = Bit!(2, Mutability.rw);

        /********************************************************************************
         External low-speed oscillator ready 
         This bit is set and cleared by hardware to indicate when the external 32 kHz oscillator is
         stable. After the LSEON bit is cleared, LSERDY goes low after 6 external low-speed
         oscillator clock cycles.
         0: LSE clock not ready
         1: LSE clock ready
        */
        alias LSERDY = Bit!(1, Mutability.r);

        /********************************************************************************
         External low-speed oscillator enable 
         This bit is set and cleared by software.
         0: LSE clock OFF
         1: LSE clock ON
        */
        alias LSEON = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     RCC clock control & status register
     Wait states are inserted in case of successive accesses to this register.
    */
    final abstract class CSR : Register!(0x74, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Low-power reset flag 
         This bit is set by hardware when a Low-power management reset occurs.
         Cleared by writing to the RMVF bit.
         0: No Low-power management reset occurred
         1: Low-power management reset occurred
         For further information on Low-power management reset, refer to Low-power management
         reset.
        */
        alias LPWRRSTF = Bit!(31, Mutability.r);

        /********************************************************************************
         Window watchdog reset flag 
         This bit is set by hardware when a window watchdog reset occurs.
         Cleared by writing to the RMVF bit.
         0: No window watchdog reset occurred
         1: Window watchdog reset occurred
        */
        alias WWDGRSTF = Bit!(30, Mutability.r);

        /********************************************************************************
         Independent watchdog reset flag 
         This bit is set by hardware when an independent watchdog reset from VDD domain occurs.
         Cleared by writing to the RMVF bit.
         0: No watchdog reset occurred
         1: Watchdog reset occurred
        */
        alias IWDGRSTF = Bit!(29, Mutability.r);

        /********************************************************************************
         Software reset flag 
         This bit is set by hardware when a software reset occurs.
         Cleared by writing to the RMVF bit.
         0: No software reset occurred
         1: Software reset occurred
        */
        alias SFTRSTF = Bit!(28, Mutability.r);

        /********************************************************************************
         POR/PDR reset flag 
         This bit is set by hardware when a POR/PDR reset occurs.
         Cleared by writing to the RMVF bit.
         0: No POR/PDR reset occurred
         1: POR/PDR reset occurred
        */
        alias PORRSTF = Bit!(27, Mutability.r);

        /********************************************************************************
         PIN reset flag 
         This bit is set by hardware when a reset from the NRST pin occurs.
         Cleared by writing to the RMVF bit.
         0: No reset from NRST pin occurred
         1: Reset from NRST pin occurred
        */
        alias PINRSTF = Bit!(26, Mutability.r);

        /********************************************************************************
         BOR reset flag 
         Cleared by software by writing the RMVF bit.
         This bit is set by hardware when a POR/PDR or BOR reset occurs.
         0: No POR/PDR or BOR reset occurred
         1: POR/PDR or BOR reset occurred
        */
        alias BORRSTF = Bit!(25, Mutability.r);

        /********************************************************************************
         Remove reset flag 
         This bit is set by software to clear the reset flags.
         0: No effect
         1: Clear the reset flags
        */
        alias RMVF = Bit!(24, Mutability.rt_w);

        /********************************************************************************
         Internal low-speed oscillator ready 
         This bit is set and cleared by hardware to indicate when the internal RC 40 kHz oscillator is
         stable. After the LSION bit is cleared, LSIRDY goes low after 3 LSI clock cycles.
         0: LSI RC oscillator not ready
         1: LSI RC oscillator ready
        */
        alias LSIRDY = Bit!(1, Mutability.r);

        /********************************************************************************
         Internal low-speed oscillator enable 
         This bit is set and cleared by software.
         0: LSI RC oscillator OFF
         1: LSI RC oscillator ON
        */
        alias LSION = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     RCC spread spectrum clock generation register
     The spread spectrum clock generation is available only for the main PLL.
     The RCC_SSCGR register must be written either before the main PLL is enabled or after
     the main PLL disabled.
     Note: For full details about PLL spread spectrum clock generation (SSCG) characteristics, refer to
     the “Electrical characteristics” section in your device datasheet.
    */
    final abstract class SSCGR : Register!(0x80, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Spread spectrum modulation enable 
         This bit is set and cleared by software.
         0: Spread spectrum modulation DISABLE. (To write after clearing CR[24]=PLLON bit)
         1: Spread spectrum modulation ENABLE. (To write before setting CR[24]=PLLON bit)
        */
        alias SSCGEN = Bit!(31, Mutability.rw);

        /********************************************************************************
         Spread Select 
         This bit is set and cleared by software.
         To write before to set CR[24]=PLLON bit.
         0: Center spread
         1: Down spread
        */
        alias SPREADSEL = Bit!(30, Mutability.rw);

        /********************************************************************************
         Incrementation step 
         These bits are set and cleared by software. To write before setting CR[24]=PLLON bit.
         Configuration input for modulation profile amplitude.
        */
        alias INCSTEP = BitField!(27, 13, Mutability.rw);

        /********************************************************************************
         Modulation period 
         These bits are set and cleared by software. To write before setting CR[24]=PLLON bit.
         Configuration input for modulation profile period.
        */
        alias MODPER = BitField!(12, 0, Mutability.rw);

    }
    /************************************************************************************
     RCC PLLI2S configuration register
     This register is used to configure the PLLI2S clock outputs according to the formulas:
     f(VCO clock) = f(PLLI2S clock input) × (PLLI2SN / PLLM)
     f(PLL I2S clock output) = f(VCO clock) / PLLI2SR
    */
    final abstract class PLLI2SCFGR : Register!(0x84, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         PLLI2S division factor for I2S clocks 
         These bits are set and cleared by software to control the I2S clock frequency. These bits
         should be written only if the PLLI2S is disabled. The factor must be chosen in accordance
         with the prescaler values inside the I2S peripherals, to reach 0.3% error when using
         standard crystals and 0% error with audio crystals. For more information about I2S clock
         frequency and precision, refer to Section 28.4.4: Clock generator in the I2S chapter.
         Caution: The I2Ss requires a frequency lower than or equal to 192 MHz to work correctly.
         I2S clock frequency = VCO frequency / PLLR with 2 ≤ PLLR ≤ 7
         000: PLLR = 0, wrong configuration
         001: PLLR = 1, wrong configuration
         010: PLLR = 2
         ...
         111: PLLR = 7
        */
        alias PLLI2SR = BitField!(30, 28, Mutability.rw);

        /********************************************************************************
         PLLI2S division factor for SAI1 clock 
         These bits are set and cleared by software to control the SAI1 clock frequency.
         They should be written when the PLLI2S is disabled.
         SAI1 clock frequency = VCO frequency / PLLI2SQ with 2 <= PLLI2SIQ <= 15
         0000: PLLI2SQ = 0, wrong configuration
         0001: PLLI2SQ = 1, wrong configuration
         0010: PLLI2SQ = 2
         0011: PLLI2SQ = 3
         0100: PLLI2SQ = 4
         0101: PLLI2SQ = 5
         ...
         1111: PLLI2SQ = 15
        */
        alias PLLI2SQ = BitField!(27, 24, Mutability.rw);

        /********************************************************************************
         PLLI2S multiplication factor for VCO 
         These bits are set and cleared by software to control the multiplication factor of the VCO.
         These bits can be written only when the PLLI2S is disabled. Only half-word and word
         accesses are allowed to write these bits.
         Caution: The software has to set these bits correctly to ensure that the VCO output
         frequency is between 192 and 432 MHz.
         VCO output frequency = VCO input frequency × PLLI2SN with 192 ≤ PLLI2SN ≤ 432
         000000000: PLLI2SN = 0, wrong configuration
         000000001: PLLI2SN = 1, wrong configuration
         ...
         011000000: PLLI2SN = 192
         011000001: PLLI2SN = 193
         011000010: PLLI2SN = 194
         ...
         110110000: PLLI2SN = 432
         110110000: PLLI2SN = 433, wrong configuration
         ...
         111111111: PLLI2SN = 511, wrong configuration
        */
        alias PLLI2SN = BitField!(14, 6, Mutability.rw);

    }
    /************************************************************************************
     RCC PLL configuration register
     This register is used to configure the PLLSAI clock outputs according to the formulas:
     • f(VCO clock) = f(PLLSAI clock input) × (PLLSAIN / PLLM)
     • f(PLLSAI1 clock output) = f(VCO clock) / PLLSAIQ
     • f(PLL LCD clock output) = f(VCO clock) / PLLSAIR
    */
    final abstract class PLLSAICFGR : Register!(0x88, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         PLLSAI division factor for LCD clock 
         Set and reset by software to control the LCD clock frequency.
         These bits should be written when the PLLSAI is disabled.
         LCD clock frequency = VCO frequency / PLLSAIR with 2 ≤ PLLSAIR ≤ 7
         000: PLLSAIR = 0, wrong configuration
         001: PLLSAIR = 1, wrong configuration
         010: PLLSAIR = 2
         ...
         111: PLLSAIR = 7
        */
        alias PLLSAIR = BitField!(30, 28, Mutability.rw);

        /********************************************************************************
         PLLSAI division factor for SAI1 clock 
         Set and reset by software to control the frequency of SAI1 clock.
         These bits should be written when the PLLSAI is disabled.
         SAI1 clock frequency = VCO frequency / PLLSAIQ with 2 ≤ PLLSAIQ ≤15
         0000: PLLSAIQ = 0, wrong configuration
         0001: PLLSAIQ = 1, wrong configuration
         ...
         0010: PLLSAIQ = 2
         0011: PLLSAIQ = 3
         0100: PLLSAIQ = 4
         0101: PLLSAIQ = 5
         ...
         1111: PLLSAIQ = 15
        */
        alias PLLSAIQ = BitField!(27, 24, Mutability.rw);

        /********************************************************************************
         PLLSAI division factor for VCO 
         Set and reset by software to control the multiplication factor of the VCO.
         These bits should be written when the PLLSAI is disabled.
         Only half-word and word accesses are allowed to write these bits.
         VCO output frequency = VCO input frequency x PLLSAIN with 49 ≤ PLLSAIN ≤ 432
         000000000: PLLSAIN = 0, wrong configuration
         000000001: PLLSAIN = 1, wrong configuration
         ......
         000110000: PLLSAIN = 48, wrong configuration
         000110001: PLLSAIN = 49
         ...
         011000000: PLLSAIN = 192
         011000001: PLLSAIN = 193
         ...
         110110000: PLLSAIN = 432
         110110000: PLLSAIN = 433, wrong configuration
         ...
         111111111: PLLSAIN = 511, wrong configuration
        */
        alias PLLSAIN = BitField!(14, 6, Mutability.rw);

    }
    /************************************************************************************
     RCC Dedicated Clock Configuration Register
     The RCC_DCKCFGR register allows to configure the timer clock prescalers and the PLLSAI
     and PLLI2S output clock dividers for SAI1 and LTDC peripherals according to the following
     formula:
     f(PLLSAIDIVQ clock output) = f(PLLSAI_Q) / PLLSAIDIVQ
     f(PLLSAIDIVR clock output) = f(PLLSAI_R) / PLLSAIDIVR
     f(PLLI2SDIVQ clock output) = f(PLLI2S_Q) / PLLI2SDIVQ
    */
    final abstract class DCKCFGR : Register!(0x8C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Timers clocks prescalers selection 
         This bit is set and reset by software to control the clock frequency of all the timers connected
         to APB1 and APB2 domain.
         0: If the APB prescaler (PPRE1, PPRE2 in the RCC_CFGR register) is configured to a
         division factor of 1, TIMxCLK = PCLKx. Otherwise, the timer clock frequencies are set to
         twice to the frequency of the APB domain to which the timers are connected:
         TIMxCLK = 2xPCLKx.
         1:If the APB prescaler (PPRE1, PPRE2 in the RCC_CFGR register) is configured to a
         division factor of 1, 2 or 4, TIMxCLK = HCLK. Otherwise, the timer clock frequencies are set
         to four times to the frequency of the APB domain to which the timers are connected:
         TIMxCLK = 4xPCLKx.
        */
        alias TIMPRE = Bit!(24, Mutability.rw);

        /********************************************************************************
         SAI1-B clock source selection 
         These bits are set and cleared by software to control the SAI1-B clock frequency.
         They should be written when the PLLSAI and PLLI2S are disabled.
         00: SAI1-B clock frequency = f(PLLSAI_Q) / PLLSAIDIVQ
         01: SAI1-B clock frequency = f(PLLI2S_Q) / PLLI2SDIVQ
         10: SAI1-B clock frequency = Alternate function input frequency
         11: wrong configuration
        */
        alias SAI1BSRC = BitField!(23, 22, Mutability.rw);

        /********************************************************************************
         SAI1-A clock source selection 
         These bits are set and cleared by software to control the SAI1-A clock frequency.
         They should be written when the PLLSAI and PLLI2S are disabled.
         00: SAI1-A clock frequency = f(PLLSAI_Q) / PLLSAIDIVQ
         01: SAI1-A clock frequency = f(PLLI2S_Q) / PLLI2SDIVQ
         10: SAI1-A clock frequency = Alternate function input frequency
         11: wrong configuration
        */
        alias SAI1ASRC = BitField!(21, 20, Mutability.rw);

        /********************************************************************************
         division factor for LCD_CLK 
         These bits are set and cleared by software to control the frequency of LCD_CLK.
         They should be written only if PLLSAI is disabled.
         LCD_CLK frequency = f(PLLSAI_R) / PLLSAIDIVR with 2 ≤ PLLSAIDIVR ≤ 16
         00: PLLSAIDIVR = /2
         01: PLLSAIDIVR = /4
         10: PLLSAIDIVR = /8
         11: PLLSAIDIVR = /16
        */
        alias PLLSAIDIVR = BitField!(17, 16, Mutability.rw);

        /********************************************************************************
         PLLSAI division factor for SAI1 clock 
         These bits are set and reset by software to control the SAI1 clock frequency.
         They should be written only if PLLSAI is disabled.
         SAI1 clock frequency = f(PLLSAI_Q) / PLLSAIDIVQ with 1 ≤ PLLSAIDIVQ ≤ 31
         00000: PLLSAIDIVQ = /1
         00001: PLLSAIDIVQ = /2
         00010: PLLSAIDIVQ = /3
         00011: PLLSAIDIVQ = /4
         00100: PLLSAIDIVQ = /5
         ...
         11111: PLLSAIDIVQ = /32
        */
        alias PLLSAIDIVQ = BitField!(12, 8, Mutability.rw);

        /********************************************************************************
         PLLI2S division factor for SAI1 clock 
         These bits are set and reset by software to control the SAI1 clock frequency.
         They should be written only if PLLI2S is disabled.
         SAI1 clock frequency = f(PLLI2S_Q) / PLLI2SDIVQ with 1 <= PLLI2SDIVQ <= 31
         00000: PLLI2SDIVQ = /1
         00001: PLLI2SDIVQ = /2
         00010: PLLI2SDIVQ = /3
         00011: PLLI2SDIVQ = /4
         00100: PLLI2SDIVQ = /5
         ...
         11111: PLLI2SDIVQ = /32
        */
        alias PLLI2SDIVQ = BitField!(4, 0, Mutability.rw);

    }
}