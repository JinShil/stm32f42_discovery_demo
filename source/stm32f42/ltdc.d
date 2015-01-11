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

module ltdc;

import mmio;
import bus;

/****************************************************************************************
 LCD-TFT Controller
*/
final abstract class LTDC : Peripheral!(AHB1, 0x00000040)
{
    /************************************************************************************
     LTDC Synchronization Size Configuration Register
     This register defines the number of Horizontal Synchronization pixels minus 1 and the
     number of Vertical Synchronization lines minus 1. Refer to Figure 82 and Section 16.4:
     LTDC programmable parameters for an example of configuration.
    */
    final abstract class SSCR : Register!(0x08, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Horizontal Synchronization Width (in units of pixel clock period) 
         These bits define the number of Horizontal Synchronization pixel minus 1.
        */
        alias HSW = BitField!(27, 16, Mutability.rw);

        /********************************************************************************
         Vertical Synchronization Height (in units of horizontal scan line) 
         These bits define the vertical Synchronization height minus 1. It represents the
         number
         of horizontal synchronization lines.
        */
        alias VSH = BitField!(10, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Back Porch Configuration Register
     This register defines the accumulated number of Horizontal Synchronization and back porch
     pixels minus 1 (HSYNC Width + HBP- 1) and the accumulated number of Vertical
     Synchronization and back porch lines minus 1 (VSYNC Height + VBP - 1). Refer to
     Figure 82 and Section 16.4: LTDC programmable parameters for an example of
     configuration.
    */
    final abstract class BPCR : Register!(0x0C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Accumulated Horizontal back porch (in units of pixel clock period) 
         These bits define the Accumulated Horizontal back porch width which includes the
         Horizontal Synchronization and Horizontal back porch pixels minus 1.
         The Horizontal back porch is the period between Horizontal Synchronization going
         inactive and the start of the active display part of the next scan line.
        */
        alias AHBP = BitField!(27, 16, Mutability.rw);

        /********************************************************************************
         Accumulated Vertical back porch (in units of horizontal scan line) 
         These bits define the accumulated Vertical back porch width which includes the Vertical
         Synchronization and Vertical back porch lines minus 1.
         The Vertical back porch is the number of horizontal scan lines at a start of frame to the
         start of the first active scan line of the next frame.
        */
        alias AVBP = BitField!(10, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Active Width Configuration Register
     This register defines the accumulated number of Horizontal Synchronization, back porch
     and Active pixels minus 1 (HSYNC width + HBP + Active Width - 1) and the accumulated
     number of Vertical Synchronization, back porch lines and Active lines minus 1 (VSYNC
     Height+ BVBP + Active Height - 1). Refer to Figure 82 and Section 16.4: LTDC
     programmable parameters for an example of configuration.
    */
    final abstract class AWCR : Register!(0x10, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Accumulated Active Width (in units of pixel clock period) 
         These bits define the Accumulated Active Width which includes the Horizontal
         Synchronization, Horizontal back porch and Active pixels minus 1.
         The Active Width is the number of pixels in active display area of the panel scan line. The
         maximum Active Width supported is 0x400.
        */
        alias AAW = BitField!(27, 16, Mutability.rw);

        /********************************************************************************
         Accumulated Active Height (in units of horizontal scan line) 
         These bits define the Accumulated Height which includes the Vertical Synchronization,
         Vertical back porch and the Active Height lines minus 1. The Active Height is the number
         of active lines in the panel. The maximum Active Height supported is 0x300.
        */
        alias AAH = BitField!(10, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Total Width Configuration Register
     This register defines the accumulated number of Horizontal Synchronization, back porch,
     Active and front porch pixels minus 1 (HSYNC Width + HBP + Active Width + HFP - 1) and
     the accumulated number of Vertical Synchronization, back porch lines, Active and Front
     lines minus 1 (VSYNC Height+ BVBP + Active Height + VFP - 1). Refer to Figure 82 and
     Section 16.4: LTDC programmable parameters for an example of configuration.
    */
    final abstract class TWCR : Register!(0x14, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Total Width (in units of pixel clock period) 
         These bits defines the accumulated Total Width which includes the Horizontal
         Synchronization, Horizontal back porch, Active Width and Horizontal front porch pixels
         minus 1.
        */
        alias TOTALW = BitField!(27, 16, Mutability.rw);

        /********************************************************************************
         Total Height (in units of horizontal scan line) 
         These bits defines the accumulated Height which includes the Vertical Synchronization,
         Vertical back porch, the Active Height and Vertical front porch Height lines minus 1.
        */
        alias TOTALH = BitField!(10, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Global Control Register
     This register defines the global configuration of the LCD-TFT controller.
    */
    final abstract class GCR : Register!(0x18, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Horizontal Synchronization Polarity 
         This bit is set and cleared by software.
         0: Horizontal Synchronization polarity is active low
         1: Horizontal Synchronization polarity is active high
        */
        alias HSPOL = Bit!(31, Mutability.rw);

        /********************************************************************************
         Vertical Synchronization Polarity 
         This bit is set and cleared by software.
         0: Vertical Synchronization is active low
         1: Vertical Synchronization is active high
        */
        alias VSPOL = Bit!(30, Mutability.rw);

        /********************************************************************************
         Data Enable Polarity 
         This bit is set and cleared by software.
         0: Data Enable polarity is active low
         1: Data Enable polarity is active high
        */
        alias DEPOL = Bit!(29, Mutability.rw);

        /********************************************************************************
         Pixel Clock Polarity 
         This bit is set and cleared by software.
         0: input pixel clock
         1: inverted input pixel clock
        */
        alias PCPOL = Bit!(28, Mutability.rw);

        /********************************************************************************
         Dither Enable 
         This bit is set and cleared by software.
         0: Dither disable
         1: Dither enable
        */
        alias DEN = Bit!(16, Mutability.rw);

        /********************************************************************************
         Dither Red Width 
         These bits return the Dither Red Bits
        */
        alias DRW = BitField!(14, 12, Mutability.r);

        /********************************************************************************
         Dither Green Width 
         These bits return the Dither Green Bits
        */
        alias DGW = BitField!(10, 8, Mutability.r);

        /********************************************************************************
         Dither Blue Width 
         These bits return the Dither Blue Bits
        */
        alias DBW = BitField!(6, 4, Mutability.r);

        /********************************************************************************
         LCD-TFT controller enable bit 
         This bit is set and cleared by software.
         0: LTDC disable
         1: LTDC enable
        */
        alias LTDCEN = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Shadow Reload Configuration Register
     This register allows to reload either immediately or during the vertical blanking period, the
     shadow registers values to the active registers. The shadow registers are all Layer 1 and
     Layer 2 registers except the LTDC_L1CLUTWR and the LTDC_L2CLUTWR.
     Note: The shadow registers read back the active values. Until the reload has been done, the 'old'
     value will be read.
    */
    final abstract class SRCR : Register!(0x24, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Vertical Blanking Reload 
         This bit is set by software and cleared only by hardware after reload. (it cannot
         be cleared through register write once it is set)
         0: No effect
         1: The shadow registers are reloaded during the vertical blanking period (at the
         beginning of the first line after the Active Display Area)
        */
        alias VBR = Bit!(1, Mutability.rw);

        /********************************************************************************
         Immediate Reload 
         This bit is set by software and cleared only by hardware after reload.
         0: No effect
         1: The shadow registers are reloaded immediately
        */
        alias IMR = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Background Color Configuration Register
     This register defines the background color (RGB888).
    */
    final abstract class BCCR : Register!(0x2C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Background Color Red value 
         These bits configure the background red value
        */
        alias BCRED = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         Background Color Green value 
         These bits configure the background green value
        */
        alias BCGREEN = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         Background Color Blue value 
         These bits configure the background blue value
        */
        alias BCBLUE = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Interrupt Enable Register
     This register determines which status flags generate an interrupt request by setting the
     corresponding bit to 1.
    */
    final abstract class IER : Register!(0x34, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Register Reload interrupt enable 
         This bit is set and cleared by software
         0: Register Reload interrupt disable
         1: Register Reload interrupt enable
        */
        alias RRIE = Bit!(3, Mutability.rw);

        /********************************************************************************
         Transfer Error Interrupt Enable 
         This bit is set and cleared by software
         0: Transfer Error interrupt disable
         1: Transfer Error interrupt enable
        */
        alias TERRIE = Bit!(2, Mutability.rw);

        /********************************************************************************
         FIFO Underrun Interrupt Enable 
         This bit is set and cleared by software
         0: FIFO Underrun interrupt disable
         1: FIFO Underrun Interrupt enable
        */
        alias FUIE = Bit!(1, Mutability.rw);

        /********************************************************************************
         Line Interrupt Enable 
         This bit is set and cleared by software
         0: Line interrupt disable
         1: Line Interrupt enable
        */
        alias LIE = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Interrupt Status Register
     This register returns the interrupt status flag
    */
    final abstract class ISR : Register!(0x38, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Register Reload Interrupt Flag 
         0: No Register Reload interrupt generated
         1: Register Reload interrupt generated when a vertical blanking reload occurs (and the
         first line after the active area is reached)
        */
        alias RRIF = Bit!(3, Mutability.r);

        /********************************************************************************
         Transfer Error interrupt flag 
         0: No Transfer Error interrupt generated
         1: Transfer Error interrupt generated when a Bus error occurs
        */
        alias TERRIF = Bit!(2, Mutability.r);

        /********************************************************************************
         FIFO Underrun Interrupt flag 
         0: NO FIFO Underrun interrupt generated.
         1: A FIFO underrun interrupt is generated, if one of the layer FIFOs is empty and pixel
         data is read from the FIFO
        */
        alias FUIF = Bit!(1, Mutability.r);

        /********************************************************************************
         Line Interrupt flag 
         0: No Line interrupt generated
         1: A Line interrupt is generated, when a programmed line is reached
        */
        alias LIF = Bit!(0, Mutability.r);

    }
    /************************************************************************************
     LTDC Interrupt Clear Register
    */
    final abstract class ICR : Register!(0x3C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Clears Register Reload Interrupt Flag 
         0: No effect
         1: Clears the RRIF flag in the LTDC_ISR register
        */
        alias CRRIF = Bit!(3, Mutability.w);

        /********************************************************************************
         Clears the Transfer Error Interrupt Flag 
         0: No effect
         1: Clears the TERRIF flag in the LTDC_ISR register.
        */
        alias CTERRIF = Bit!(2, Mutability.w);

        /********************************************************************************
         Clears the FIFO Underrun Interrupt flag 
         0: No effect
         1: Clears the FUDERRIF flag in the LTDC_ISR register.
        */
        alias CFUIF = Bit!(1, Mutability.w);

        /********************************************************************************
         Clears the Line Interrupt Flag 
         0: No effect
         1: Clears the LIF flag in the LTDC_ISR register.
        */
        alias CLIF = Bit!(0, Mutability.w);

    }
    /************************************************************************************
     LTDC Line Interrupt Position Configuration Register
     This register defines the position of the line interrupt. The line value to be programmed
     depends on the timings parameters. Refer to Figure 82.
    */
    final abstract class LIPCR : Register!(0x40, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Line Interrupt Position 
         These bits configure the line interrupt position
        */
        alias LIPOS = BitField!(10, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Current Position Status Register
     This register defines the position of the line interrupt. The line value to be programmed
     depends on the timings parameters. Refer to Figure 82.
    */
    final abstract class CPSR : Register!(0x44, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Current X Position 
         These bits return the current X position
        */
        alias CXPOS = BitField!(31, 16, Mutability.r);

        /********************************************************************************
         Current Y Position 
         These bits return the current Y position
        */
        alias CYPOS = BitField!(15, 0, Mutability.r);

    }
    /************************************************************************************
     LTDC Current Display Status Register
     This register returns the status of the current display phase which is controlled by the
     HSYNC, VSYNC, and Horizontal/Vertical DE signals.
     Example: if the current display phase is the vertical synchronization, the VSYNCS bit is set
     (active high). If the current display phase is the horizontal synchronization, the HSYNCS bit
     is active high.
    */
    final abstract class CDSR : Register!(0x48, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Horizontal Synchronization display Status 
         0: Active low
         1: Active high
        */
        alias HSYNCS = Bit!(3, Mutability.r);

        /********************************************************************************
         Vertical Synchronization display Status 
         0: Active low
         1: Active high
        */
        alias VSYNCS = Bit!(2, Mutability.r);

        /********************************************************************************
         Horizontal Data Enable display Status 
         0: Active low
         1: Active high
        */
        alias HDES = Bit!(1, Mutability.r);

        /********************************************************************************
         Vertical Data Enable display Status 
         0: Active low
         1: Active high
        */
        alias VDES = Bit!(0, Mutability.r);

    }
    /************************************************************************************
     LTDC Layer 1 Control Register
    */
    final abstract class L1CR : Register!(0x84, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Color Look-Up Table Enable 
         This bit is set and cleared by software.
         0: Color Look-Up Table disable
         1: Color Look-Up Table enable
         The CLUT is only meaningful for L8, AL44 and AL88 pixel format. Refer to Color Look-Up
         Table (CLUT) on page 484
        */
        alias CLUTEN = Bit!(4, Mutability.rw);

        /********************************************************************************
         Color Keying Enable 
         This bit is set and cleared by software.
         0: Color Keying disable
         1: Color Keying enable
        */
        alias COLKEN = Bit!(1, Mutability.rw);

        /********************************************************************************
         Layer Enable 
         This bit is set and cleared by software.
         0: Layer disable
         1: Layer enable
        */
        alias LEN = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 2 Control Register
    */
    final abstract class L2CR : Register!(0x0104, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Color Look-Up Table Enable 
         This bit is set and cleared by software.
         0: Color Look-Up Table disable
         1: Color Look-Up Table enable
         The CLUT is only meaningful for L8, AL44 and AL88 pixel format. Refer to Color Look-Up
         Table (CLUT) on page 484
        */
        alias CLUTEN = Bit!(4, Mutability.rw);

        /********************************************************************************
         Color Keying Enable 
         This bit is set and cleared by software.
         0: Color Keying disable
         1: Color Keying enable
        */
        alias COLKEN = Bit!(1, Mutability.rw);

        /********************************************************************************
         Layer Enable 
         This bit is set and cleared by software.
         0: Layer disable
         1: Layer enable
        */
        alias LEN = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 1 Window Horizontal Position Configuration Register
     This register defines the Horizontal Position (first and last pixel) of the layer 1 or 2 window.
     The first visible pixel of a line is the programmed value of AHBP[10:0] bits + 1 in the
     LTDC_BPCR register.
     Example:
     The LTDC_BPCR register is configured to 0x000E0005(AHBP[11:0] is 0xE) and the
     LTDC_AWCR register is configured to 0x028E01E5(AAW[11:0] is 0x28E). To configure the
     horizontal position of a window size of 630x460, with horizontal start offset of 5 pixels in the
     Active data area.
     1. Layer window first pixel: WHSTPOS[11:0] should be programmed to 0x14 (0xE+1+0x5)
     2. Layer window last pixel: WHSPPOS[11:0] should be programmed to 0x28A
     The last visible pixel of a line is the programmed value of AAW[10:0] bits in the
     LTDC_AWCR register. All values within this range are allowed.
    */
    final abstract class L1WHPCR : Register!(0x88, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Window Horizontal Stop Position 
         These bits configure the last visible pixel of a line of the layer window.
        */
        alias WHSPPOS = BitField!(27, 16, Mutability.rw);

        /********************************************************************************
         Window Horizontal Start Position 
         These bits configure the first visible pixel of a line of the layer window.
        */
        alias WHSTPOS = BitField!(11, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 2 Window Horizontal Position Configuration Register
     This register defines the Horizontal Position (first and last pixel) of the layer 1 or 2 window.
     The first visible pixel of a line is the programmed value of AHBP[10:0] bits + 1 in the
     LTDC_BPCR register.
     Example:
     The LTDC_BPCR register is configured to 0x000E0005(AHBP[11:0] is 0xE) and the
     LTDC_AWCR register is configured to 0x028E01E5(AAW[11:0] is 0x28E). To configure the
     horizontal position of a window size of 630x460, with horizontal start offset of 5 pixels in the
     Active data area.
     1. Layer window first pixel: WHSTPOS[11:0] should be programmed to 0x14 (0xE+1+0x5)
     2. Layer window last pixel: WHSPPOS[11:0] should be programmed to 0x28A
     The last visible pixel of a line is the programmed value of AAW[10:0] bits in the
     LTDC_AWCR register. All values within this range are allowed.
    */
    final abstract class L2WHPCR : Register!(0x0108, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Window Horizontal Stop Position 
         These bits configure the last visible pixel of a line of the layer window.
        */
        alias WHSPPOS = BitField!(27, 16, Mutability.rw);

        /********************************************************************************
         Window Horizontal Start Position 
         These bits configure the first visible pixel of a line of the layer window.
        */
        alias WHSTPOS = BitField!(11, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 1 Window Vertical Position Configuration Register
     This register defines the vertical position (first and last line) of the layer1 or 2 window.
     The first visible line of a frame is the programmed value of AVBP[10:0] bits + 1 in the
     register LTDC_BPCR register.
     The last visible line of a frame is the programmed value of AAH[10:0] bits in the
     LTDC_AWCR register. All values within this range are allowed.
     Example:
     The LTDC_BPCR register is configured to 0x000E0005 (AVBP[10:0] is 0x5) and the
     LTDC_AWCR register is configured to 0x028E01E5 (AAH[10:0] is 0x1E5). To configure the
     vertical position of a window size of 630x460, with vertical start offset of 8 lines in the Active
     data area:
     1. Layer window first line: WVSTPOS[10:0] should be programmed to 0xE (0x5 + 1 + 0x8)
     2. Layer window last line: WVSPPOS[10:0] should be programmed to 0x1DA
    */
    final abstract class L1WVPCR : Register!(0x8C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Window Vertical Stop Position 
         These bits configures the last visible line of the layer window.
        */
        alias WVSPPOS = BitField!(26, 16, Mutability.rw);

        /********************************************************************************
         Window Vertical Start Position 
         These bits configure the first visible line of the layer window.
        */
        alias WVSTPOS = BitField!(10, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 2 Window Vertical Position Configuration Register
     This register defines the vertical position (first and last line) of the layer1 or 2 window.
     The first visible line of a frame is the programmed value of AVBP[10:0] bits + 1 in the
     register LTDC_BPCR register.
     The last visible line of a frame is the programmed value of AAH[10:0] bits in the
     LTDC_AWCR register. All values within this range are allowed.
     Example:
     The LTDC_BPCR register is configured to 0x000E0005 (AVBP[10:0] is 0x5) and the
     LTDC_AWCR register is configured to 0x028E01E5 (AAH[10:0] is 0x1E5). To configure the
     vertical position of a window size of 630x460, with vertical start offset of 8 lines in the Active
     data area:
     1. Layer window first line: WVSTPOS[10:0] should be programmed to 0xE (0x5 + 1 + 0x8)
     2. Layer window last line: WVSPPOS[10:0] should be programmed to 0x1DA
    */
    final abstract class L2WVPCR : Register!(0x010C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Window Vertical Stop Position 
         These bits configures the last visible line of the layer window.
        */
        alias WVSPPOS = BitField!(26, 16, Mutability.rw);

        /********************************************************************************
         Window Vertical Start Position 
         These bits configure the first visible line of the layer window.
        */
        alias WVSTPOS = BitField!(10, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 1 Color Keying Configuration Register
     This register defines the color key value (RGB), which is used by the Color Keying.
    */
    final abstract class L1CKCR : Register!(0x90, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Color Key Red value 
        */
        alias CKRED = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         Color Key Green value 
        */
        alias CKGREEN = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         Color Key Blue value 
        */
        alias CKBLUE = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 2 Color Keying Configuration Register
     This register defines the color key value (RGB), which is used by the Color Keying.
    */
    final abstract class L2CKCR : Register!(0x0110, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Color Key Red value 
        */
        alias CKRED = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         Color Key Green value 
        */
        alias CKGREEN = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         Color Key Blue value 
        */
        alias CKBLUE = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 1 Pixel Format Configuration Register
     This register defines the pixel format which is used for the stored data in the frame buffer of
     a layer. The pixel data is read from the frame buffer and then transformed to the internal
     format 8888 (ARGB).
    */
    final abstract class L1PFCR : Register!(0x94, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Pixel Format 
         These bits configures the Pixel format
         000: ARGB8888
         001: RGB888
         010: RGB565
         011: ARGB1555
         100: ARGB4444
         101: L8 (8-Bit Luminance)
         110: AL44 (4-Bit Alpha, 4-Bit Luminance)
         111: AL88 (8-Bit Alpha, 8-Bit Luminance)
        */
        alias PF = BitField!(2, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 2 Pixel Format Configuration Register
     This register defines the pixel format which is used for the stored data in the frame buffer of
     a layer. The pixel data is read from the frame buffer and then transformed to the internal
     format 8888 (ARGB).
    */
    final abstract class L2PFCR : Register!(0x0114, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Pixel Format 
         These bits configures the Pixel format
         000: ARGB8888
         001: RGB888
         010: RGB565
         011: ARGB1555
         100: ARGB4444
         101: L8 (8-Bit Luminance)
         110: AL44 (4-Bit Alpha, 4-Bit Luminance)
         111: AL88 (8-Bit Alpha, 8-Bit Luminance)
        */
        alias PF = BitField!(2, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 1 Constant Alpha Configuration Register
     This register defines the constant alpha value (divided by 255 by Hardware), which is used
     in the alpha blending. Refer to LTDC_L1BFCR register.
    */
    final abstract class L1CACR : Register!(0x98, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Constant Alpha 
         These bits configure the Constant Alpha used for blending. The Constant Alpha is divided
         by 255 by hardware.
         Example: if the programmed Constant Alpha is 0xFF, the Constant Alpha value is
         255/255=1
        */
        alias CONSTA = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 2 Constant Alpha Configuration Register
     This register defines the constant alpha value (divided by 255 by Hardware), which is used
     in the alpha blending. Refer to LTDC_L2BFCR register.
    */
    final abstract class L2CACR : Register!(0x0118, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Constant Alpha 
         These bits configure the Constant Alpha used for blending. The Constant Alpha is divided
         by 255 by hardware.
         Example: if the programmed Constant Alpha is 0xFF, the Constant Alpha value is
         255/255=1
        */
        alias CONSTA = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 1 Default Color Configuration Register
     This register defines the default color of a layer in the format ARGB. The default color is
     used outside the defined layer window or when a layer is disabled. The reset value of
     0x00000000 defines a transparent black color.
    */
    final abstract class L1DCCR : Register!(0x9C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Default Color Alpha 
         These bits configure the default alpha value
        */
        alias DCALPHA = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         Default Color Red 
         These bits configure the default red value
        */
        alias DCRED = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         Default Color Green 
         These bits configure the default green value
        */
        alias DCGREEN = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         Default Color Blue 
         These bits configure the default blue value
        */
        alias DCBLUE = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 2 Default Color Configuration Register
     This register defines the default color of a layer in the format ARGB. The default color is
     used outside the defined layer window or when a layer is disabled. The reset value of
     0x00000000 defines a transparent black color.
    */
    final abstract class L2DCCR : Register!(0x011C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Default Color Alpha 
         These bits configure the default alpha value
        */
        alias DCALPHA = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         Default Color Red 
         These bits configure the default red value
        */
        alias DCRED = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         Default Color Green 
         These bits configure the default green value
        */
        alias DCGREEN = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         Default Color Blue 
         These bits configure the default blue value
        */
        alias DCBLUE = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 1 Blending Factors Configuration Register
     This register defines the default color of a layer in the format ARGB. The default color is
     used outside the defined layer window or when a layer is disabled. The reset value of
     0x00000000 defines a transparent black color.
    */
    final abstract class L1BFCR : Register!(0xA0, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Blending Factor 1 
         These bits select the blending factor F1
         000: Reserved
         001: Reserved
         010: Reserved
         011: Reserved
         100: Constant Alpha
         101: Reserved
         110: Pixel Alpha x Constant Alpha
         111:Reserved
        */
        alias BF1 = BitField!(10, 8, Mutability.rw);

        /********************************************************************************
         Blending Factor 2 
         These bits select the blending factor F2
         000: Reserved
         001: Reserved
         010: Reserved
         011: Reserved
         100: Reserved
         101: 1 - Constant Alpha
         110: Reserved
         111: 1 - (Pixel Alpha x Constant Alpha)
        */
        alias BF2 = BitField!(2, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 2 Blending Factors Configuration Register
     This register defines the default color of a layer in the format ARGB. The default color is
     used outside the defined layer window or when a layer is disabled. The reset value of
     0x00000000 defines a transparent black color.
    */
    final abstract class L2BFCR : Register!(0x0120, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Blending Factor 1 
         These bits select the blending factor F1
         000: Reserved
         001: Reserved
         010: Reserved
         011: Reserved
         100: Constant Alpha
         101: Reserved
         110: Pixel Alpha x Constant Alpha
         111:Reserved
        */
        alias BF1 = BitField!(10, 8, Mutability.rw);

        /********************************************************************************
         Blending Factor 2 
         These bits select the blending factor F2
         000: Reserved
         001: Reserved
         010: Reserved
         011: Reserved
         100: Reserved
         101: 1 - Constant Alpha
         110: Reserved
         111: 1 - (Pixel Alpha x Constant Alpha)
        */
        alias BF2 = BitField!(2, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 1 Color Frame Buffer Address Register
     This register defines the color frame buffer start address which has to point to the address
     where the pixel data of the top left pixel of a layer is stored in the frame buffer.
    */
    final abstract class L1CFBAR : Register!(0xAC, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Color Frame Buffer Start Address 
         These bits defines the color frame buffer start address.
        */
        alias CFBADD = BitField!(31, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 2 Color Frame Buffer Address Register
     This register defines the color frame buffer start address which has to point to the address
     where the pixel data of the top left pixel of a layer is stored in the frame buffer.
    */
    final abstract class L2CFBAR : Register!(0x012C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Color Frame Buffer Start Address 
         These bits defines the color frame buffer start address.
        */
        alias CFBADD = BitField!(31, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 1 Color Frame Buffer Length Register
     This register defines the color frame buffer line length and pitch.
     Example:
     • A frame buffer having the format RGB565 (2 bytes per pixel) and a width of 256 pixels
     (total number of bytes per line is 256x2=512 bytes), where pitch = line length requires a
     value of 0x02000203 to be written into this register.
     • A frame buffer having the format RGB888 (3 bytes per pixel) and a width of 320 pixels
     (total number of bytes per line is 320x3=960), where pitch = line length requires a value
     of 0x03C003C3 to be written into this register.
    */
    final abstract class L1CFBLR : Register!(0xB0, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Color Frame Buffer Pitch in bytes 
         These bits define the pitch which is the increment from the start of one line of pixels to the
         start of the next line in bytes.
        */
        alias CFBP = BitField!(28, 16, Mutability.rw);

        /********************************************************************************
         Color Frame Buffer Line Length 
         These bits define the length of one line of pixels in bytes + 3.
         The line length is computed as follows: Active high width x number of bytes per pixel + 3.
        */
        alias CFBLL = BitField!(12, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 2 Color Frame Buffer Length Register
     This register defines the color frame buffer line length and pitch.
     Example:
     • A frame buffer having the format RGB565 (2 bytes per pixel) and a width of 256 pixels
     (total number of bytes per line is 256x2=512 bytes), where pitch = line length requires a
     value of 0x02000203 to be written into this register.
     • A frame buffer having the format RGB888 (3 bytes per pixel) and a width of 320 pixels
     (total number of bytes per line is 320x3=960), where pitch = line length requires a value
     of 0x03C003C3 to be written into this register.
    */
    final abstract class L2CFBLR : Register!(0x0130, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Color Frame Buffer Pitch in bytes 
         These bits define the pitch which is the increment from the start of one line of pixels to the
         start of the next line in bytes.
        */
        alias CFBP = BitField!(28, 16, Mutability.rw);

        /********************************************************************************
         Color Frame Buffer Line Length 
         These bits define the length of one line of pixels in bytes + 3.
         The line length is computed as follows: Active high width x number of bytes per pixel + 3.
        */
        alias CFBLL = BitField!(12, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 1 ColorFrame Buffer Line Number Register
     This register defines the number of lines in the color frame buffer.
     Note: The number of lines and line length settings define how much data is fetched per frame for
     every layer. If it is configured to less bytes than required, a FIFO underrun interrupt will be
     generated if enabled.
     The start address and pitch settings on the other hand define the correct start of every line in
     memory.
    */
    final abstract class L1CFBLNR : Register!(0xB4, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Frame Buffer Line Number 
         These bits define the number of lines in the frame buffer which corresponds to the Active
         high width.
        */
        alias CFBLNBR = BitField!(10, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 2 ColorFrame Buffer Line Number Register
     This register defines the number of lines in the color frame buffer.
     Note: The number of lines and line length settings define how much data is fetched per frame for
     every layer. If it is configured to less bytes than required, a FIFO underrun interrupt will be
     generated if enabled.
     The start address and pitch settings on the other hand define the correct start of every line in
     memory.
    */
    final abstract class L2CFBLNR : Register!(0x0134, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Frame Buffer Line Number 
         These bits define the number of lines in the frame buffer which corresponds to the Active
         high width.
        */
        alias CFBLNBR = BitField!(10, 0, Mutability.rw);

    }
    /************************************************************************************
     LTDC Layer 1 CLUT Write Register
     This register defines the CLUT address and the RGB value.
     Note: The CLUT write register should only be configured during blanking period or if the layer is
     disabled. The CLUT can be enabled or disabled in the LTDC_LxCR register.
     The CLUT is only meaningful for L8, AL44 and AL88 pixel format.
    */
    final abstract class L1CLUTWR : Register!(0xC4, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         CLUT Address 
         These bits configure the CLUT address (color position within the CLUT) of each RGB
         value
        */
        alias CLUTADD = BitField!(31, 24, Mutability.w);

        /********************************************************************************
         Red value 
         These bits configure the red value
        */
        alias RED = BitField!(23, 16, Mutability.w);

        /********************************************************************************
         Green value 
         These bits configure the green value
        */
        alias GREEN = BitField!(15, 8, Mutability.w);

        /********************************************************************************
         Blue value 
         These bits configure the blue value
        */
        alias BLUE = BitField!(7, 0, Mutability.w);

    }
    /************************************************************************************
     LTDC Layer 2 CLUT Write Register
     This register defines the CLUT address and the RGB value.
     Note: The CLUT write register should only be configured during blanking period or if the layer is
     disabled. The CLUT can be enabled or disabled in the LTDC_LxCR register.
     The CLUT is only meaningful for L8, AL44 and AL88 pixel format.
    */
    final abstract class L2CLUTWR : Register!(0x0144, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         CLUT Address 
         These bits configure the CLUT address (color position within the CLUT) of each RGB
         value
        */
        alias CLUTADD = BitField!(31, 24, Mutability.w);

        /********************************************************************************
         Red value 
         These bits configure the red value
        */
        alias RED = BitField!(23, 16, Mutability.w);

        /********************************************************************************
         Green value 
         These bits configure the green value
        */
        alias GREEN = BitField!(15, 8, Mutability.w);

        /********************************************************************************
         Blue value 
         These bits configure the blue value
        */
        alias BLUE = BitField!(7, 0, Mutability.w);

    }
}