# Program to read a value from memory into a register.
#
# Author: Amittai Siavava <github: @siavava>
# CS 51 ~ Computer Architecture, Fall '21


.pos 0
init:    
    irmovl Stack, %esp          # Initialize stack pointer
    irmovl  Stack, %ebp         # Initialize base pointer
    
    # load input into %edi
    irmovl input, %esi          # load input ADDRESS into %esi
    mrmovl (%esi), %edi         # load input VALUE into %edi
    rrmovl %edi, %esi           # copy input VALUE into %esi
    
    
    irmovl 0x04, %ecx           # move 4 into %ecx
    addl %ecx, %esp             # advance stack pointer
    call CheckBCD               # Call checkBCD

    # NOTE: CheckBCD sets flag and exits
    # # if value in %esi is not a valid BCD.
    
    rrmovl %edi, %esi          # copy input VALUE into %esi
    addl %ecx, %esp            # advance stack pointer
    call DIV_TWO               # Call DIV_TWO
    
    # NOTE: DIV2 sets flag and exits
    # # if value in %esi is not divisible by 2.

    rrmovl %edi, %esi           # copy input VALUE into %esi
    addl %ecx, %esp             # advance stack pointer
    call DIV_THREE              # Call DIV_THREE
    
    # NOTE: DIV3 sets flag and exits
    # # if value in %esi is not divisible by 3.

    # set divisible by 6 flag and exit
    irmovl output, %esi         # load output ADDRESS into %esi 
    irmovl 0x01, %edi           # load 1 into %edi
    rmmovl %edi, (%esi)         # store 1 into output ADDRESS
    halt    

CheckBCD:
    # check each digit.
    irmovl 0x0a000000, %eax     # load 10 into %eax, shifted to match digit position
    subl %eax, %esi             # subtract 10 from %esi, at the position
    jge NotBCD                  # if %esi >= 0, jump to NotBCD
    
    
    irmovl 0x00ffffff, %eax     # load all 1s into %eax, shifted to drop unwanted values
    andl %eax, %esi             # AND %esi with %eax, to drop unwanted values
    
    irmovl 0x000a0000, %eax     # load 10 into %eax, shifted to match digit position
    subl %eax, %esi             # subtract 10 from %esi, at the position
    jge NotBCD                  # if %esi >= 0, jump to NotBCD
    
    
    irmovl 0x0000ffff, %eax     # load all 1s into %eax, shifted to drop unwanted values
    andl %eax, %esi             # AND %esi with %eax, to drop unwanted values
    
    irmovl 0x00000a00, %eax     # load 10 into %eax, shifted to match digit position
    subl %eax, %esi             # subtract 10 from %esi, at the position
    jge NotBCD                  # if %esi >= 0, jump to notBCD
    
    
    irmovl 0x000000ff, %eax     # load all 1s into %eax, shifted to drop unwanted values
    andl %eax, %esi             # AND %esi with %eax, to drop unwanted values
    
    irmovl 0x0000000a, %eax     # load 10 into %eax, shifted to match digit position
    subl %eax, %esi             # subtract 10 from %esi, at the position
    jge NotBCD                  # if %esi >= 0, jump to notBCD

    # return to caller
    ret
    
DIV_TWO:
    # check if a number is divisible by 2.
    irmovl 0x01, %ebx               # move 1 into %ebx
    andl %ebx, %esi                 # bitwise AND to filter out last bit in %esi
    jg isNotDIV                     # if not 0, not divisible by 2
    
    # return to caller.
    ret
    
DIV_THREE:
    # check if the number is divisible by 3.
    
    # First, if it's zero we pass the div check
    irmovl 0x0, %eax                # move 0 into %eax
    subl %eax, %esi                 # subtract 0 from %esi
    je isDIV                        # if result is 0, we pass the div check
    
    # otherwise, Loop, 
    # reducing number by 6 on each iteration (faster, since we already know number is even.)
    irmovl 0x06, %eax               # move 6 into %eax
    jmp Loop                        # jump to Loop
    
Loop:
    # Loop, reducing number by 3 
    # until it's 0 (divisible)
    # or less than zero (not divisible)
    
    subl %eax, %esi                 # subtract 6 from %esi
    je isDIV                        # if result is 0, we pass the div check
    jl isNotDIV                     # if result is less than 0, we fail the div check
    jmp Loop                        # if greater than zero, repeat loop.
    
NotBCD:
    # set notBCD flag
    irmovl output, %eax             # load output ADDRESS into %eax
    irmovl errorNotBCD, %ebx        # move 0xe into %ebx
    rmmovl %ebx, (%eax)             # store 0xe into output ADDRESS
    halt                            # stop program

isNotDIV:
    # set Not DIV6 flag
    irmovl output, %eax             # load output ADDRESS into %eax
    irmovl failFlag, %ebx           # move 0 into %ebx
    rmmovl %ebx, (%eax)             # store 0 into output ADDRESS
    halt                            # stop program
   
isDIV:
    # set is divisible by 6 flag
    irmovl output, %eax             # load output ADDRESS into %eax
    irmovl passFlag, %ebx           # move 1 into %ebx
    rmmovl %ebx, (%eax)             # store 1 into output ADDRESS
    halt                            # stop program
    
input: 
    # asking about the decimal number 1234.
    .byte 0x06                      # bit 1
    .byte 0x00                      # bit 2
    .byte 0x00                      # bit 3
    .byte 0x00                      # bit 4
    
output:
    .byte 0x00                     # bit 1
    .byte 0x00                     # bit 21        
    .byte 0x00                     # bit 3
    .byte 0x00                     # bit 4
    
.defl Stack 0x00                   # stack pointer
.defl passFlag 0x01                # flag for passing div by 6 test
.defl failFlag 0x00                # flag for failing div by 6 test
.defl errorNotBCD 0xe              # flag for invalid BCD
