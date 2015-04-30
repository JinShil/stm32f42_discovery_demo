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

module board.lcd;

import ILI9341 = board.ILI9341;
import ltdc = board.ltdc;

package void init()
{
	ILI9341.init();
	//ltdc.init();
}

public void fill(ushort color)
{
	ILI9341.fill(color);
	//ltdc.fill(color);
}

public void on()
{
	ILI9341.on();
}

public void off()
{
	ILI9341.off();
}