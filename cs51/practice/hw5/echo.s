# sws, cs51

# addresses of the I/O devices
.defl KBSR 0x00fffe00
.defl KBDR 0x00fffe04
.defl DSR  0x00fffe08
.defl DDR  0x00fffe0c

.pos 0
    # set up stack
    irmovl stack, %esp


echo:
    call GETC
    call format
    call PUTC
    jmp echo

# subroutine: get a char into %eax
GETC:
    pushl %ebx  # since we stomp on that

    # read KBSR until it's 1
KBNotReady:
    mrmovl KBSR, %ebx
    addl %ebx,%ebx
    je KBNotReady # jmps if zero

    # got a character---get it into %ecx
    mrmovl  KBDR, %eax

    popl %ebx
    ret
		
# subroutine: send %eax to display
PUTC:
    pushl %ecx

    # read DSR until it's 1
DNotReady:
    mrmovl DSR, %ecx
    addl %ecx,%ecx
    je DNotReady # jmps if zero

    # write the char!
    rmmovl %eax, DDR	

    popl %ecx
    ret
    
format:
    # pushl %ecx
    irmovl 0x61, %ecx
    subl %eax, %ecx
    jle CAPS
    jg SMALLS
    # popl %ecx
    # ret
    
    
CAPS:
    irmovl 0x20, %ecx
    subl %ecx, %eax
    ret
    
SMALLS:
    irmovl 0x20, %ecx
    addl %ecx, %eax
    ret

.pos 0x80
stack: 
.long 0xFFFFFFFF # the top of the empty stack

