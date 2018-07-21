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

nothrow:
@safe:

import stm32f42.trace;

import lcd = board.lcd;
import statusLED = board.statusLED;
import random = board.random;

extern(C) void main(string[] args)
{
    enum width = lcd.getWidth();
    enum height = lcd.getHeight();

    uint i = 0;
    while(true)
    {
        uint r = random.get();
        ushort color = cast(ushort)(r & 0xFFFF);

        r = random.get();
        uint x = (r >> 16) % width;
        uint y = r % height;

        r = random.get();
        uint w = (r >> 16) % (width - x);
        uint h = r % (height - y);

        lcd.fillRect(x, y, w, h, color);
        if ((i % 1000) == 0)
        {
            statusLED.toggle();
        }

        i++;
    }
}