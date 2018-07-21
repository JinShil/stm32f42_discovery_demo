module stm32f42.nvic;

nothrow:

import stm32f42.bus;
import stm32f42.mmio;

/****************************************************************************************
 Nested vectored interrupt controller
*/
final abstract class NVIC : Peripheral!(CorePeripherals, 0x0000E100)
{
    /************************************************************************************
     Interrupt set-enable registers
    */
    final abstract class ISER0 : Register!(0x00, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Interrupt set-enable bit 31. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA31 = Bit!(31, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 30. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA30 = Bit!(30, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 29. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA29 = Bit!(29, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 28. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA28 = Bit!(28, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 27. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA27 = Bit!(27, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 26. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA26 = Bit!(26, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 25. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA25 = Bit!(25, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 24. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA24 = Bit!(24, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 23. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA23 = Bit!(23, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 22. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA22 = Bit!(22, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 21. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA21 = Bit!(21, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 20. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA20 = Bit!(20, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 19. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA19 = Bit!(19, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 18. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA18 = Bit!(18, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 17. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA17 = Bit!(17, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 16. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA16 = Bit!(16, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 15. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA15 = Bit!(15, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 14. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA14 = Bit!(14, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 13. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA13 = Bit!(13, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 12. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA12 = Bit!(12, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 11. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA11 = Bit!(11, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 10. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA10 = Bit!(10, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 9. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA9 = Bit!(9, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 8. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA8 = Bit!(8, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 7. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA7 = Bit!(7, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 6. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA6 = Bit!(6, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 5. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA5 = Bit!(5, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 4. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA4 = Bit!(4, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 3. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA3 = Bit!(3, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 2. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA2 = Bit!(2, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 1. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA1 = Bit!(1, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 0. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA0 = Bit!(0, Mutability.rs);

    }
    /************************************************************************************
     Interrupt set-enable registers
    */
    final abstract class ISER1 : Register!(0x04, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Interrupt set-enable bit 31. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA31 = Bit!(31, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 30. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA30 = Bit!(30, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 29. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA29 = Bit!(29, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 28. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA28 = Bit!(28, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 27. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA27 = Bit!(27, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 26. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA26 = Bit!(26, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 25. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA25 = Bit!(25, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 24. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA24 = Bit!(24, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 23. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA23 = Bit!(23, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 22. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA22 = Bit!(22, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 21. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA21 = Bit!(21, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 20. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA20 = Bit!(20, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 19. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA19 = Bit!(19, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 18. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA18 = Bit!(18, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 17. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA17 = Bit!(17, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 16. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA16 = Bit!(16, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 15. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA15 = Bit!(15, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 14. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA14 = Bit!(14, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 13. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA13 = Bit!(13, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 12. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA12 = Bit!(12, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 11. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA11 = Bit!(11, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 10. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA10 = Bit!(10, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 9. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA9 = Bit!(9, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 8. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA8 = Bit!(8, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 7. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA7 = Bit!(7, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 6. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA6 = Bit!(6, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 5. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA5 = Bit!(5, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 4. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA4 = Bit!(4, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 3. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA3 = Bit!(3, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 2. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA2 = Bit!(2, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 1. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA1 = Bit!(1, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 0. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA0 = Bit!(0, Mutability.rs);

    }
    /************************************************************************************
     Interrupt set-enable registers
    */
    final abstract class ISER2 : Register!(0x08, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Interrupt set-enable bit 31. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA31 = Bit!(31, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 30. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA30 = Bit!(30, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 29. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA29 = Bit!(29, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 28. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA28 = Bit!(28, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 27. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA27 = Bit!(27, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 26. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA26 = Bit!(26, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 25. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA25 = Bit!(25, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 24. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA24 = Bit!(24, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 23. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA23 = Bit!(23, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 22. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA22 = Bit!(22, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 21. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA21 = Bit!(21, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 20. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA20 = Bit!(20, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 19. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA19 = Bit!(19, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 18. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA18 = Bit!(18, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 17. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA17 = Bit!(17, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 16. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA16 = Bit!(16, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 15. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA15 = Bit!(15, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 14. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA14 = Bit!(14, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 13. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA13 = Bit!(13, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 12. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA12 = Bit!(12, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 11. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA11 = Bit!(11, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 10. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA10 = Bit!(10, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 9. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA9 = Bit!(9, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 8. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA8 = Bit!(8, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 7. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA7 = Bit!(7, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 6. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA6 = Bit!(6, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 5. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA5 = Bit!(5, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 4. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA4 = Bit!(4, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 3. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA3 = Bit!(3, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 2. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA2 = Bit!(2, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 1. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA1 = Bit!(1, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 0. 
         Write:
         0: No effect
         1: Enable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
         If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an
         interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending,
         but the NVIC never activates the interrupt, regardless of its priority.
        */
        alias SETENA0 = Bit!(0, Mutability.rs);

    }
    /************************************************************************************
     Interrupt clear-enable registers
    */
    final abstract class ICER0 : Register!(0x180, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Interrupt set-enable bit 31. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA31 = Bit!(31, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 30. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA30 = Bit!(30, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 29. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA29 = Bit!(29, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 28. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA28 = Bit!(28, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 27. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA27 = Bit!(27, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 26. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA26 = Bit!(26, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 25. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA25 = Bit!(25, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 24. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA24 = Bit!(24, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 23. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA23 = Bit!(23, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 22. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA22 = Bit!(22, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 21. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA21 = Bit!(21, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 20. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA20 = Bit!(20, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 19. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA19 = Bit!(19, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 18. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA18 = Bit!(18, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 17. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA17 = Bit!(17, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 16. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA16 = Bit!(16, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 15. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA15 = Bit!(15, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 14. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA14 = Bit!(14, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 13. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA13 = Bit!(13, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 12. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA12 = Bit!(12, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 11. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA11 = Bit!(11, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 10. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA10 = Bit!(10, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 9. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA9 = Bit!(9, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 8. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA8 = Bit!(8, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 7. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA7 = Bit!(7, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 6. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA6 = Bit!(6, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 5. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA5 = Bit!(5, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 4. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA4 = Bit!(4, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 3. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA3 = Bit!(3, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 2. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA2 = Bit!(2, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 1. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA1 = Bit!(1, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 0. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA0 = Bit!(0, Mutability.rc_w1);

    }
    /************************************************************************************
     Interrupt clear-enable registers
    */
    final abstract class ICER1 : Register!(0x184, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Interrupt set-enable bit 31. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA31 = Bit!(31, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 30. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA30 = Bit!(30, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 29. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA29 = Bit!(29, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 28. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA28 = Bit!(28, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 27. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA27 = Bit!(27, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 26. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA26 = Bit!(26, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 25. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA25 = Bit!(25, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 24. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA24 = Bit!(24, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 23. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA23 = Bit!(23, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 22. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA22 = Bit!(22, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 21. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA21 = Bit!(21, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 20. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA20 = Bit!(20, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 19. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA19 = Bit!(19, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 18. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA18 = Bit!(18, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 17. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA17 = Bit!(17, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 16. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA16 = Bit!(16, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 15. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA15 = Bit!(15, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 14. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA14 = Bit!(14, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 13. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA13 = Bit!(13, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 12. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA12 = Bit!(12, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 11. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA11 = Bit!(11, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 10. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA10 = Bit!(10, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 9. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA9 = Bit!(9, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 8. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA8 = Bit!(8, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 7. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA7 = Bit!(7, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 6. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA6 = Bit!(6, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 5. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA5 = Bit!(5, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 4. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA4 = Bit!(4, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 3. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA3 = Bit!(3, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 2. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA2 = Bit!(2, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 1. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA1 = Bit!(1, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 0. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA0 = Bit!(0, Mutability.rc_w1);

    }
    /************************************************************************************
     Interrupt clear-enable registers
    */
    final abstract class ICER2 : Register!(0x188, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Interrupt set-enable bit 31. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA31 = Bit!(31, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 30. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA30 = Bit!(30, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 29. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA29 = Bit!(29, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 28. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA28 = Bit!(28, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 27. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA27 = Bit!(27, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 26. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA26 = Bit!(26, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 25. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA25 = Bit!(25, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 24. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA24 = Bit!(24, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 23. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA23 = Bit!(23, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 22. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA22 = Bit!(22, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 21. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA21 = Bit!(21, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 20. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA20 = Bit!(20, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 19. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA19 = Bit!(19, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 18. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA18 = Bit!(18, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 17. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA17 = Bit!(17, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 16. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA16 = Bit!(16, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 15. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA15 = Bit!(15, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 14. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA14 = Bit!(14, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 13. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA13 = Bit!(13, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 12. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA12 = Bit!(12, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 11. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA11 = Bit!(11, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 10. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA10 = Bit!(10, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 9. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA9 = Bit!(9, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 8. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA8 = Bit!(8, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 7. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA7 = Bit!(7, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 6. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA6 = Bit!(6, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 5. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA5 = Bit!(5, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 4. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA4 = Bit!(4, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 3. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA3 = Bit!(3, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 2. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA2 = Bit!(2, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 1. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA1 = Bit!(1, Mutability.rc_w1);

        /********************************************************************************
         Interrupt set-enable bit 0. 
         Write:
         0: No effect
         1: Disable interrupt
         Read:
         0: Interrupt disabled
         1: Interrupt enabled.
        */
        alias CLRENA0 = Bit!(0, Mutability.rc_w1);

    }
    /************************************************************************************
     Interrupt set-pending register
    */
    final abstract class ISPR0 : Register!(0x200, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Interrupt set-enable bit 31. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND31 = Bit!(31, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 30. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND30 = Bit!(30, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 29. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND29 = Bit!(29, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 28. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND28 = Bit!(28, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 27. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND27 = Bit!(27, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 26. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND26 = Bit!(26, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 25. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND25 = Bit!(25, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 24. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND24 = Bit!(24, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 23. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND23 = Bit!(23, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 22. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND22 = Bit!(22, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 21. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND21 = Bit!(21, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 20. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND20 = Bit!(20, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 19. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND19 = Bit!(19, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 18. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND18 = Bit!(18, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 17. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND17 = Bit!(17, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 16. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND16 = Bit!(16, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 15. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND15 = Bit!(15, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 14. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND14 = Bit!(14, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 13. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND13 = Bit!(13, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 12. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND12 = Bit!(12, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 11. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND11 = Bit!(11, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 10. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND10 = Bit!(10, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 9. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND9 = Bit!(9, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 8. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND8 = Bit!(8, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 7. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND7 = Bit!(7, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 6. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND6 = Bit!(6, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 5. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND5 = Bit!(5, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 4. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND4 = Bit!(4, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 3. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND3 = Bit!(3, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 2. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND2 = Bit!(2, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 1. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND1 = Bit!(1, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 0. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND0 = Bit!(0, Mutability.rs);

    }
    /************************************************************************************
     Interrupt set-pending register
    */
    final abstract class ISPR1 : Register!(0x204, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Interrupt set-enable bit 31. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND31 = Bit!(31, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 30. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND30 = Bit!(30, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 29. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND29 = Bit!(29, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 28. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND28 = Bit!(28, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 27. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND27 = Bit!(27, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 26. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND26 = Bit!(26, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 25. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND25 = Bit!(25, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 24. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND24 = Bit!(24, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 23. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND23 = Bit!(23, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 22. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND22 = Bit!(22, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 21. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND21 = Bit!(21, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 20. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND20 = Bit!(20, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 19. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND19 = Bit!(19, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 18. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND18 = Bit!(18, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 17. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND17 = Bit!(17, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 16. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND16 = Bit!(16, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 15. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND15 = Bit!(15, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 14. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND14 = Bit!(14, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 13. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND13 = Bit!(13, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 12. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND12 = Bit!(12, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 11. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND11 = Bit!(11, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 10. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND10 = Bit!(10, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 9. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND9 = Bit!(9, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 8. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND8 = Bit!(8, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 7. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND7 = Bit!(7, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 6. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND6 = Bit!(6, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 5. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND5 = Bit!(5, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 4. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND4 = Bit!(4, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 3. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND3 = Bit!(3, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 2. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND2 = Bit!(2, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 1. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND1 = Bit!(1, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 0. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND0 = Bit!(0, Mutability.rs);

    }
    /************************************************************************************
     Interrupt set-pending register
    */
    final abstract class ISPR2 : Register!(0x208, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Interrupt set-enable bit 31. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND31 = Bit!(31, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 30. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND30 = Bit!(30, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 29. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND29 = Bit!(29, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 28. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND28 = Bit!(28, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 27. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND27 = Bit!(27, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 26. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND26 = Bit!(26, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 25. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND25 = Bit!(25, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 24. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND24 = Bit!(24, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 23. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND23 = Bit!(23, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 22. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND22 = Bit!(22, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 21. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND21 = Bit!(21, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 20. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND20 = Bit!(20, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 19. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND19 = Bit!(19, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 18. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND18 = Bit!(18, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 17. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND17 = Bit!(17, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 16. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND16 = Bit!(16, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 15. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND15 = Bit!(15, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 14. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND14 = Bit!(14, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 13. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND13 = Bit!(13, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 12. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND12 = Bit!(12, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 11. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND11 = Bit!(11, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 10. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND10 = Bit!(10, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 9. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND9 = Bit!(9, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 8. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND8 = Bit!(8, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 7. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND7 = Bit!(7, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 6. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND6 = Bit!(6, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 5. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND5 = Bit!(5, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 4. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND4 = Bit!(4, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 3. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND3 = Bit!(3, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 2. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND2 = Bit!(2, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 1. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND1 = Bit!(1, Mutability.rs);

        /********************************************************************************
         Interrupt set-enable bit 0. 
         Write:
         0: No effect
         1: Changes interrupt state to pending
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias SETPEND0 = Bit!(0, Mutability.rs);

    }
    /************************************************************************************
     Interrupt clear-pending register
    */
    final abstract class ICPR0 : Register!(0x280, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Interrupt clear-pending bits 31. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND31 = Bit!(31, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 30. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND30 = Bit!(30, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 29. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND29 = Bit!(29, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 28. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND28 = Bit!(28, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 27. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND27 = Bit!(27, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 26. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND26 = Bit!(26, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 25. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND25 = Bit!(25, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 24. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND24 = Bit!(24, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 23. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND23 = Bit!(23, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 22. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND22 = Bit!(22, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 21. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND21 = Bit!(21, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 20. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND20 = Bit!(20, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 19. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND19 = Bit!(19, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 18. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND18 = Bit!(18, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 17. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND17 = Bit!(17, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 16. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND16 = Bit!(16, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 15. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND15 = Bit!(15, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 14. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND14 = Bit!(14, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 13. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND13 = Bit!(13, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 12. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND12 = Bit!(12, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 11. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND11 = Bit!(11, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 10. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND10 = Bit!(10, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 9. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND9 = Bit!(9, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 8. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND8 = Bit!(8, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 7. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND7 = Bit!(7, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 6. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND6 = Bit!(6, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 5. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND5 = Bit!(5, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 4. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND4 = Bit!(4, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 3. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND3 = Bit!(3, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 2. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND2 = Bit!(2, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 1. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND1 = Bit!(1, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 0. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND0 = Bit!(0, Mutability.rc_w1);

    }
    /************************************************************************************
     Interrupt clear-pending register
    */
    final abstract class ICPR1 : Register!(0x284, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Interrupt clear-pending bits 31. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND31 = Bit!(31, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 30. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND30 = Bit!(30, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 29. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND29 = Bit!(29, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 28. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND28 = Bit!(28, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 27. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND27 = Bit!(27, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 26. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND26 = Bit!(26, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 25. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND25 = Bit!(25, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 24. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND24 = Bit!(24, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 23. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND23 = Bit!(23, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 22. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND22 = Bit!(22, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 21. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND21 = Bit!(21, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 20. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND20 = Bit!(20, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 19. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND19 = Bit!(19, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 18. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND18 = Bit!(18, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 17. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND17 = Bit!(17, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 16. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND16 = Bit!(16, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 15. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND15 = Bit!(15, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 14. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND14 = Bit!(14, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 13. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND13 = Bit!(13, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 12. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND12 = Bit!(12, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 11. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND11 = Bit!(11, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 10. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND10 = Bit!(10, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 9. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND9 = Bit!(9, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 8. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND8 = Bit!(8, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 7. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND7 = Bit!(7, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 6. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND6 = Bit!(6, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 5. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND5 = Bit!(5, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 4. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND4 = Bit!(4, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 3. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND3 = Bit!(3, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 2. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND2 = Bit!(2, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 1. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND1 = Bit!(1, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 0. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND0 = Bit!(0, Mutability.rc_w1);

    }
    /************************************************************************************
     Interrupt clear-pending register
    */
    final abstract class ICPR2 : Register!(0x288, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Interrupt clear-pending bits 31. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND31 = Bit!(31, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 30. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND30 = Bit!(30, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 29. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND29 = Bit!(29, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 28. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND28 = Bit!(28, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 27. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND27 = Bit!(27, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 26. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND26 = Bit!(26, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 25. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND25 = Bit!(25, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 24. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND24 = Bit!(24, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 23. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND23 = Bit!(23, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 22. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND22 = Bit!(22, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 21. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND21 = Bit!(21, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 20. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND20 = Bit!(20, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 19. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND19 = Bit!(19, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 18. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND18 = Bit!(18, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 17. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND17 = Bit!(17, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 16. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND16 = Bit!(16, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 15. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND15 = Bit!(15, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 14. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND14 = Bit!(14, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 13. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND13 = Bit!(13, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 12. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND12 = Bit!(12, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 11. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND11 = Bit!(11, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 10. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND10 = Bit!(10, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 9. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND9 = Bit!(9, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 8. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND8 = Bit!(8, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 7. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND7 = Bit!(7, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 6. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND6 = Bit!(6, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 5. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND5 = Bit!(5, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 4. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND4 = Bit!(4, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 3. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND3 = Bit!(3, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 2. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND2 = Bit!(2, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 1. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND1 = Bit!(1, Mutability.rc_w1);

        /********************************************************************************
         Interrupt clear-pending bits 0. 
         Write:
         0: No effect
         1: Removes the pending state of an interrupt
         Read:
         0: Interrupt is not pending
         1: Interrupt is pending.
        */
        alias CLRPEND0 = Bit!(0, Mutability.rc_w1);

    }
    
    /************************************************************************************
     Interrupt active bit registers
    */
    final abstract class IABR1 : Register!(0x304, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Interrupt active flag 31. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE31 = Bit!(31, Mutability.r);

        /********************************************************************************
         Interrupt active flag 30. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE30 = Bit!(30, Mutability.r);

        /********************************************************************************
         Interrupt active flag 29. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE29 = Bit!(29, Mutability.r);

        /********************************************************************************
         Interrupt active flag 28. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE28 = Bit!(28, Mutability.r);

        /********************************************************************************
         Interrupt active flag 27. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE27 = Bit!(27, Mutability.r);

        /********************************************************************************
         Interrupt active flag 26. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE26 = Bit!(26, Mutability.r);

        /********************************************************************************
         Interrupt active flag 25. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE25 = Bit!(25, Mutability.r);

        /********************************************************************************
         Interrupt active flag 24. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE24 = Bit!(24, Mutability.r);

        /********************************************************************************
         Interrupt active flag 23. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE23 = Bit!(23, Mutability.r);

        /********************************************************************************
         Interrupt active flag 22. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE22 = Bit!(22, Mutability.r);

        /********************************************************************************
         Interrupt active flag 21. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE21 = Bit!(21, Mutability.r);

        /********************************************************************************
         Interrupt active flag 20. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE20 = Bit!(20, Mutability.r);

        /********************************************************************************
         Interrupt active flag 19. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE19 = Bit!(19, Mutability.r);

        /********************************************************************************
         Interrupt active flag 18. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE18 = Bit!(18, Mutability.r);

        /********************************************************************************
         Interrupt active flag 17. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE17 = Bit!(17, Mutability.r);

        /********************************************************************************
         Interrupt active flag 16. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE16 = Bit!(16, Mutability.r);

        /********************************************************************************
         Interrupt active flag 15. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE15 = Bit!(15, Mutability.r);

        /********************************************************************************
         Interrupt active flag 14. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE14 = Bit!(14, Mutability.r);

        /********************************************************************************
         Interrupt active flag 13. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE13 = Bit!(13, Mutability.r);

        /********************************************************************************
         Interrupt active flag 12. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE12 = Bit!(12, Mutability.r);

        /********************************************************************************
         Interrupt active flag 11. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE11 = Bit!(11, Mutability.r);

        /********************************************************************************
         Interrupt active flag 10. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE10 = Bit!(10, Mutability.r);

        /********************************************************************************
         Interrupt active flag 9. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE9 = Bit!(9, Mutability.r);

        /********************************************************************************
         Interrupt active flag 8. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE8 = Bit!(8, Mutability.r);

        /********************************************************************************
         Interrupt active flag 7. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE7 = Bit!(7, Mutability.r);

        /********************************************************************************
         Interrupt active flag 6. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE6 = Bit!(6, Mutability.r);

        /********************************************************************************
         Interrupt active flag 5. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE5 = Bit!(5, Mutability.r);

        /********************************************************************************
         Interrupt active flag 4. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE4 = Bit!(4, Mutability.r);

        /********************************************************************************
         Interrupt active flag 3. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE3 = Bit!(3, Mutability.r);

        /********************************************************************************
         Interrupt active flag 2. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE2 = Bit!(2, Mutability.r);

        /********************************************************************************
         Interrupt active flag 1. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE1 = Bit!(1, Mutability.r);

        /********************************************************************************
         Interrupt active flag 0. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE0 = Bit!(0, Mutability.r);

    }
    /************************************************************************************
     Interrupt active bit registers
    */
    final abstract class IABR2 : Register!(0x308, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Interrupt active flag 31. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE31 = Bit!(31, Mutability.r);

        /********************************************************************************
         Interrupt active flag 30. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE30 = Bit!(30, Mutability.r);

        /********************************************************************************
         Interrupt active flag 29. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE29 = Bit!(29, Mutability.r);

        /********************************************************************************
         Interrupt active flag 28. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE28 = Bit!(28, Mutability.r);

        /********************************************************************************
         Interrupt active flag 27. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE27 = Bit!(27, Mutability.r);

        /********************************************************************************
         Interrupt active flag 26. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE26 = Bit!(26, Mutability.r);

        /********************************************************************************
         Interrupt active flag 25. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE25 = Bit!(25, Mutability.r);

        /********************************************************************************
         Interrupt active flag 24. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE24 = Bit!(24, Mutability.r);

        /********************************************************************************
         Interrupt active flag 23. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE23 = Bit!(23, Mutability.r);

        /********************************************************************************
         Interrupt active flag 22. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE22 = Bit!(22, Mutability.r);

        /********************************************************************************
         Interrupt active flag 21. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE21 = Bit!(21, Mutability.r);

        /********************************************************************************
         Interrupt active flag 20. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE20 = Bit!(20, Mutability.r);

        /********************************************************************************
         Interrupt active flag 19. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE19 = Bit!(19, Mutability.r);

        /********************************************************************************
         Interrupt active flag 18. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE18 = Bit!(18, Mutability.r);

        /********************************************************************************
         Interrupt active flag 17. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE17 = Bit!(17, Mutability.r);

        /********************************************************************************
         Interrupt active flag 16. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE16 = Bit!(16, Mutability.r);

        /********************************************************************************
         Interrupt active flag 15. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE15 = Bit!(15, Mutability.r);

        /********************************************************************************
         Interrupt active flag 14. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE14 = Bit!(14, Mutability.r);

        /********************************************************************************
         Interrupt active flag 13. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE13 = Bit!(13, Mutability.r);

        /********************************************************************************
         Interrupt active flag 12. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE12 = Bit!(12, Mutability.r);

        /********************************************************************************
         Interrupt active flag 11. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE11 = Bit!(11, Mutability.r);

        /********************************************************************************
         Interrupt active flag 10. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE10 = Bit!(10, Mutability.r);

        /********************************************************************************
         Interrupt active flag 9. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE9 = Bit!(9, Mutability.r);

        /********************************************************************************
         Interrupt active flag 8. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE8 = Bit!(8, Mutability.r);

        /********************************************************************************
         Interrupt active flag 7. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE7 = Bit!(7, Mutability.r);

        /********************************************************************************
         Interrupt active flag 6. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE6 = Bit!(6, Mutability.r);

        /********************************************************************************
         Interrupt active flag 5. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE5 = Bit!(5, Mutability.r);

        /********************************************************************************
         Interrupt active flag 4. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE4 = Bit!(4, Mutability.r);

        /********************************************************************************
         Interrupt active flag 3. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE3 = Bit!(3, Mutability.r);

        /********************************************************************************
         Interrupt active flag 2. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE2 = Bit!(2, Mutability.r);

        /********************************************************************************
         Interrupt active flag 1. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE1 = Bit!(1, Mutability.r);

        /********************************************************************************
         Interrupt active flag 0. 
         0: Interrupt not active
         1: Interrupt active
         A bit reads as 1 if the status of the corresponding interrupt is active or active and pending.
        */
        alias ACTIVE0 = Bit!(0, Mutability.r);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR0 : Register!(0x400, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR1 : Register!(0x404, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR2 : Register!(0x408, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR3 : Register!(0x40C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR4 : Register!(0x410, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR5 : Register!(0x414, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR6 : Register!(0x418, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR7 : Register!(0x41C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR8 : Register!(0x420, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR9 : Register!(0x424, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR10 : Register!(0x428, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR11 : Register!(0x42C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR12 : Register!(0x430, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR13 : Register!(0x434, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR14 : Register!(0x438, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR15 : Register!(0x43C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR16 : Register!(0x440, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR17 : Register!(0x444, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR18 : Register!(0x448, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR19 : Register!(0x44C, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    /************************************************************************************
     Interrupt priority registers
    */
    final abstract class IPR20 : Register!(0x450, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP3 = BitField!(31, 24, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP2 = BitField!(23, 16, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP1 = BitField!(15, 8, Mutability.rw);

        /********************************************************************************
         0-255. The lower the value,
             the greater the priority of the corresponding interrupt. The processor
             implements only bits[7:4] of each field, bits[3:0] read as zero and
             ignore writes.
        */
        alias IP0 = BitField!(7, 0, Mutability.rw);

    }
    
    /************************************************************************************
     Software trigger interrupt register
     Required privilege: When the USERSETMPEND bit in the SCR is set to 1, unprivileged
     software can access the STIR, see Section 4.4.6: System control register (SCR). Only
     privileged software can enable unprivileged access to the STIR.
    */
    final abstract class STIR : Register!(0xEF00, Access.Byte_HalfWord_Word)
    {
        /********************************************************************************
         Software generated interrupt ID 
         Write to the STIR to generate a Software Generated Interrupt (SGI). The value to be written is
         the Interrupt ID of the required SGI, in the range 0-239. For example, a value of 0x03 specifies
         interrupt IRQ3.
        */
        alias INTID = BitField!(8, 0, Mutability.w);

    }
}
