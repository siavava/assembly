# Makefile for caching app.
#
# Author: Amittai Joel Siavava

CC = g++
CFLAGS = -Wall -pedantic -std=c++11 -O3
PROG = caching
VALGRIND="valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes"

all: $(PROG)

$(PROG:) : $(PROG).cpp
	$(CC) $(CFLAGS) -o $@ $<

test: $(PROG)
	./testing.sh

valgrind: $(PROG)
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./$(PROG) ./data/sample.txt 1

verbose: $(PROG).cpp
	$(CC) $(CFLAGS) $< -DVERBOSE -o $(PROG)

clean:
	rm -f $(PROG)
