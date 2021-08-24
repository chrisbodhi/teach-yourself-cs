/* Ex. 1-13 Write a program to print a histogram of the lengths of words in it input. */
#include <stdio.h>

// antidisestablishmentarianism
// 28 characters long
#define MAX 28

void fill_xs(char* arr, int count) {
  int i = 0;
  for (i = 0; i < count; i++) {
    arr[i] = 'X';
  };
  arr[count] = '\0';
}

int main() {
  int c, i, i_word;
  int counts[MAX];
  char xs[MAX];

  i_word = 0;

  // Init the counts
  for (i = 1; i <= MAX; i++) {
    counts[i] = 0;
  }

  while((c = getchar()) != EOF) {
    if (c == '\n' || c == '\t') {
      counts[i_word]++;
      i_word = 0;
    }
    if (c != ' ') {
      i_word++; // count how long the current word is
    } else { // done counting the word
      counts[i_word]++;
      i_word = 0; // reset the count
    }
  }

  printf("chars | wc\n");
  for (i = 1; i <= MAX; i++) {
    if (counts[i] > 0) {
      fill_xs(xs, counts[i]);
      printf("%d | %s\n", i, xs);
    }
  }

  return 0;
}
