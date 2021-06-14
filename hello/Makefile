# Makefile for Hello World in Assembly
# 
# Author: siavava <amittaijoel@outlook.com>

CC = nasm
CFLAGS = -f
VALGRIND= valgrind --leak-check=full --show-leak-kinds=all

all: hello

hello: hello.o
	ld -s -o $@ hello.o
	rm -f hello.o

hello.o: first.asm
	$(CC) $(CFLAGS) elf64 $^ -o $@

clean:
	rm -f *.o
	rm -f hello

test: 
	make all
	./hello &
	make clean
	
valgrind:
	$(VALGRIND) ./hello
	