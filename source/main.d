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

import lcd = board.lcd;
import trace = stm32f42.trace;
import statusLED = board.statusLED;

void main()
{        
    while(true)
    {
    	lcd.fill(0x07E0);
    	statusLED.toggle();
    	lcd.fill(0xF81F);
    	statusLED.toggle();
        //statusLED.on();
        //trace.writeLine("On"); //mostly for delay

		//lcd.fill(0x07E0);
        //statusLED.off();
        //trace.writeLine("Off");
    }
}