gdt_nulldesc:
    dd 0
    dd 0

gdt_codedesc:
    dw 0xffff		; Limit
    dw 0x0000		; Base (low)
    db 0x00		; Base (medium)
    db 0b10011010	; Flags
    db 0b11001111	; Flags + Upper Limit
    db 0x00		; Base (high)

gdt_datadesc:
    dw 0xffff
    dw 0x0000
    db 0x00
    db 0b10010010
    db 0b11001111
    db 0x00

gdt_end:

gdt_descriptor:
    gdt_size:
	dw gdt_end - gdt_nulldesc - 1
    	dq gdt_nulldesc

codeseg equ gdt_codedesc - gdt_nulldesc
dataseg equ gdt_datadesc - gdt_nulldesc

[bits 32]

EditGDT:
    mov [gdt_codedesc + 6], byte 0b10101111
    mov [gdt_datadesc + 6], byte 0b10101111
    ret

[bits 16]
