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

module stm32f42.dma2d;

import stm32f42.mmio;
import stm32f42.bus;

/****************************************************************************************
 Chrom-Art Accelerator controller
*/
final abstract class DMA2D : Peripheral!(AHB1, 0x0000B000)
{
    /************************************************************************************
     DMA2D control register
    */
    final abstract class CR : Register!(0x0000, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         DMA2D mode 
         This bit is set and cleared by software. It cannot be modified while a transfer is ongoing.
         00: Memory-to-memory (FG fetch only)
         01: Memory-to-memory with PFC (FG fetch only with FG PFC active)
         10: Memory-to-memory with blending (FG and BG fetch with PFC and blending)
         11: Register-to-memory (no FG nor BG, only output stage active)
        */
        alias MODE = BitField!(17, 16, Mutability.rw);

        /********************************************************************************
         Configuration Error Interrupt Enable 
         This bit is set and cleared by software.
         0: CE interrupt disable
         1: CE interrupt enable
        */
        alias CEIE = Bit!(13, Mutability.rw);

        /********************************************************************************
         CLUT transfer complete interrupt enable 
         This bit is set and cleared by software.
         0: CTC interrupt disable
         1: CTC interrupt enable
        */
        alias CTCIE = Bit!(12, Mutability.rw);

        /********************************************************************************
         CLUT access error interrupt enable 
         This bit is set and cleared by software.
         0: CAE interrupt disable
         1: CAE interrupt enable
        */
        alias CAEIE = Bit!(11, Mutability.rw);

        /********************************************************************************
         Transfer watermark interrupt enable 
         This bit is set and cleared by software.
         0: TW interrupt disable
         1: TW interrupt enable
        */
        alias TWIE = Bit!(10, Mutability.rw);

        /********************************************************************************
         Transfer complete interrupt enable 
         This bit is set and cleared by software.
         0: TC interrupt disable
         1: TC interrupt enable
        */
        alias TCIE = Bit!(9, Mutability.rw);

        /********************************************************************************
         Transfer error interrupt enable 
         This bit is set and cleared by software.
         0: TE interrupt disable
         1: TE interrupt enable
        */
        alias TEIE = Bit!(8, Mutability.rw);

        /********************************************************************************
         Abort 
         This bit can be used to abort the current transfer. This bit is set by software and is
         automatically reset by hardware when the START bit is reset.
         0: No transfer abort requested
         1: Transfer abort requested
        */
        alias ABORT = Bit!(2, Mutability.rs);

        /********************************************************************************
         Suspend 
         This bit can be used to suspend the current transfer. This bit is set and reset by
         software. It is automatically reset by hardware when the START bit is reset.
         0: Transfer not suspended
         1: Transfer suspended
        */
        alias SUSP = Bit!(1, Mutability.rw);

        /********************************************************************************
         Start 
         This bit can be used to launch the DMA2D according to the parameters loaded in the
         various configuration registers. This bit is automatically reset by the following events:
         ֠At the end of the transfer
         ֠When the data transfer is aborted by the user application by setting the ABORT
         bit in DMA2D_CR
         ֠When a data transfer error occurs
         ֠When the data transfer has not started due to a configuration error or another
         transfer operation already ongoing (automatic CLUT loading).
        */
        alias START = Bit!(0, Mutability.rs);

    }
    /************************************************************************************
     DMA2D Interrupt Status Register
    */
    final abstract class ISR : Register!(0x0004, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Configuration error interrupt flag 
         This bit is set when the START bit of DMA2D_CR, DMA2DFGPFCCR or
         DMA2D_BGPFCCR is set and a wrong configuration has been programmed.
        */
        alias CEIF = Bit!(5, Mutability.r);

        /********************************************************************************
         CLUT transfer complete interrupt flag 
         This bit is set when the CLUT copy from a system memory area to the internal DMA2D
         memory is complete.
        */
        alias CTCIF = Bit!(4, Mutability.r);

        /********************************************************************************
         CLUT access error interrupt flag 
         This bit is set when the CPU accesses the CLUT while the CLUT is being automatically
         copied from a system memory to the internal DMA2D.
        */
        alias CAEIF = Bit!(3, Mutability.r);

        /********************************************************************************
         Transfer watermark interrupt flag 
         This bit is set when the last pixel of the watermarked line has been transferred.
        */
        alias TWIF = Bit!(2, Mutability.r);

        /********************************************************************************
         Transfer complete interrupt flag 
         This bit is set when a DMA2D transfer operation is complete (data transfer only).
        */
        alias TCIF = Bit!(1, Mutability.r);

        /********************************************************************************
         Transfer error interrupt flag 
         This bit is set when an error occurs during a DMA transfer (data transfer or automatic
         CLUT loading).
        */
        alias TEIF = Bit!(0, Mutability.r);

    }
    /************************************************************************************
     DMA2D interrupt flag clear register
    */
    final abstract class IFCR : Register!(0x0008, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Clear configuration error interrupt flag 
         Programming this bit to 1 clears the CEIF flag in the DMA2D_ISR register
        */
        alias CCEIF = Bit!(5, Mutability.rc_w1);

        /********************************************************************************
         Clear CLUT transfer complete interrupt flag 
         Programming this bit to 1 clears the CTCIF flag in the DMA2D_ISR register
        */
        alias CCTCIF = Bit!(4, Mutability.rc_w1);

        /********************************************************************************
         Clear CLUT access error interrupt flag 
         Programming this bit to 1 clears the CAEIF flag in the DMA2D_ISR register
        */
        alias CAECIF = Bit!(3, Mutability.rc_w1);

        /********************************************************************************
         Clear transfer watermark interrupt flag 
         Programming this bit to 1 clears the TWIF flag in the DMA2D_ISR register
        */
        alias CTWIF = Bit!(2, Mutability.rc_w1);

        /********************************************************************************
         Clear transfer complete interrupt flag 
         Programming this bit to 1 clears the TCIF flag in the DMA2D_ISR register
        */
        alias CTCIF = Bit!(1, Mutability.rc_w1);

        /********************************************************************************
         Clear Transfer error interrupt flag 
         Programming this bit to 1 clears the TEIF flag in the DMA2D_ISR register
        */
        alias CTEIF = Bit!(0, Mutability.rc_w1);

    }
    /************************************************************************************
     DMA2D foreground memory address register
    */
    final abstract class FGMAR : Register!(0x000C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Memory address 
         Address of the data used for the foreground image. This register can only be written
         when data transfers are disabled. Once the data transfer has started, this register is
         read-only.
         The address alignment must match the image format selected e.g. a 32-bit per pixel
         format must be 32-bit aligned, a 16-bit per pixel format must be 16-bit aligned and a 4-
         bit per pixel format must be 8-bit aligned.
        */
        alias MA = BitField!(31, 0, Mutability.rw);

    }
    /************************************************************************************
     DMA2D foreground offset register
    */
    final abstract class FGOR : Register!(0x0010, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Line offset 
         Line offset used for the foreground expressed in pixel. This value is used to generate
         the address. It is added at the end of each line to determine the starting address of the
         next line.
         These bits can only be written when data transfers are disabled. Once a data transfer
         has started, they become read-only.
         If the image format is 4-bit per pixel, the line offset must be even.
        */
        alias LO = BitField!(13, 0, Mutability.rw);

    }
    /************************************************************************************
     DMA2D background memory address register
    */
    final abstract class BGMAR : Register!(0x0014, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Memory address 
         Address of the data used for the background image. This register can only be written
         when data transfers are disabled. Once a data transfer has started, this register is readonly.
         The address alignment must match the image format selected e.g. a 32-bit per pixel
         format must be 32-bit aligned, a 16-bit per pixel format must be 16-bit aligned and a 4-
         bit per pixel format must be 8-bit aligned.
        */
        alias MA = BitField!(31, 0, Mutability.rw);

    }
    /************************************************************************************
     DMA2D background offset register
    */
    final abstract class BGOR : Register!(0x0018, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Line offset 
         Line offset used for the background image (expressed in pixel). This value is used for
         the address generation. It is added at the end of each line to determine the starting
         address of the next line.
         These bits can only be written when data transfers are disabled. Once data transfer has
         started, they become read-only.
         If the image format is 4-bit per pixel, the line offset must be even.
        */
        alias LO = BitField!(13, 0, Mutability.rw);

    }
    /************************************************************************************
     DMA2D foreground PFC control register
    */
    final abstract class FGPFCCR : Register!(0x001C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Alpha value 
         These bits define a fixed alpha channel value which can replace the original alpha value
         or be multiplied by the original alpha value according to the alpha mode selected
         through the AM[1:0] bits.
         These bits can only be written when data transfers are disabled. Once a transfer has
         started, they become read-only.
        */
        alias ALPHA = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         Alpha mode 
         These bits select the alpha channel value to be used for the foreground image. They
         can only be written data the transfer are disabled. Once the transfer has started, they
         become read-only.
         00: No modification of the foreground image alpha channel value
         01: Replace original foreground image alpha channel value by ALPHA[7: 0]
         10: Replace original foreground image alpha channel value by ALPHA[7:0] multiplied
         with original alpha channel value
         other configurations are meaningless
        */
        alias AM = BitField!(17, 16, Mutability.rw);

        /********************************************************************************
         CLUT size 
         These bits define the size of the CLUT used for the foreground image. Once the CLUT
         transfer has started, this field is read-only.
         The number of CLUT entries is equal to CS[7:0] + 1.
        */
        alias CS = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         Start 
         This bit can be set to start the automatic loading of the CLUT. It is automatically reset:
         ֠at the end of the transfer
         ֠when the transfer is aborted by the user application by setting the ABORT bit in
         DMA2D_CR
         ֠when a transfer error occurs
         ֠when the transfer has not started due to a configuration error or another
         transfer operation already ongoing (data transfer or automatic background
         CLUT transfer).
        */
        alias START = Bit!(5, Mutability.rc_w1);

        /********************************************************************************
         CLUT color mode 
         This bit defines the color format of the CLUT. It can only be written when the transfer is
         disabled. Once the CLUT transfer has started, this bit is read-only.
         0: ARGB8888
         1: RGB888
         others: meaningless
        */
        alias CCM = Bit!(4, Mutability.rw);

        /********************************************************************************
         Color mode 
         These bits defines the color format of the foreground image. They can only be written
         when data transfers are disabled. Once the transfer has started, they are read-only.
         0000: ARGB8888
         0001: RGB888
         0010: RGB565
         0011: ARGB1555
         0100: ARGB4444
         0101: L8
         0110: AL44
         0111: AL88
         1000: L4
         1001: A8
         1010: A4
         others: meaningless
        */
        alias CM = BitField!(3, 0, Mutability.rw);

    }
    /************************************************************************************
     DMA2D foreground color register
    */
    final abstract class FGCOLR : Register!(0x0020, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Red Value 
         These bits defines the red value for the A4 or A8 mode of the foreground image. They
         can only be written when data transfers are disabled. Once the transfer has started,
         they are read-only.
        */
        alias RED = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         Green Value 
         These bits defines the green value for the A4 or A8 mode of the foreground image. They
         can only be written when data transfers are disabled. Once the transfer has started,
         They are read-only.
        */
        alias GREEN = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         Blue Value 
         These bits defines the blue value for the A4 or A8 mode of the foreground image. They
         can only be written when data transfers are disabled. Once the transfer has started,
         They are read-only.
        */
        alias BLUE = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     DMA2D background PFC control register
    */
    final abstract class BGPFCCR : Register!(0x0024, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Alpha value 
         These bits define a fixed alpha channel value which can replace the original alpha value
         or be multiplied with the original alpha value according to the alpha mode selected with
         bits AM[1: 0]. These bits can only be written when data transfers are disabled. Once the
         transfer has started, they are read-only.
        */
        alias ALPHA = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         Alpha mode 
         These bits define which alpha channel value to be used for the background image.
         These bits can only be written when data transfers are disabled. Once the transfer has
         started, they are read-only.
         00: No modification of the foreground image alpha channel value
         01: Replace original background image alpha channel value by ALPHA[7: 0]
         10: Replace original background image alpha channel value by ALPHA[7:0] multiplied
         with original alpha channel value
         others: meaningless
        */
        alias AM = BitField!(17, 16, Mutability.rw);

        /********************************************************************************
         CLUT size 
         These bits define the size of the CLUT used for the BG. Once the CLUT transfer has
         started, this field is read-only.
         The number of CLUT entries is equal to CS[7:0] + 1.
        */
        alias CS = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         Start 
         This bit is set to start the automatic loading of the CLUT. This bit is automatically reset:
         ֠at the end of the transfer
         ֠when the transfer is aborted by the user application by setting the ABORT bit in
         the DMA2D_CR
         ֠when a transfer error occurs
         ֠when the transfer has not started due to a configuration error or another
         transfer operation already on going (data transfer or automatic BackGround
         CLUT transfer).
        */
        alias START = Bit!(5, Mutability.rc_w1);

        /********************************************************************************
         CLUT Color mode 
         These bits define the color format of the CLUT. This register can only be written when
         the transfer is disabled. Once the CLUT transfer has started, this bit is read-only.
         0: ARGB8888
         1: RGB888
         others: meaningless
        */
        alias CCM = Bit!(4, Mutability.rw);

        /********************************************************************************
         Color mode 
         These bits define the color format of the foreground image. These bits can only be
         written when data transfers are disabled. Once the transfer has started, they are readonly.
         0000: ARGB8888
         0001: RGB888
         0010: RGB565
         0011: ARGB1555
         0100: ARGB4444
         0101: L8
         0110: AL44
         0111: AL88
         1000: L4
         1001: A8
         1010: A4
         others: meaningless
        */
        alias CM = BitField!(3, 0, Mutability.rw);

    }
    /************************************************************************************
     DMA2D background color register
    */
    final abstract class BGCOLR : Register!(0x0028, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Red Value 
         These bits define the red value for the A4 or A8 mode of the background. These bits
         can only be written when data transfers are disabled. Once the transfer has started,
         they are read-only.
        */
        alias RED = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0Green Value 
         These bits define the green value for the A4 or A8 mode of the background. These bits
         can only be written when data transfers are disabled. Once the transfer has started,
         they are read-only.
        */
        alias GREEN = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         Blue Value 
         These bits define the blue value for the A4 or A8 mode of the background. These bits
         can only be written when data transfers are disabled. Once the transfer has started,
         they are read-only.
        */
        alias BLUE = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     DMA2D foreground CLUT memory address register
    */
    final abstract class FGCMAR : Register!(0x002C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0Memory Address 
         Address of the data used for the CLUT address dedicated to the foreground image. This
         register can only be written when no transfer is ongoing. Once the CLUT transfer has
         started, this register is read-only.
         If the foreground CLUT format is 32-bit, the address must be 32-bit aligned.
        */
        alias MA = BitField!(31, 0, Mutability.rw);

    }
    /************************************************************************************
     DMA2D background CLUT memory address register
    */
    final abstract class BGCMAR : Register!(0x0030, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Memory address 
         Address of the data used for the CLUT address dedicated to the background image.
         This register can only be written when no transfer is on going. Once the CLUT transfer
         has started, this register is read-only.
         If the background CLUT format is 32-bit, the address must be 32-bit aligned.
        */
        alias MA = BitField!(31, 0, Mutability.rw);

    }
    /************************************************************************************
     DMA2D output PFC control register
    */
    final abstract class OPFCCR : Register!(0x0034, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Color mode 
         These bits define the color format of the output image. These bits can only be written
         when data transfers are disabled. Once the transfer has started, they are read-only.
         000: ARGB8888
         001: RGB888
         010: RGB565
         011: ARGB1555
         100: ARGB4444
         others: meaningless
        */
        alias CM = BitField!(2, 0, Mutability.rw);

    }
    /************************************************************************************
     DMA2D output color register
    */
    final abstract class OCOLR : Register!(0x0038, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Alpha Channel Value 
         These bits define the alpha channel of the output color. These bits can only be written
         when data transfers are disabled. Once the transfer has started, they are read-only.
        */
        alias ALPHA = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         Red Value 
         These bits define the red value of the output image. These bits can only be written when
         data transfers are disabled. Once the transfer has started, they are read-only.
        */
        alias RED = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         Green Value 
         These bits define the green value of the output image. These bits can only be written
         when data transfers are disabled. Once the transfer has started, they are read-only.
        */
        alias GREEN = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         Blue Value 
         These bits define the blue value of the output image. These bits can only be written
         when data transfers are disabled. Once the transfer has started, they are read-only.
        */
        alias BLUE = BitField!(7, 0, Mutability.rw);

        /********************************************************************************
         Red Value 
         These bits define the red value of the output image. These bits can only be written when
         data transfers are disabled. Once the transfer has started, they are read-only.
        */
        alias RED565 = BitField!(15, 11, Mutability.rw);

        /********************************************************************************
         Green Value 
         These bits define the green value of the output image. These bits can only be written
         when data transfers are disabled. Once the transfer has started, they are read-only.
        */
        alias GREEN565 = BitField!(10, 5, Mutability.rw);

        /********************************************************************************
         Blue Value 
         These bits define the blue value of the output image. These bits can only be written
         when data transfers are disabled. Once the transfer has started, they are read-only.
        */
        alias BLUE565 = BitField!(4, 0, Mutability.rw);

        /********************************************************************************
         Alpha Channel Value 
         This bit define the alpha channel of the output color. This bit can only be written
         when data transfers are disabled. Once the transfer has started, they are read-only.
        */
        alias ALPHA1555 = Bit!(15, Mutability.rw);

        /********************************************************************************
         Red Value 
         These bits define the red value of the output image. These bits can only be written when
         data transfers are disabled. Once the transfer has started, they are read-only.
        */
        alias RED1555 = BitField!(14, 10, Mutability.rw);

        /********************************************************************************
         Green Value 
         These bits define the green value of the output image. These bits can only be written
         when data transfers are disabled. Once the transfer has started, they are read-only.
        */
        alias GREEN1555 = BitField!(9, 5, Mutability.rw);

        /********************************************************************************
         Blue Value 
         These bits define the blue value of the output image. These bits can only be written
         when data transfers are disabled. Once the transfer has started, they are read-only.
        */
        alias BLUE1555 = BitField!(4, 0, Mutability.rw);

        /********************************************************************************
         Alpha Channel Value 
         These bits define the alpha channel of the output color. These bits can only be written
         when data transfers are disabled. Once the transfer has started, they are read-only.
        */
        alias ALPHA4444 = BitField!(15, 12, Mutability.rw);

        /********************************************************************************
         Red Value 
         These bits define the red value of the output image. These bits can only be written when
         data transfers are disabled. Once the transfer has started, they are read-only.
        */
        alias RED4444 = BitField!(11, 8, Mutability.rw);

        /********************************************************************************
         Green Value 
         These bits define the green value of the output image. These bits can only be written
         when data transfers are disabled. Once the transfer has started, they are read-only.
        */
        alias GREEN4444 = BitField!(7, 4, Mutability.rw);

        /********************************************************************************
         Blue Value 
         These bits define the blue value of the output image. These bits can only be written
         when data transfers are disabled. Once the transfer has started, they are read-only.
        */
        alias BLUE4444 = BitField!(3, 0, Mutability.rw);

    }
    /************************************************************************************
     DMA2D output memory address register
    */
    final abstract class OMAR : Register!(0x003C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Memory Address 
         Address of the data used for the output FIFO. These bits can only be written when data
         transfers are disabled. Once the transfer has started, they are read-only.
         The address alignment must match the image format selected e.g. a 32-bit per pixel
         format must be 32-bit aligned and a 16-bit per pixel format must be 16-bit aligned.
        */
        alias MA = BitField!(31, 0, Mutability.rw);

    }
    /************************************************************************************
     DMA2D output offset register
    */
    final abstract class OOR : Register!(0x0040, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Line Offset 
         Line offset used for the output (expressed in pixels). This value is used for the address
         generation. It is added at the end of each line to determine the starting address of the
         next line. These bits can only be written when data transfers are disabled. Once the
         transfer has started, they are read-only.
        */
        alias LO = BitField!(13, 0, Mutability.rw);

    }
    /************************************************************************************
     DMA2D number of line register
    */
    final abstract class NLR : Register!(0x0044, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Pixel per lines 
         Number of pixels per lines of the area to be transferred. These bits can only be written
         when data transfers are disabled. Once the transfer has started, they are read-only.
         If any of the input image format is 4-bit per pixel, pixel per lines must be even.
        */
        alias PL = BitField!(29, 16, Mutability.rw);

        /********************************************************************************
         Number of lines 
         Number of lines of the area to be transferred. These bits can only be written when data
         transfers are disabled. Once the transfer has started, they are read-only.
        */
        alias NL = BitField!(15, 0, Mutability.rw);

    }
    /************************************************************************************
     DMA2D line watermark register
    */
    final abstract class LWR : Register!(0x0048, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Line watermark 
         These bits allow to configure the line watermark for interrupt generation.
         An interrupt is raised when the last pixel of the watermarked line has been transferred.
         These bits can only be written when data transfers are disabled. Once the transfer has
         started, they are read-only.
        */
        alias LW = BitField!(15, 0, Mutability.rw);

    }
    /************************************************************************************
     DMA2D AHB master timer configuration register
    */
    final abstract class AMTCR : Register!(0x004C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Dead Time 
         Dead time value in the AHB clock cycle inserted between two consecutive accesses on
         the AHB master port. These bits represent the minimum guaranteed number of cycles
         between two consecutive AHB accesses.
        */
        alias DT = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         Enable 
         Enables the dead time functionality.
        */
        alias EN = Bit!(0, Mutability.rw);

    }
}