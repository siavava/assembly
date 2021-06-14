; Hello World in Assembly
;
; Author: siavava <amittaijoel@outlook.com>
;
; Usage (post-compile): ./hello
section .text
global _start
_start:                     ; entrypoint
  mov edx, len              ; message length
  mov ecx, msg              ; actual message
  mov ebx, 1                ; file descriptor (stdout)
  mov eax, 4                ; system call #4 -> sys_write
  int 0x80                  ; kernel
  mov eax, 1                ; system call #1 -> sys_exit
  int 0x80                  ; kernel

section .data
msg db 'Hello, world!', 0xa ; message
len equ $ - msg             ; message length
