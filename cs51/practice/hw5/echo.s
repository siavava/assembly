﻿# sws, cs51
# Modified by: Amittai
# CS-51 Homework 5

# addresses of the I/O devices
.defl KBSR 0x00fffe00
.defl KBDR 0x00fffe04
.defl DSR  0x00fffe08
.defl DDR  0x00fffe0c

.pos 0
    # set up stack
    irmovl stack, %esp


echo:
    call GETC               # get a character from the keyboard
    call format             # format the character
    call PUTC               # print the character
    jmp echo                # loop

# subroutine: get a char into %eax
GETC:
    pushl %ebx                              # since we stomp on that

    # read KBSR until it's 1
KBNotReady:
    mrmovl KBSR, %ebx
    addl %ebx,%ebx
    je KBNotReady # jmps if zero

    # got a character---get it into %ecx
    mrmovl  KBDR, %eax

    popl %ebx                               # restore ebx
    ret
		
# subroutine: send %eax to display
PUTC:
    pushl %ecx

    # read DSR until it's 1
DNotReady:
    mrmovl DSR, %ecx
    addl %ecx,%ecx
    je DNotReady                            # jmps if zero

    # write the char!
    rmmovl %eax, DDR	

    popl %ecx                               # recover ecx
    ret
    
format:
    # check lower bound for letters
    irmovl 0x41, %ecx
    subl %eax, %ecx
    jg NON_LETTER
    
    # check upper bound for letters
    irmovl 0x7a, %ecx
    subl %eax, %ecx
    jl NON_LETTER
    
    # check if it's upper or lower case
    irmovl 0x61, %ecx
    subl %eax, %ecx
    jle CAPS                              # turn to upper-case
    jg SMALLS                             # turn to lower-case
    
    # skip non-letters
NON_LETTER:
    ret
    
    # capitalize lower-case letters
CAPS:
    irmovl 0x20, %ecx
    subl %ecx, %eax
    ret
    
    # de-capitalize upper-case letters
SMALLS:
    irmovl 0x20, %ecx
    addl %ecx, %eax
    ret

.pos 0xa0
stack: 
    .long 0xFFFFFFFF # the top of the empty stack

