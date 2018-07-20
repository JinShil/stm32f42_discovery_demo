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

module stm32f42.rng;

import stm32f42.mmio;
import stm32f42.bus;

/****************************************************************************************
 Random Number Generator
*/
final abstract class RNG : Peripheral!(AHB2, 0x60800)
{
    /************************************************************************************
     RNG control register
    */
    final abstract class CR : Register!(0x00, Access.Word)
    {
        /********************************************************************************
         Interrupt enable
         0: RNG Interrupt is disabled
         1: RNG Interrupt is enabled. An interrupt is pending as soon as DRDY=1 or SEIS=1 or
         CEIS=1 in the RNG_SR register.
        */
        alias IE = Bit!(3, Mutability.rw);
        
        /********************************************************************************
         Random number generator enable
         0: Random number generator is disabled
         1: random Number Generator is enabled.
        */
        alias RNGEN = Bit!(2, Mutability.rw);
    }
    
    /************************************************************************************
     RNG status register
    */
    final abstract class SR : Register!(0x04, Access.Word)
    {
        /********************************************************************************
         Data ready
         0: The RNG_DR register is not yet valid, no random data is available
         1: The RNG_DR register contains valid random data
         Note: An interrupt is pending if IE = 1 in the RNG_CR register.
         Once the RNG_DR register has been read, this bit returns to 0 until a new valid value is
         computed..
        */
        alias DRDY = Bit!(0, Mutability.r);
        
        alias CECS = Bit!(1, Mutability.r);
        
        alias SECS = Bit!(2, Mutability.r);
    }
    
    /************************************************************************************
     RNG control register
    
     The RNG_DR register is a read-only register that delivers a 32-bit random value when read.
     After being read, this register delivers a new random value after a maximum time of 40
     periods of the RNG_CLK clock. The software must check that the DRDY bit is set before
     reading the RNDATA value.
    */
    final abstract class DR : Register!(0x08, Access.Word)
    {
        /********************************************************************************
         Random data
         32-bit random data.
        */
        alias RNDATA = BitField!(31, 0, Mutability.r);

    }
}