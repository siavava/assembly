; Application to scan a string for a character.
;
; Author: siavava <amittaijoel@outlook.com>

section .text
global _start

_start:
  mov ecx, len
  mov edi, msg
  mov al, 'Q'
  cld
  repne scasb
  je found

  mov eax, 4
  mov ebx, 1
  mov ecx, notfound
  mov edx, notfound_len
  int 80h
  jmp exit

found:
  mov eax, 4
  mov ebx, 1
  mov ecx, found_msg
  mov edx, found_len
  int 80h

exit:
  mov eax, 1
  mov ebx, 0
  int 80h

section .data
  msg           db 'Here is a string with a single recurring character, Q, and some more text', 0
  len           equ $ - msg
  char          db 'Q'
  notfound      db 'Not found!', 0xa
  notfound_len  equ $ - notfound
  found_msg     db 'Found!', 0xa
  found_len     equ $ - found_msg
