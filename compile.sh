#!/bin/sh -x

rm ThibOS.flp

cd ./src/

nasm bootloader.asm -f bin -o ../bootloader.bin
nasm ExtendedProgram.asm -f elf64 -o ../ExtendedProgram.o

x86_64-elf-gcc -ffreestanding -mno-red-zone -m64 -c Kernel.c -o ../Kernel.o
x86_64-elf-ld --oformat binary -o ../Kernel.bin -Ttext 0x7e00 ../ExtendedProgram.o ../Kernel.o

cd ../

cat bootloader.bin Kernel.bin >> ThibOS.flp

truncate -s 10k ThibOS.flp

rm bootloader.bin
rm ExtendedProgram.o
rm Kernel.bin
rm Kernel.o
