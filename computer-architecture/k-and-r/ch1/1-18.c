/* Ex 1.18: Remove trailing blanks and tabs from each line of input, and delete blank lines */

#include <stdio.h>
#define MAXLINE 1000

int cb_getline(char line[], int maxline);
void cb_trim(char line[], int len);

int main() {
  int i;
  char c;
  char line[1000];

  i = 0;

  while((c = getchar()) != EOF) {
    line[i] = c;
    ++i;
  }

  printf("%s\n", line);

  return 0;
}

int cb_getline(char s[], int lim) {
  int c, i;

  for (i = 0; i < lim - 1 && (c = getchar()) != EOF && c != '\n'; ++i) {
    s[i] = c;
  }

  if (c == '\n') {
    s[i] = c;
    ++i;
  }
  s[i] = '\0';
  return i;
}

void cb_trim(char line[], int len) {
  int c, i;

  for(i = len; i > 0; --i) {
    c = line[i];
    if (c == '\t' || c == ' ') {
      line[i] = ''; // TODO copy instead?
    }
  }
}
