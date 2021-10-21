/**
 * @file swap.c
 * @author siavava <amittaijoel@outlook.com>
 * @brief 
 * @version 0.1
 * @date 2021-10-21
 * 
 * @copyright Copyright (c) 2021
 * 
 */

#include <stdio.h>
#include <stdlib.h>

void inplace_swap(int* x, int* y);
void reverse_array(int a[], int cnt);

int 
main(int argc, char** argv)
{
  int x = 1;
  int y = 5;
  printf("x = %d, y = %d\n", x, y);
  inplace_swap(&x, &y);
  printf("x = %d, y = %d\n", x, y);

  int arr[] = {1, 2, 3, 4, 5};
  int len = sizeof(arr) / sizeof(int);

  for (int i = 0; i < len; i++) printf("%d ", arr[i]);
  printf("\n");

  reverse_array(arr, len);

  for (int i = 0; i < len; i++) printf("%d ", arr[i]);
  printf("\n");

  return 0;
}

void 
inplace_swap(int* x, int* y)
{
  *y = *x ^ *y;
  *x = *x ^ *y;
  *y = *x ^ *y;
  return;
}

void
reverse_array(int a[], int cnt)
{
  int first = 0;
  int last = cnt - 1;
  while (first < last) {
    inplace_swap(&a[first], &a[last]);
    first++; last--;
  }
  return;
}