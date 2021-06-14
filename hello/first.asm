; Hello World in Assembly
;
; Author: siavava <amittaijoel@outlook.com>
;
; Usage (post-compile): ./hello
section .text
global _start
_start:
  mov edx, len
  mov ecx, msg
  mov ebx, 1
  mov eax, 4
  int 0x80
  mov eax, 1
  int 0x80
section .data
msg db 'Hello, world', 0xa
len equ $ - msg
