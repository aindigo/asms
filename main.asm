        global _start

        section .text
_start:
; open
        mov rax, 0x2
        lea rdi, [file]
        mov rsi, 1102q
        mov rdx, 0666q
        syscall
        mov [fd], rax

; write
        mov rdi, [fd]
        lea rsi, [header]
        mov rdx, 13
        mov rax, 0x1
        syscall

        mov r8d, 320
        mov r9d, 200

loop:
        mov eax, r8d
        mov edx, factor
        mul edx
        shr eax, 8
        mov r10d, eax

        mov eax, r9d
        mov edx, 78
        mul edx
        and eax, 0x00ff00

        xor r10d, eax

        mov eax, 0xff
        sub eax, r9d 

        mov edx, 78
        mul edx
        shl eax, 8
        and eax, 0xff0000

        xor r10d, eax
        
        mov r11d, r9d
        dec r11d
        mov eax, 960
        mul r11d

        mov r11d, eax

        mov eax, r8d
        dec eax
        mov esi, 3
        mul esi

        add eax, r11d

        mov r11d, [color + eax]
        and r11d, 0xff000000
        xor r11d, r10d
        mov [color + eax], r11d

        dec r8d
        jnz loop

        dec r9d
        mov r8d, 320
        jnz loop

        mov rdi, [fd]
        lea rsi, [color]
        mov rdx, 0x2EE00
        mov eax, 0x1
        syscall

; close
        mov edi, [fd]
        mov rax, 0x3

        syscall

_exit:
        mov rax, 60
        mov rdi, 0
        syscall

        section .data
header:
        db "P6", 10, "320 200", 10, 255, 10

file:
        db "./i.ppm", 0

        factor equ 125

        section .bss
fd:
        resb 4
color:
        resb 0x2EE00

