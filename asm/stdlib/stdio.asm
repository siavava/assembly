; Simple IO Functionality.
;
; Author: siavava <amittaijoel@outlook.com>

section .text

%include "string.asm"

PUTS:
  ; save current register values to the stack.
  push eax
  push ecx
  push edx
  push ebx

  call STRLEN  ; loads strlen into %eax
  mov edx, eax ; move len to %edx
  mov eax, 4   ; move interrupt number to %eax
  mov ebx, 1   ; move interrupt code to %ebx
  mov ecx, notfound
  mov edx, notfound_len
  int 80h
