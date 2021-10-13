# Program to read a value from memory into a register.
#
# Author: Amittai Siavava <github: @siavava>
# CS 51 ~ Computer Architecture, Fall '21


.pos 0
init:    
    irmovl Stack, %esp  
    irmovl  Stack, %ebp
    
    # load input into %edi
    irmovl input, %esi
    mrmovl (%esi), %edi
    rrmovl %edi, %esi
    
    # call checkBCD -- which sets flag and exits if input not BCD.
    irmovl 0x04, %ecx
    #addl %ecx, %esp
    #call CheckBCD
    
    #rrmovl %edi, %esi
    
    # call checkDIV2 -- which sets flag and exits if input is not divisible by 2
    rrmovl %edi, %esi
    addl %ecx, %esp
    call DIV_TWO
    
    rrmovl %edi, %esi
    
    # call checkDIV3 -- which sets flag and exits if input is not divisible by 3
    addl %ecx, %esp
    call DIV_THREE
    
    # set flag and exit.
    irmovl output, %esi
    irmovl 0x01, %edi
    rmmovl %edi, (%esi)
 
    

CheckBCD:

    # check each digit.

    irmovl 0x0a000000, %eax
    subl %eax, %esi
    jge NotBCD
    
    
    irmovl 0x00ffffff, %eax
    andl %eax, %esi
    
    irmovl 0x000a0000, %eax
    subl %eax, %esi
    jge NotBCD
    
    
    irmovl 0x0000ffff, %eax
    andl %eax, %esi
    
    irmovl 0x00000a00, %eax
    subl %eax, %esi
    jge NotBCD
    
    
    irmovl 0x000000ff, %eax
    andl %eax, %esi
    
    irmovl 0x0000000a, %eax
    subl %eax, %esi
    jge NotBCD

    ret
    
DIV_TWO:
    # check if a number is divisible by 2.
    irmovl 0x01, %ebx
    andl %ebx, %esi
    jg isNotDIV
    
    ret
    
DIV_THREE:
    # check if the number is divisible by 3.
    
    # First, if it's zero we pass the div check
    irmovl 0x0, %eax
    subl %eax, %esi 
    je isDIV
    
    # otherwise, Loop, 
    # reducing number by 3 on each iteration
    irmovl 0x03, %eax
    jmp Loop
    
Loop:
    # Loop, reducing number by 3 
    # until it's 0 (divisible)
    # or less than zero (not divisible)
    
    subl %eax, %esi
    je isDIV
    jl isNotDIV
    jmp Loop
    
NotBCD:
    # set notBCD flag
    irmovl output, %eax
    irmovl 0xe, %ebx
    rmmovl %ebx, (%eax)
    halt

isNotDIV:
    # set Not DIV6 flag
    irmovl output, %eax
    irmovl 0x0, %ebx
    rmmovl %ebx, (%eax)
    halt   
   
isDIV:
    # set is divisible by 6 flag
    irmovl output, %eax
    irmovl 0x1, %ebx
    rmmovl %ebx, (%eax)
    halt
    

input: 
    # asking about the decimal number 1234.
    .byte 0x06
    .byte 0x00
    .byte 0x00
    .byte 0x00
    
output:
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    
.defl Stack 0x00



