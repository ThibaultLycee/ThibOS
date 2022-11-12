#!/bin/sh -x

rm ThibOS.flp

cd ./src/

nasm bootloader.asm -f bin -o ../bootloader.bin
nasm ExtendedProgram.asm -f bin -o ../ExtendedProgram.bin

cd ../

cat bootloader.bin ExtendedProgram.bin >> ThibOS.flp

rm bootloader.bin
rm ExtendedProgram.bin

