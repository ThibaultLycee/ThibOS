PROGRAM_SPACE equ 0x7e00

ReadDisk:
    mov bx, PROGRAM_SPACE
    mov al, 16			; Number of sectors to read
    mov ah, 0x02		; Read from drive
    mov dl, [BOOT_DISK]		; Which drive to read from
    mov ch, 0x00
    mov dh, 0x00
    mov cl, 0x02		; Where to start reading from (sector, 1-based)
    
    int 0x13
    jc DiskReadFailed    

    ret

BOOT_DISK:
    db 0

DiskReadErrorString:
    db "Disk reading failed", 0

DiskReadFailed:
    mov bx, DiskReadErrorString
    call PrintString
    
    jmp $
