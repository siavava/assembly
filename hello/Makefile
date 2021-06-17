# Makefile for Hello World in Assembly
# 
# Author: siavava <amittaijoel@outlook.com>

# Use bash as default Shell
SHELL := /bin/bash

##### Assembler #####
ASM = nasm
ASMFLAGS = -f
ASMFORMAT = elf64

##### Linker #####
LINKER = ld
LINKERFLAGS = -s

##### C compiler #####
CC = gcc
CFLAGS = -Wall -pedantic

##### Memory tracker #####
VALGRIND= valgrind --leak-check=full --show-leak-kinds=all

##### Timer #####
timer = time

##### Programs #####
ASMPROG = hello
CPROG = helloc

all: $(ASMPROG) $(CPROG)

hello: hello.o
	$(LINKER) $(LINKERFLAGS) hello.o -o $@
	rm -f hello.o

hello.o: first.asm
	$(ASM) $(ASMFLAGS) $(ASMFORMAT) $^ -o $@


helloc: hello.c
	$(CC) $(CFLAGS) $^ -o $@

test: 
	make all
	printf "\n\nTiming run of assembly version.\n"
	$(timer) ./hello &
	printf "\n\nTiming run of C version.\n"
	$(timer) ./helloc &
	printf "\n\nCleaning up.\n"
	make clean
	
clean:
	rm -f *.o
	rm -f hello
	rm -f helloc

valgrind:
	$(VALGRIND) ./hello
	