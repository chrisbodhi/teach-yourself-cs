/* Exercise 1-12. Write a program that prints its input one word per line. */

#include <stdio.h> // EOF is defined here
#include <string.h>

int main() {
  int c;

  while ((c = getchar()) != EOF) {
    if (c == ' ' || c == '\t') {
      putchar('\n');
    } else {
      putchar(c);
    }
  }
  return 0;
}
