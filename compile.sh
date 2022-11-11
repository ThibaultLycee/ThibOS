#!/bin/sh -x

rm ThibOS.flp

cd ./src/

nasm bootloader.asm -f bin -o ../ThibOS.flp
