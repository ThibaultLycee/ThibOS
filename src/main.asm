org 0x7c00
bits 16

%define ENDL 0x0d, 0x0a

jmp main

; Prints a string to the screen
; Params :
; 	ds:si -> points to the string
puts:
	; Saves registers that will be modified
	push si
	push ax
.loop:
	lodsb
	or al, al
	jz .done
	
	mov ah, 0x0e
	mov bh, 0
	int 0x10

	jmp .loop
.done:
	pop ax
	pop si
	ret

main:
	; setup data segment
   	mov ax, 0
   	mov ds, ax
   	mov es, ax

	; setup stack
	mov ss, ax
    	mov sp, 0x7c00

	mov si, msg
	call puts

   	hlt

.halt:
   	jmp .halt

msg: db "Hello, World!", ENDL, 0

times 510 - ($ - $$) db 0
dw 0xaa55
