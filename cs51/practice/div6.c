#include <stdlib.h>
#include <stdio.h>

int ret = 0;



void
notBCD()
{
  ret = 3;
  exit(1);
}

void
isBCD(int x)
{
  if (x > 9) {
    notBCD();
  }
  else {
    return;
  }
}

void 
notDIV2()
{
  ret = 1;
  exit(-1);
}

void 
notDIV3()
{
  ret = 2;
  exit(-1);
}

void 
isDIV2(int x)
{
  if (x % 2 == 0) {
    return;
  }
  else {
    notDIV2();
  }
}

void 
isDIV3(int x)
{
  if (x % 3 == 0) {
    return;
  }
  else {
    notDIV3();
  }
}

int
main()
{
  int num[] = {1, 2, 7, 5};

  for (int i = 0; i < 4; i++) {
    isBCD(num[i]);
    isDIV2(num[i]);
    isDIV3(num[i]);
  }
  return 0;
}