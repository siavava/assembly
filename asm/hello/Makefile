# Makefile for Hello World in Assembly
# 
# Author: siavava <amittaijoel@outlook.com>

# Use bash as default Shell
SHELL := /bin/bash

##### Assembler #####
ASM = yasm
ASMFLAGS = -g dwarf2 -f elf64

##### Linker #####
LINKER = ld
LINKERFLAGS = -s 

##### C compiler #####
CC = gcc
CFLAGS = -Wall -pedantic --std=c11

##### Memory tracker #####
VALGRIND= valgrind --leak-check=full --show-leak-kinds=all

##### Timer #####
timer = time

##### Programs #####
ASMPROG = hello
CPROG = helloc

all: $(ASMPROG) $(CPROG)

hello: hello.o
	$(LINKER) $(LINKERFLAGS) $^ -o $@
	rm -f hello.o

hello.o: hello.asm
	$(ASM) $(ASMFLAGS) $^ -o $@

hello.c.asm: hello.c
	$(CC) $(CFLAGS) -S -masm=intel $^ -o $@


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
	
valgrind:
	make all
	$(VALGRIND) ./helloc
	# $(VALGRIND) ./hello
	make clean
	
clean:
	rm -f *.o
	rm -f hello
	rm -f helloc