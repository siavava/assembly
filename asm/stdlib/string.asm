; Essential string operations.
;
; Author: siavava <amittaijoel@outlook.com>

section .text

STRLEN:
  push  ecx
  mov		ecx, 0    ; rcx = 0
  not   ecx       ; rcx = -1
  cld             ; clear direction flag

  ; scan string until NUL
  ; rcx = - strlen - 2
  
  repne	scasb
  not   ecx       ; rcx = strlen + 1
  dec		ecx       ; rcx = strlen
  mov		eax, ecx  ; save strlen to return register
  pop   ecx       ; reload original contents or rcx
  ret
