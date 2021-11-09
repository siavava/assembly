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
const unsigned int TAGMASK = 0x00fff077;   // mask for the tag bits
const unsigned int SETMASK = 0x000003f0;    // mask for the set bits
const int NUM_LINES = 64;                   // total number of lines implemented.
const int LINE_SIZE = 16;                   // size of each line in bytes

typedef struct _set {
  unsigned int addr;          /* address of the current set */
  bool* valid;                /* valid bit for each line */  
  // void** lines;            /* lines of data */
  unsigned int* tags;         /* tags for each line */
  int* lastAccessed;          /* last accessed time for each line */
} set;

class Cache {
  public:
    Cache(int);
    ~Cache();

    int hits, misses;
    void read(unsigned int, int);
  private:
    /* 
      NOTE: The cache holds _numSets sets, 
      each of which holds _blockSize lines.
     */
    int _associativity;     /* associativity mode */
    int _numSets;           /* total number of sets in the cache */
    int _blockSize;         /* size of each block (SET) in number of lines */
    set** _sets;            /* array of pointers to sets */
};

/**
 * @brief Construct a new Cache object
 * 
 * @param associativity: associativity mode
 *  0 -> Direct-mapped
 *  1 -> Two-way associative
 *  2 -> Four-way associative
 *  3 -> Fully associative
 * 
 * NOTE: Errors in the associativity mode will not be handled;
 *       the program will print an error message and exit.
 */
Cache::Cache(int associativity) {

  switch (associativity) {
    case 0: {
      cout << "\nDirect Mapping" << endl;
      _numSets = NUM_LINES;
      _blockSize = 1;
      break;
    }
    case 1: {
      cout << "\nTwo-Way Associative Mapping" << endl;
      _numSets = NUM_LINES / 2;
      _blockSize = 2;
      break;
    }
    case 2: {
      cout << "\n\nFour-Way Associative Mapping" << endl;
      _numSets = NUM_LINES / 4;
      _blockSize = 4;
      break;
    }
    case 3: {
      cout << "\nFully Associative Mapping" << endl;
      _numSets = 1;
      _blockSize = NUM_LINES;
      break;
    }
    default:
      cout << "\nUnknown scheme, not yet implemented." << endl;
      exit(1);
    }

  _associativity = associativity;
  _sets = new set*[_numSets];
  hits = 0, misses = 0;
  for (int i = 0; i < _numSets; i++) {
    _sets[i] = new set;
    _sets[i]->valid = new bool[_blockSize];
    _sets[i]->lastAccessed = new int[_blockSize];
    _sets[i]->tags = new unsigned int[_blockSize];
    // _sets[i]->lines = new char*[_blockSize];
    for (int j = 0; j < _blockSize; j++) {
      _sets[i]->valid[j] = false;
      _sets[i]->tags[j] = 0;            /* initialize tags to 0 */
      _sets[i]->valid[j] = false;
      _sets[i]->lastAccessed[j] = 0;
    }
  }
}

/**
 * @brief Destructs a Cache object
 */
Cache::~Cache() {
  for (int i = 0; i < _numSets; i++) {
    delete[] _sets[i]->valid;
    delete[] _sets[i]->tags;
    delete[] _sets[i]->lastAccessed;
    // delete[] _sets[i]->lines;
    delete _sets[i];
  }
  delete[] _sets;
}


void 
Cache::read(unsigned int address, int time)
{
  // unsigned long int original_tag = address & TAGMASK;
  // unsigned long int original_set = address & SETMASK;
  unsigned int original_tag = address & TAGMASK;
  unsigned int original_set = (address & SETMASK) >> 4;
  int tagAddr = original_tag % _blockSize;   /* compute tag mask, limit to the number of lines per set */
  int setAddr = original_set % _numSets;     /* compute set mask, limit to the number of sets */

  /* fetch the target set */
  set* targetSet = _sets[setAddr];

  /* track LRU */
  int lastAccess = 0;
  int lastAccessedIndex = -1; 

  /* if current line target is valid... */
  for (int index = 0; index <= _blockSize; index++) {
    if (targetSet->valid[index] && targetSet->tags[index] == address) {
      // if targetSet->tags[index]
      targetSet->lastAccessed[index] = time;
#ifdef VERBOSE
      printf("%2d: addr 0x%x; tag %x; looking in set %d, found it in line %d; hit!\n", \
      time, address, original_tag, setAddr, index);
#endif
      hits++;
      return;
    }
    else {
      if (! targetSet->valid[index] || targetSet->lastAccessed[index] > lastAccess) {
        lastAccess = targetSet->lastAccessed[index];
        lastAccessedIndex = index;
      }
    }
  }

  /* 
    if control reaches here, line wasn't found.
    if the set is full, evict the LRU line.
    otherwise, add the new line.

    NOTE: since we initialze accesses to zero,
    if the LRU score is 0 we know an empty spot exists 
    and we can save into that line. 
    
    Otherwise, evict the LRU line and save the new line.
  */
  misses++;
  if (lastAccess == 0) {

#ifdef VERBOSE
    printf("%2d: addr 0x%x; tag %x; looking in set %d, miss! line %d empty, adding there.\n", \
    time, address, original_tag, setAddr, tagAddr);
#endif

    targetSet->tags[lastAccessedIndex] = address;
    targetSet->lastAccessed[lastAccessedIndex] = time;
    targetSet->valid[lastAccessedIndex] = true;
  }
  else {
#ifdef VERBOSE
    printf("%2d: addr 0x%x; tag %x; looking in set %d, miss! line %d evicted, adding there.\n" , \
    time, address, original_tag, setAddr, tagAddr);
#endif
  }
}



int
main(int argc, const char* argv[])
{
  if (argc != 3) {
    cout << "Usage: ./caching <trace file> <associativity>" << endl;
    exit(1);
  }

  FILE* fp;
  if ((fp = fopen(argv[1], "r")) == NULL) {
    cout << "Error opening file" 
         << argv[1] 
         << "\nPlease make sure you have the correct path & permissions." 
         << endl;
    exit(1);
  }

  int associativity = atoi(argv[2]);
  Cache cache = Cache(associativity);

  char c; 
  unsigned int n;

  int time = 0;

  while (fscanf(fp, "%c %x\n", &c, &n) != EOF) {

    cache.read(n, ++time);


    /* 
      NOTE: The cache holds _numSets sets, 
      each of which holds _blockSize lines.
     */
    // printf("char = %c\n\n", c);
    // switch (c) {
    //   case 'I': {
    //     printf("Instruction fetch: %c %08x\n", c, n);
    //     break;
    //   }
    //   case 'D': {
    //     printf("Data fetch: %c %08x\n", c, n);
    //   }
    //   default: {
    //     printf("Unknown operation: %c %08x\n", c, n);
    //   }
    // }

  }
  fclose(fp);

  printf("%d hits, %d misses, %d addresses.\n\n\n", cache.hits, cache.misses, time);

  return 0;
}

