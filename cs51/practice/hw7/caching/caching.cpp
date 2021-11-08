/**
 * @file caching.cpp
 * @author Amittai Joel Siavava
 * @brief Simulated caching in C++
 * @version 0.1
 * @date 2021-11-07
 * 
 * @copyright Copyright (c) 2021
 * 
 */

#include <cstdio>
#include <cstdlib>
#include <iostream>
using namespace std;

/* GLOBAL VARIABLES */
const unsigned long TAGMASK = 0xfffffc00;   // mask for the tag bits
const unsigned long SETMASK = 0x000003f0;   // mask for the set bits
const int NUM_LINES = 64;                   // total number of lines implemented.
const int LINE_SIZE = 16;                   // size of each line in bytes

typedef struct _set {
  bool** valid;
  char** lines;
  unsigned long int tag;
} set;

class Cache {
  public:
    Cache(int);
    ~Cache();
    void read(unsigned long int);
    void write(unsigned long int);
    void print();
  private:
    int _size;
    int _associativity;
    int _blockSize;
    set** _sets;
};

Cache::Cache(int associativity) {

  switch (associativity) {
    case 0: {
      cout << "Direct Mapping" << endl;
      _size = NUM_LINES;
      _blockSize = 1;
      break;
    }
    case 1: {
      cout << "Two-Way Associative Mapping" << endl;
      _size = NUM_LINES % 2;
      _blockSize = 2;
      break;
    }
    case 2: {
      cout << "Four-Way Associative Mapping" << endl;
      _size = NUM_LINES % 4;
      _blockSize = 4;
      break;
    }
    case 3: {
      cout << "Fully Associative Mapping" << endl;
      _size = 1;
      _blockSize = NUM_LINES;
      break;
    }
    default:
      cout << "Unknown scheme not yet implemented." << endl;
      exit(1);
    }

  _associativity = associativity;
  _sets = new set*[_size];
  for (int i = 0; i < _size; i++) {
    _sets[i] = new set;
    _sets[i]->valid = new bool*[_blockSize];
    _sets[i]->lines = new char*[_blockSize];
    for (int j = 0; j < _blockSize; j++) {
      _sets[i]->valid[j] = new bool;
      _sets[i]->lines[j] = new char[LINE_SIZE];
      *(_sets[i]->valid[j]) = false;
      *(_sets[i]->lines[j]) = '\0';
    }
    _sets[i]->tag = 0;
  }
}

void Cache::write(unsigned long int address) {
  unsigned long int tagAddr = (address & TAGMASK);
  unsigned long int setAddr = (address & SETMASK);
  set* targetSet = _sets[setAddr];
  for (int i = 0; i < _blockSize; i++) {
    if (*(targetSet->valid[i]) && targetSet->tag == tagAddr) {

    }
}

void Cache::read(unsigned long int address)
{
  unsigned long int tag = (address & TAGMASK);
  unsigned long int set = (address & SETMASK);


}



int
main(int argc, char** argv)
{

  FILE* fp;
  if ((fp = fopen(argv[1], "r")) == NULL) {
    printf("Error opening file %s\nPlease make sure you have the correct path & permissions!\n", argv[1]);
    return 1;
  }

  char c;
  unsigned long n;

  while (fscanf(fp, "%c %x", &c, &n) != EOF) {

    switch (c) {
      case 'I': {
        printf("Instruction fetch: %c %x\n", c, n);
        break;
      }
      case 'D': {
        printf("Data fetch: %c %x\n", c, n);
        break;
      }
      default: {
        printf("Unknown operation: %c %x\n", c, n);
        break;
      }
    }

  }
  fclose(fp);

  return 0;
}
