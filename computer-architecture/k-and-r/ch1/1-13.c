/* Ex. 1-13 Write a program to print a histogram of the lengths of words in it input. */
#include <stdio.h>

void fill_xs(char* arr, int count) {
  int i = 0;

  while(i < count) {
    arr[i] = 'X';
    i++;
  };
  arr[count] = '\0'; // set count to 5000; without this, on the first run, got '?B' at the end of the string, and junk on subsequent runs
}

int main() {
  int count = 5000;
  char xs[count];

  fill_xs(xs, count);
  printf("%s\n", xs);

  return 0;
}
