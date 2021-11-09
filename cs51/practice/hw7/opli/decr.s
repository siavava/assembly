# Author: Amittai Joel Siavava
#
# A simple program demonstrating functionality of a variation of iopl: isubl.
#
# This program loops over ascii characters, printing them and isubl ~ ing with 0x01.


.pos 0
init:
    irmovl stack, %esp      # initialize stack pointer
    irmovl $0x7e, %eax      # load value into %eax
    irmovl DDR, %esi        # load DDR address location into %esi
    mrmovl (%esi), %esi     # load DDR into %esi
decr:
    rmmovl %eax, (%esi)     # print current ASCII letter
    isubl $0x01, %eax       # decrement by one
    irmovl $0x40, %ebx      # load lowest letter into %ebx
    subl %eax, %ebx         # deduct current letter from lowest
    jle decr                # if lowest <= current, loop.
    halt
 
# IO Addresses
.pos 0x40
KBSR:
    .long 0x00fffe00
KBDR:
    .long 0x00fffe04
DSR:
    .long 0x00fffe08
DDR:
    .long 0x00fffe0c
    
# Stack pointer. 
.pos 0x60
stack:
    .long 0xffffffff
    