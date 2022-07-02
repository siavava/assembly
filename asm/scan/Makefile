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

PROG = scan
OBJS = $(PROG).o
SOURCEFILE = $(PROG).asm

##### Memory tracker #####
VALGRIND= valgrind --leak-check=full --show-leak-kinds=all

##### Timer #####
timer = time

##### Programs #####

all: $(PROG)

$(PROG): $(OBJS)
	$(LINKER) $(LINKERFLAGS) $^ -o $@

$(OBJS): $(SOURCEFILE)
	$(ASM) $(ASMFLAGS) $^ -o $@

test: 
	make all
	./$(PROG)
	make clean
	
valgrind:
	make all
	$(VALGRIND) ./$(PROG)
	make clean
	
clean:
	rm -f *.o
	rm -f $(PROG)
