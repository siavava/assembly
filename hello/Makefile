# 

# Makefile for Hello World in Assembly
# 
# Author: siavava <amittaijoel@outlook.com>

# Use bash as default Shell
SHELL := /bin/bash

# Use NASM as cc for assembly
CC = nasm
CFLAGS = -f
VALGRIND= valgrind --leak-check=full --show-leak-kinds=all
timer = time

all: hello helloc

hello: hello.o
	ld -s -o $@ hello.o
	rm -f hello.o

hello.o: first.asm
	$(CC) $(CFLAGS) elf64 $^ -o $@

clean:
	rm -f *.o
	rm -f hello
	rm -f helloc

helloc:
	gcc -Wall -pedantic hello.c -o helloc

test: 
	make all
	printf "\n\nTiming run of assembly version.\n"
	$(timer) ./hello &
	printf "\n\nTiming run of C version.\n"
	$(timer) ./helloc &
	printf "\n\nCleaning up.\n"
	make clean
	
valgrind:
	$(VALGRIND) ./hello
	