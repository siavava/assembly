# Program to read a value from memory into a register.
#
# Author: Amittai Siavava <github: @siavava>


.pos 0
Init:

  # First, let's initialize some value
  # and save it to memory so we can move it.
  irmovl val, %ebx
  irmovl addr, %edx
  rmmovl %ebx, 0x000(%edx)
  
  # Now, let's fetch it back into eax
  irmovl fetch, %ecx
  mrmovl 0x000(%ecx), %eax
  ret
    
.defl val 0x1111
.defl addr 0x000c
.defl fetch 0x00c
