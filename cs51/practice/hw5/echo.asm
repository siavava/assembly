; echo program in X86 Assembly

echo:
  push ebp
  mov esp, ebp
  push ebx
  sub $20, esp
  lea ebx, [esp+4]
  mov ebp, esp
