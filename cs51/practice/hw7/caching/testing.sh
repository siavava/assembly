#!/usr/bin/env bash
#
# Tester for caching program.
#
# Usage: ./testing.sh

make verbose

rm -f ./*.out

echo -e "\nRunning simple tests...\n"
{
  echo -e "SAMPLE.TXT.\n\n"
  ./caching ./data/sample.txt 0
  ./caching ./data/sample.txt 1
  ./caching ./data/sample.txt 2
  ./caching ./data/sample.txt 3
} >> testing.out

make clean
make

echo -e "\nRunning long-trace tests"
{
echo -e "\n--------------------------------\n"
echo -e "LONG-TRACE.TXT\n\n"
./caching ./data/long-trace.txt 0
./caching ./data/long-trace.txt 1
./caching ./data/long-trace.txt 2
./caching ./data/long-trace.txt 3 
} >> testing.out

make clean
