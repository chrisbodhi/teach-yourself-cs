/* Ex 1.9: Write a program to copy its input to its output, replacing each string of one or more blanks by a single blank. */
#include <stdio.h>

int main(void) {
  int c, spacecount;

  spacecount = 0;

  while ((c = getchar()) != EOF) {
    if (c == ' ') {
      ++spacecount;
    } else {
      if (spacecount > 0) {
        /* Not great with leading spaces */
        printf(" ");
        putchar(c);
        spacecount = 0;
      } else {
        putchar(c);
      }
    }
  }

  return 0;
}
