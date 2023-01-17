[org 0x7c00]

mov [BOOT_DISK], dl

mov bp, 0x7c00
mov sp, bp

mov bx, LoadingString
call PrintString

mov bx, StartReadingDisk
call PrintString
call ReadDisk

mov bx, FinishedReadingDisk
call PrintString

jmp PROGRAM_SPACE

%include "DiskRead.asm"
%include "Print.asm"

times 510 - ($-$$) db 0
dw 0xaa55
