# Dartmouth College

## COSC 051: Computer Architecture

### Homework 7 Report

#### Professor: Sean Smith

#### Student: Amittai Wekesa

##### Part A: Caching (50 points)

I decided to implement my solution in C++ because it's relatively faster than Python / Java 
and I do not have to worry about deep-level memory management.
I implemented and compiled my program using the `C++11` standard and tested with GNU's compiler, `g++`.
Either way, it shouldn't be an issue to compile on `clang`.

I implemented a program, in [caching.cpp](./caching/caching.cpp) 
that simulates a cache structure and, given a trace file and caching mode,
simulates caching with that mode.

I wrote a `Makefile` and a test program [testing.sh](./caching/testing.out) that runs the different tests provided in the Homework specification.

To test, run `make test`.

To simply build the brogram (maybe to test other trace files), simply run `make`.

Check out [testing.out](./caching/testing.out) for sample output.

**"Usage: ./caching \[trace file\] \[associativity\]"**

**NOTE: The associativity modes are:**

```text
0 -> direct mapping

1 -> 2-way associative

2 -> 4-way associative

3 -> Fully associative
```

\pagebreak

###### **Problem 1 (10 Points)**

My caching program was able to match the professor's output on [sample.txt](./caching/data/sample.txt):

```text
Direct Mapping
 1: addr 0x22222210; tag 222010; looking in set 33, miss! line 0 empty, adding there.
 2: addr 0x33333310; tag 333010; looking in set 49, miss! line 0 empty, adding there.
 3: addr 0x44444410; tag 444010; looking in set 1, miss! line 0 empty, adding there.
 4: addr 0x55555510; tag 555010; looking in set 17, miss! line 0 empty, adding there.
 5: addr 0x66666610; tag 666010; looking in set 33, miss! line 0 evicted, adding there.
 6: addr 0x22222210; tag 222010; looking in set 33, found it in line 1; hit!
 7: addr 0x33333310; tag 333010; looking in set 49, found it in line 1; hit!
 8: addr 0x8fe01030; tag e01030; looking in set 3, miss! line 0 empty, adding there.
 9: addr 0x8fe01031; tag e01031; looking in set 3, miss! line 0 evicted, adding there.
10: addr 0xbffff8fc; tag fff074; looking in set 15, miss! line 0 empty, adding there.
2 hits, 8 misses, 10 addresses.

Two-Way Associative Mapping
 1: addr 0x22222210; tag 222010; looking in set 1, miss! line 0 empty, adding there.
 2: addr 0x33333310; tag 333010; looking in set 17, miss! line 0 empty, adding there.
 3: addr 0x44444410; tag 444010; looking in set 1, miss! line 0 evicted, adding there.
 4: addr 0x55555510; tag 555010; looking in set 17, miss! line 0 evicted, adding there.
 5: addr 0x66666610; tag 666010; looking in set 1, miss! line 0 evicted, adding there.
 6: addr 0x22222210; tag 222010; looking in set 1, found it in line 2; hit!
 7: addr 0x33333310; tag 333010; looking in set 17, found it in line 2; hit!
 8: addr 0x8fe01030; tag e01030; looking in set 3, miss! line 0 empty, adding there.
 9: addr 0x8fe01031; tag e01031; looking in set 3, miss! line 1 evicted, adding there.
10: addr 0xbffff8fc; tag fff074; looking in set 15, miss! line 0 empty, adding there.
2 hits, 8 misses, 10 addresses.

Four-Way Associative Mapping
 1: addr 0x22222210; tag 222010; looking in set 1, miss! line 0 empty, adding there.
 2: addr 0x33333310; tag 333010; looking in set 1, miss! line 0 evicted, adding there.
 3: addr 0x44444410; tag 444010; looking in set 1, miss! line 0 evicted, adding there.
 4: addr 0x55555510; tag 555010; looking in set 1, miss! line 0 evicted, adding there.
 5: addr 0x66666610; tag 666010; looking in set 1, miss! line 0 evicted, adding there.
 6: addr 0x22222210; tag 222010; looking in set 1, found it in line 4; hit!
 7: addr 0x33333310; tag 333010; looking in set 1, miss! line 0 evicted, adding there.
 8: addr 0x8fe01030; tag e01030; looking in set 3, miss! line 0 empty, adding there.
 9: addr 0x8fe01031; tag e01031; looking in set 3, miss! line 1 evicted, adding there.
10: addr 0xbffff8fc; tag fff074; looking in set 15, miss! line 0 empty, adding there.
1 hits, 9 misses, 10 addresses.

Fully Associative Mapping
 1: addr 0x22222210; tag 222010; looking in set 0, miss! line 16 empty, adding there.
 2: addr 0x33333310; tag 333010; looking in set 0, miss! line 16 evicted, adding there.
 3: addr 0x44444410; tag 444010; looking in set 0, miss! line 16 evicted, adding there.
 4: addr 0x55555510; tag 555010; looking in set 0, miss! line 16 evicted, adding there.
 5: addr 0x66666610; tag 666010; looking in set 0, miss! line 16 evicted, adding there.
 6: addr 0x22222210; tag 222010; looking in set 0, found it in line 64; hit!
 7: addr 0x33333310; tag 333010; looking in set 0, miss! line 16 evicted, adding there.
 8: addr 0x8fe01030; tag e01030; looking in set 0, miss! line 48 evicted, adding there.
 9: addr 0x8fe01031; tag e01031; looking in set 0, miss! line 49 evicted, adding there.
10: addr 0xbffff8fc; tag fff074; looking in set 0, miss! line 52 evicted, adding there.
1 hits, 9 misses, 10 addresses.
```

\pagebreak

###### **Problem 2 (40 Points)**

**Is the conventional wisdom right for caching?**

Simulating on **[long-trace](./caching/data/long-trace.txt)**, I interestingly got the best performace on 
**directly mapped** caching and worse performance with increasing associativity.

**Fully associative** mapping turned out zero matches on long-trace. I think this is understandable because
-- with only a single working set, the only possible matches are when an address recurs within
64 (the number of lines in the set) fetches after it's initial occurrence. On the other hand, opportunistic hits
are more likely even more than 64 fetches after an address occurred because some other addresses
will be mapped to other sets in the cache.

```text

Direct Mapping
6026 hits, 6340052 misses, 6346078 addresses.

Two-Way Associative Mapping
5687 hits, 6340391 misses, 6346078 addresses.

Four-Way Associative Mapping
3629 hits, 6342449 misses, 6346078 addresses.

Fully Associative Mapping
0 hits, 6346078 misses, 6346078 addresses.
```

\pagebreak

##### Part B: OPLI (50 points)

Extend your Y86 to implement **OPLI** operations; *isubl*, *iaddl*, *iandl*, and *ixorl*.

###### **Revised FSM FLOW-CHART**

![FSM Flowchart](./opli/FSM-flowchart.pdf)

\pagebreak

Here is a link to my revised FSM Flowchart: [flowchart](https://docs.google.com/spreadsheets/d/1Y-jy17e7BDQuHTnzAOQJXc1KrbbA7WLCSsbRB1Qun6c/edit#gid=372062055)

![FSM matrix](./opli/FSM-matrix.pdf)

To test my operations, I wrote two programs: [decr.ys](./opli/decr.hex) and [incr.ys](./opli/decr.hex)
that manipulate ASCII by repeatedly `isubl`~ing and `iaddl`~ing with $0x01$ and printing the values to DDR.

The result is the ASCII representations being printed to the TTY.
