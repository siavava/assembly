; Hello World in Assembly
;
; Author: siavava <amittaijoel@outlook.com>
;
; Usage (post-compile): ./hello
section .text
global _start
_start:                     ; entrypoint
  mov dx, len               ; get message len to edx
  mov ecx, msg              ; get message to exc
  mov bx, 1                 ; fd #1       -> stdout
  mov ax, 4                 ; sys call #4 -> write to fd in ebx
  int 0x80                  ; kernel call -> exec $eax
  mov ax, 1                 ; sys call #1 -> exit
  int 0x80                  ; kernel call -> exec $eax
  ret

section .data
msg db 'Hello, World!', 0xa ; message
len equ $ - msg             ; message len -> (here to start of "msg")
