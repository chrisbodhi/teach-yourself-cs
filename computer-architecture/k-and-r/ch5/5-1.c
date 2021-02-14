#include <stdio.h>
#include <ctype.h>

#define BUFSIZE 100


int getch(void);
void ungetch(int);
int getint(int *pn);

char buf[BUFSIZE];
int bufp = 0;

int getch(void) {
  return (bufp > 0) ? buf[--bufp] : getchar();
}

void ungetch(int c) {
  if (bufp >= BUFSIZE) {
    printf("ungetch: too many characters\n");
  } else {
    buf[bufp++] = c;
  }
}

int getint(int *pn) {
  int c, sign;

    while (isspace(c = getch()))
      ;

    if (!isdigit(c) && c != EOF && c != '+' && c != '-') {
      ungetch(c); /* not a number */
      return 0;
    }

    sign = (c == '-') ? -1 : 1;
    if (c == '+' || c == '-') {
      c = getch();
    }
    for (*pn = 0; isdigit(c); c = getch()) {
      *pn = 10 * *pn + (c - '0');
    }
    *pn *= sign;
    if (c != EOF) {
      ungetch(c);
    }
    return c;
}

int main(void) {
  int i = 4;
  int n = getint(&i);

  printf("n is %d\n", n);

  return 0;
}
