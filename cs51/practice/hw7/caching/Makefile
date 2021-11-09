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
	# ./$(PROG) ./data/sample.txt 0
	# ./$(PROG) ./data/sample.txt 1
	# ./$(PROG) ./data/sample.txt 2
	# ./$(PROG) ./data/sample.txt 3

	./$(PROG) ./data/long-trace.txt 3

valgrind: $(PROG)
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./$(PROG) ./data/sample.txt 1

quicktest: $(PROG).cpp
	$(CC) $(CFLAGS) -o $(PROG) $< -DVERBOSE
	./$(PROG) ./data/sample.txt 0
	./$(PROG) ./data/sample.txt 1
	./$(PROG) ./data/sample.txt 2
	./$(PROG) ./data/sample.txt 3

clean:
	rm -f $(PROG)
