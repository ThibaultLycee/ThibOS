jmp EnterProtectedMode

%include "Gdt.asm"

EnterProtectedMode:
    call EnableA20
    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp codeseg:StartProtectedMode

EnableA20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

[bits 32]

%include "CpuID.asm"
%include "SimplePaging.asm"

StartProtectedMode:
    mov ax, dataseg
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov ds, ax
    
    mov [0xb8000], byte 'H'
    mov [0xb8002], byte 'e'
    mov [0xb8004], byte 'l'
    mov [0xb8006], byte 'l'
    mov [0xb8008], byte 'o'
    mov [0xb800a], byte ' '
    mov [0xb800c], byte 'W'
    mov [0xb800e], byte 'o'
    mov [0xb8010], byte 'r'
    mov [0xb8012], byte 'l'
    mov [0xb8014], byte 'd'
    mov [0xb8016], byte '!'
      
    call DetectCpuID
    call DetectLongMode
    call SetupIdentityPaging
    call EditGDT

    jmp Start64bit

[bits 64]
[extern _start]

Start64bit:
    mov [0xb8000], byte '6'
    mov [0xb8002], byte '4'
    mov [0xb8004], byte ' '
    mov [0xb8006], byte 'b'
    mov [0xb8008], byte 'i'
    mov [0xb800a], byte 't'
    
    call _start
    mov [0xb8000], byte 'F'
    hlt
    jmp $

; times (512 * 16) - ($$ - $) db 0
