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

module stm32f42.bus;

// see pp. 63 of the STM32F4 datasheet

final abstract class CorePeripherals
{
    static @property uint address()
    {
        return 0xE000_0000;
    }
}

final abstract class AHB1
{
    static @property uint address()
    {
        return 0x4002_0000;
    }
}

final abstract class AHB2
{
    static @property uint address()
    {
        return 0x5000_0000;
    }
}

final abstract class AHB3
{
    static @property uint address()
    {
        return 0x6000_0000;
    }
}

final abstract class APB1
{
    static @property uint address()
    {
        return 0x4000_0000;
    }
}

final abstract class APB2
{
    static @property uint address()
    {
        return 0x4001_0000;
    }
}