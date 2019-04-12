.section .text
.globl _start

_start:
  
# open
        movl  $0x2  , %eax 
        leal  file, %edi 
        movl  $01102, %esi 
        movl  $0666, %edx 
        syscall
        movl %eax, fd

#write header
        movl (fd), %edi
        leal header, %esi
        movl $13, %edx
        movl $0x1, %eax
        syscall

        movl $320, %r8d
        movl $200, %r9d
        
loop:
        movl %r8d, %eax
        movl $FACTOR, %edx
        mull %edx
        shrl $8, %eax
        movl %eax, %r10d

        movl %r9d, %eax
        movl $78, %edx
        mull  %edx
        andl $0x0000ff00, %eax

        xorl %eax, %r10d

        movl $0xff, %eax
        subl  %r9d, %eax

        movl $78, %edx
        mull %edx
        shll $8, %eax
        andl $0xff0000, %eax

        xorl %eax, %r10d

        movl %r9d  ,%r11d
        decl %r11d
        movl $960, %eax
        mull %r11d

        movl %eax, %r11d

        movl %r8d, %eax
        decl %eax
        movl $3, %esi
        mull %esi

        addl %r11d, %eax

        movl buff(%eax), %r11d
        andl $0xff000000, %r11d
        xorl %r10d, %r11d
        movl %r11d,buff(%eax)

        decl %r8d
        jnz loop

        decl %r9d
        movl $320, %r8d
        jnz loop

        movl (fd), %edi
        leal (buff), %esi
        movl $0x2EE00, %edx
        movl $0x1, %eax
        syscall

        
# close
        movl (fd), %edi
        movl $0x3, %eax
        syscall

        movl $60, %eax
        movl  $0, %edi
        syscall
        
.section .data
file:
  .ascii "./a.ppm\0"
header:
  .ascii "P6\n320 200\n\xff\n"
  
  .set FACTOR, 125

.section .bss
  .lcomm fd, 4
  .lcomm buff, 0x2EE00
