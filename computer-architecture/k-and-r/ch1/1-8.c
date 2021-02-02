/* Ex 1.8: Write a program to count the number of blanks, tabs, and newlines. */
#include <stdio.h>
	

int main(void) {
  int blanks, tabs, newlines;
  int c;

  blanks = tabs = newlines = 0;

  while ((c = getchar()) != EOF) {
    if (c == '\t') {
      ++tabs;
    }
    if (c == '\n') {
      ++newlines;
    }
    if (c == ' ') {
      ++blanks;
    }
    
  }
  printf("blanks: %d, tabs: %d, newlines: %d\n", blanks, tabs, newlines);

  return 0;
}
