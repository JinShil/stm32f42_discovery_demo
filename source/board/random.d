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

module board.random;

import stm32f42.rcc;
import stm32f42.rng;

import trace = stm32f42.trace;

package void init()
{
    RCC.AHB2ENR.RNGEN = true;
    RNG.CR.RNGEN = true;
}

public uint get()
{
    if (RNG.SR.CECS || RNG.SR.SECS)
    {
        trace.writeLine("RNG Error");
        while(true) { }
    }
    while(!RNG.SR.DRDY) { }
    return RNG.DR.RNDATA;
}