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

module stm32f42.spi;

nothrow:
@safe:

import stm32f42.bus;
import stm32f42.mmio;

alias SPI1 = PeripheralTemplate!(APB2, 0x3000);
alias SPI2 = PeripheralTemplate!(APB1, 0x3800);
alias SPI3 = PeripheralTemplate!(APB1, 0x3C00);
alias SPI4 = PeripheralTemplate!(APB2, 0x3400);
alias SPI5 = PeripheralTemplate!(APB2, 0x5000);
alias SPI6 = PeripheralTemplate!(APB2, 0x5400);

/****************************************************************************************
 Serial peripheral interface (SPI)
*/
private final abstract class PeripheralTemplate(TBus, uint addressOffset) : Peripheral!(TBus, addressOffset)
{
    /************************************************************************************
     SPI control register 1
    */
    final abstract class CR1 : Register!(0x00, Access.HalfWord_Word)
    {
        /********************************************************************************
         Bidirectional data mode enable 
         0: 2-line unidirectional data mode selected
         1: 1-line bidirectional data mode selected
         Note: This bit is not used in I2S mode
        */
        alias BIDIMODE = Bit!(15, Mutability.rw);

        /********************************************************************************
         Output enable in bidirectional mode 
         This bit combined with the BIDImode bit selects the direction of transfer in bidirectional mode
         0: Output disabled (receive-only mode)
         1: Output enabled (transmit-only mode)
         Note: This bit is not used in I2S mode.
         In master mode, the MOSI pin is used while the MISO pin is used in slave mode.
        */
        alias BIDIOE = Bit!(14, Mutability.rw);

        /********************************************************************************
         Hardware CRC calculation enable 
         0: CRC calculation disabled
         1: CRC calculation enabled
         Note: This bit should be written only when SPI is disabled (SPE = ‘0’) for correct operation.
         It is not used in I2S mode.
        */
        alias CRCEN = Bit!(13, Mutability.rw);

        /********************************************************************************
         CRC transfer next 
         0: Data phase (no CRC phase)
         1: Next transfer is CRC (CRC phase)
         Note: When the SPI is configured in full duplex or transmitter only modes, CRCNEXT must be
         written as soon as the last data is written to the SPI_DR register.
         When the SPI is configured in receiver only mode, CRCNEXT must be set after the
         second last data reception.
         This bit should be kept cleared when the transfers are managed by DMA.
         It is not used in I2S mode.
        */
        alias CRCNEXT = Bit!(12, Mutability.rw);

        /********************************************************************************
         Data frame format 
         0: 8-bit data frame format is selected for transmission/reception
         1: 16-bit data frame format is selected for transmission/reception
         Note: This bit should be written only when SPI is disabled (SPE = ‘0’) for correct operation.
         It is not used in I2S mode.
        */
        alias DFF = Bit!(11, Mutability.rw);

        /********************************************************************************
         Receive only 
         This bit combined with the BIDImode bit selects the direction of transfer in 2-line
         unidirectional mode. This bit is also useful in a multislave system in which this particular
         slave is not accessed, the output from the accessed slave is not corrupted.
         0: Full duplex (Transmit and receive)
         1: Output disabled (Receive-only mode)
         Note: This bit is not used in I2S mode
        */
        alias RXONLY = Bit!(10, Mutability.rw);

        /********************************************************************************
         Software slave management 
         When the SSM bit is set, the NSS pin input is replaced with the value from the SSI bit.
         0: Software slave management disabled
         1: Software slave management enabled
         Note: This bit is not used in I2S mode and SPI TI mode
        */
        alias SSM = Bit!(9, Mutability.rw);

        /********************************************************************************
         Internal slave select 
         This bit has an effect only when the SSM bit is set. The value of this bit is forced onto the
         NSS pin and the IO value of the NSS pin is ignored.
         Note: This bit is not used in I2S mode and SPI TI mode
        */
        alias SSI = Bit!(8, Mutability.rw);

        /********************************************************************************
         Frame format 
         0: MSB transmitted first
         1: LSB transmitted first
         Note: This bit should not be changed when communication is ongoing.
         It is not used in I2S mode and SPI TI mode
        */
        alias LSBFIRST = Bit!(7, Mutability.rw);

        /********************************************************************************
         SPI enable 
         0: Peripheral disabled
         1: Peripheral enabled
         Note: This bit is not used in I2S mode.
         When disabling the SPI, follow the procedure described in Section 28.3.8: Disabling the
         SPI.
        */
        alias SPE = Bit!(6, Mutability.rw);

        /********************************************************************************
         Baud rate control 
         000: fPCLK/2
         001: fPCLK/4
         010: fPCLK/8
         011: fPCLK/16
         100: fPCLK/32
         101: fPCLK/64
         110: fPCLK/128
         111: fPCLK/256
         Note: These bits should not be changed when communication is ongoing.
         They are not used in I2S mode.
        */
        alias BR = BitField!(5, 3, Mutability.rw);

        /********************************************************************************
         Master selection 
         0: Slave configuration
         1: Master configuration
         Note: This bit should not be changed when communication is ongoing.
         It is not used in I2S mode.
        */
        alias MSTR = Bit!(2, Mutability.rw);

        /********************************************************************************
         Clock polarity 
         0: CK to 0 when idle
         1: CK to 1 when idle
         Note: This bit should not be changed when communication is ongoing.
         It is not used in I2S mode and SPI TI mode.
        */
        alias CPOL = Bit!(1, Mutability.rw);

        /********************************************************************************
         Clock phase 
         0: The first clock transition is the first data capture edge
         1: The second clock transition is the first data capture edge
         Note: This bit should not be changed when communication is ongoing.
         It is not used in I2S mode and SPI TI mode.
        */
        alias CPHA = Bit!(0, Mutability.rw);

    }
    
    /************************************************************************************
     SPI control register 2
    */
    final abstract class CR2 : Register!(0x04, Access.HalfWord_Word)
    {
        /********************************************************************************
         Tx buffer empty interrupt enable 
         0: TXE interrupt masked
         1: TXE interrupt not masked. Used to generate an interrupt request when the TXE flag is set.
        */
        alias TXEIE = Bit!(7, Mutability.rw);

        /********************************************************************************
         RX buffer not empty interrupt enable 
         0: RXNE interrupt masked
         1: RXNE interrupt not masked. Used to generate an interrupt request when the RXNE flag is
         set.
        */
        alias RXNEIE = Bit!(6, Mutability.rw);

        /********************************************************************************
         Error interrupt enable 
         This bit controls the generation of an interrupt when an error condition occurs )(CRCERR,
         OVR, MODF in SPI mode, FRE in TI mode and UDR, OVR, and FRE in I2S mode).
         0: Error interrupt is masked
         1: Error interrupt is enabled
        */
        alias ERRIE = Bit!(5, Mutability.rw);

        /********************************************************************************
         Frame format 
         0: SPI Motorola mode
         1 SPI TI mode
         Note: This bit is not used in I2S mode.
        */
        alias FRF = Bit!(4, Mutability.rw);

        /********************************************************************************
         SS output enable 
         0: SS output is disabled in master mode and the cell can work in multimaster configuration
         1: SS output is enabled in master mode and when the cell is enabled. The cell cannot work
         in a multimaster environment.
         Note: This bit is not used in I2S mode and SPI TI mode.
        */
        alias SSOE = Bit!(2, Mutability.rw);

        /********************************************************************************
         Tx buffer DMA enable 
         When this bit is set, the DMA request is made whenever the TXE flag is set.
         0: Tx buffer DMA disabled
         1: Tx buffer DMA enabled
        */
        alias TXDMAEN = Bit!(1, Mutability.rw);

        /********************************************************************************
         Rx buffer DMA enable 
         When this bit is set, the DMA request is made whenever the RXNE flag is set.
         0: Rx buffer DMA disabled
         1: Rx buffer DMA enabled
        */
        alias RXDMAEN = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     SPI status register
    */
    final abstract class SR : Register!(0x08, Access.HalfWord_Word)
    {
        /********************************************************************************
         Frame format error 
         0: No frame format error
         1: A frame format error occurred
         This flag is set by hardware and cleared by software when the SPIx_SR register is read.
         Note: This flag is used when the SPI operates in TI slave mode or I2S slave mode (refer to
         Section 28.3.10).
        */
        alias FRE = Bit!(8, Mutability.r);

        /********************************************************************************
         Busy flag 
         0: SPI (or I2S) not busy
         1: SPI (or I2S) is busy in communication or Tx buffer is not empty
         This flag is set and cleared by hardware.
         Note: BSY flag must be used with caution: refer to Section 28.3.7: Status flags and
         Section 28.3.8: Disabling the SPI.
        */
        alias BSY = Bit!(7, Mutability.r);

        /********************************************************************************
         Overrun flag 
         0: No overrun occurred
         1: Overrun occurred
         This flag is set by hardware and reset by a software sequence. Refer to Section 28.4.8 on
         page 902 for the software sequence.
        */
        alias OVR = Bit!(6, Mutability.r);

        /********************************************************************************
         Mode fault 
         0: No mode fault occurred
         1: Mode fault occurred
         This flag is set by hardware and reset by a software sequence. Refer to Section 28.3.10 on
         page 884 for the software sequence.
         Note: This bit is not used in I2S mode
        */
        alias MODF = Bit!(5, Mutability.r);

        /********************************************************************************
         CRC error flag 
         0: CRC value received matches the SPI_RXCRCR value
         1: CRC value received does not match the SPI_RXCRCR value
         This flag is set by hardware and cleared by software writing 0.
         Note: This bit is not used in I2S mode.
        */
        alias CRCERR = Bit!(4, Mutability.rc_w0);

        /********************************************************************************
         Underrun flag 
         0: No underrun occurred
         1: Underrun occurred
         This flag is set by hardware and reset by a software sequence. Refer to Section 28.4.8 on
         page 902 for the software sequence.
         Note: This bit is not used in SPI mode.
        */
        alias UDR = Bit!(3, Mutability.r);

        /********************************************************************************
         Channel side 
         0: Channel Left has to be transmitted or has been received
         1: Channel Right has to be transmitted or has been received
         Note: This bit is not used for SPI mode and is meaningless in PCM mode.
        */
        alias CHSIDE = Bit!(2, Mutability.r);

        /********************************************************************************
         Transmit buffer empty 
         0: Tx buffer not empty
         1: Tx buffer empty
        */
        alias TXE = Bit!(1, Mutability.r);

        /********************************************************************************
         Receive buffer not empty 
         0: Rx buffer empty
         1: Rx buffer not empty
        */
        alias RXNE = Bit!(0, Mutability.r);

    }
    /************************************************************************************
     SPI data register
    */
    final abstract class DR : Register!(0x0C, Access.HalfWord_Word)
    {
        /********************************************************************************
         Data register 
         Data received or to be transmitted.
         The data register is split into 2 buffers - one for writing (Transmit Buffer) and another one for
         reading (Receive buffer). A write to the data register will write into the Tx buffer and a read
         from the data register will return the value held in the Rx buffer.
         Note: These notes apply to SPI mode:
         Depending on the data frame format selection bit (DFF in SPI_CR1 register), the data
         sent or received is either 8-bit or 16-bit. This selection has to be made before enabling
         the SPI to ensure correct operation.
         For an 8-bit data frame, the buffers are 8-bit and only the LSB of the register
         (SPI_DR[7:0]) is used for transmission/reception. When in reception mode, the MSB of
         the register (SPI_DR[15:8]) is forced to 0.
         For a 16-bit data frame, the buffers are 16-bit and the entire register, SPI_DR[15:0] is
         used for transmission/reception.
        */
        alias DR = BitField!(15, 0, Mutability.rw);

    }
    /************************************************************************************
     SPI CRC polynomial register
    */
    final abstract class CRCPR : Register!(0x10, Access.HalfWord_Word)
    {
        /********************************************************************************
         CRC polynomial register 
         This register contains the polynomial for the CRC calculation.
         The CRC polynomial (0007h) is the reset value of this register. Another polynomial can be
         configured as required.
         Note: These bits are not used for the I2S mode.
        */
        alias CRCPOLY = BitField!(15, 0, Mutability.rw);

    }
    /************************************************************************************
     SPI RX CRC register
    */
    final abstract class RXCRCR : Register!(0x14, Access.HalfWord_Word)
    {
        /********************************************************************************
         Rx CRC register 
         When CRC calculation is enabled, the RxCRC[15:0] bits contain the computed CRC value of
         the subsequently received bytes. This register is reset when the CRCEN bit in SPI_CR1
         register is written to 1. The CRC is calculated serially using the polynomial programmed in
         the SPI_CRCPR register.
         Only the 8 LSB bits are considered when the data frame format is set to be 8-bit data (DFF
         bit of SPI_CR1 is cleared). CRC calculation is done based on any CRC8 standard.
         The entire 16-bits of this register are considered when a 16-bit data frame format is selected
         (DFF bit of the SPI_CR1 register is set). CRC calculation is done based on any CRC16
         standard.
         Note: A read to this register when the BSY Flag is set could return an incorrect value.
         These bits are not used for I2S mode.
        */
        alias RXCRC = BitField!(15, 0, Mutability.r);

    }
    /************************************************************************************
     SPI TX CRC register
    */
    final abstract class TXCRCR : Register!(0x18, Access.HalfWord_Word)
    {
        /********************************************************************************
         Tx CRC register 
         When CRC calculation is enabled, the TxCRC[7:0] bits contain the computed CRC value of
         the subsequently transmitted bytes. This register is reset when the CRCEN bit of SPI_CR1
         is written to 1. The CRC is calculated serially using the polynomial programmed in the
         SPI_CRCPR register.
         Only the 8 LSB bits are considered when the data frame format is set to be 8-bit data (DFF
         bit of SPI_CR1 is cleared). CRC calculation is done based on any CRC8 standard.
         The entire 16-bits of this register are considered when a 16-bit data frame format is selected
         (DFF bit of the SPI_CR1 register is set). CRC calculation is done based on any CRC16
         standard.
         Note: A read to this register when the BSY flag is set could return an incorrect value.
         These bits are not used for I2S mode.
        */
        alias TXCRC = BitField!(15, 0, Mutability.r);

    }
    /************************************************************************************
     SPI_I2S configuration register
    */
    final abstract class I2SCFGR : Register!(0x1C, Access.HalfWord_Word)
    {
        /********************************************************************************
         I2S mode selection 
         0: SPI mode is selected
         1: I2S mode is selected
         Note: This bit should be configured when the SPI or I2S is disabled
        */
        alias I2SMOD = Bit!(11, Mutability.rw);

        /********************************************************************************
         I2S Enable 
         0: I2S peripheral is disabled
         1: I2S peripheral is enabled
         Note: This bit is not used in SPI mode.
        */
        alias I2SE = Bit!(10, Mutability.rw);

        /********************************************************************************
         I2S configuration mode 
         00: Slave - transmit
         01: Slave - receive
         10: Master - transmit
         11: Master - receive
         Note: This bit should be configured when the I2S is disabled.
         It is not used in SPI mode.
        */
        alias I2SCFG = BitField!(9, 8, Mutability.rw);

        /********************************************************************************
         PCM frame synchronization 
         0: Short frame synchronization
         1: Long frame synchronization
         Note: This bit has a meaning only if I2SSTD = 11 (PCM standard is used)
         It is not used in SPI mode.
        */
        alias PCMSYNC = Bit!(7, Mutability.rw);

        /********************************************************************************
         I2S standard selection 
         00: I2S Philips standard.
         01: MSB justified standard (left justified)
         10: LSB justified standard (right justified)
         11: PCM standard
         For more details on I2S standards, refer to Section 28.4.3 on page 888. Not used in SPI mode.
         Note: For correct operation, these bits should be configured when the I2S is disabled.
        */
        alias I2SSTD = BitField!(5, 4, Mutability.rw);

        /********************************************************************************
         Steady state clock polarity 
         0: I2S clock steady state is low level
         1: I2S clock steady state is high level
         Note: For correct operation, this bit should be configured when the I2S is disabled.
         This bit is not used in SPI mode
        */
        alias CKPOL = Bit!(3, Mutability.rw);

        /********************************************************************************
         Data length to be transferred 
         00: 16-bit data length
         01: 24-bit data length
         10: 32-bit data length
         11: Not allowed
         Note: For correct operation, these bits should be configured when the I2S is disabled.
         This bit is not used in SPI mode.
        */
        alias DATLEN = BitField!(2, 1, Mutability.rw);

        /********************************************************************************
         Channel length (number of bits per audio channel) 
         0: 16-bit wide
         1: 32-bit wide
         The bit write operation has a meaning only if DATLEN = 00 otherwise the channel length is fixed to
         32-bit by hardware whatever the value filled in. Not used in SPI mode.
         Note: For correct operation, this bit should be configured when the I2S is disabled.
        */
        alias CHLEN = Bit!(0, Mutability.rw);

    }
    /************************************************************************************
     SPI_I2S prescaler register
    */
    final abstract class I2SPR : Register!(0x20, Access.HalfWord_Word)
    {
        /********************************************************************************
         Master clock output enable 
         0: Master clock output is disabled
         1: Master clock output is enabled
         Note: This bit should be configured when the I2S is disabled. It is used only when the I2S is in master
         mode.
         This bit is not used in SPI mode.
        */
        alias MCKOE = Bit!(9, Mutability.rw);

        /********************************************************************************
         Odd factor for the prescaler 
         0: real divider value is = I2SDIV *2
         1: real divider value is = (I2SDIV * 2)+1
         Refer to Section 28.4.4 on page 895. Not used in SPI mode.
         Note: This bit should be configured when the I2S is disabled. It is used only when the I2S is in master
         mode.
        */
        alias ODD = Bit!(8, Mutability.rw);

        /********************************************************************************
         I2S Linear prescaler 
         I2SDIV [7:0] = 0 or I2SDIV [7:0] = 1 are forbidden values.
         Refer to Section 28.4.4 on page 895. Not used in SPI mode.
         Note: These bits should be configured when the I2S is disabled. It is used only when the I2S is in
         master mode.
        */
        alias I2SDIV = BitField!(7, 0, Mutability.rw);

    }
}