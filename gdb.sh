
arm-none-eabi-gdb binary/firmware -ex "target remote localhost:3333" -ex "monitor arm semihosting enable"
