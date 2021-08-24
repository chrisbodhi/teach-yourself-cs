/* Ex. 1.15 Rewrite the temperature conversion program from Section 1.2 as a function */

#include <stdio.h>
#include <stdlib.h>

float fahr_to_celsius(float fahr);

int main(int argc, char *argv[]) {
  if (argc < 2) {
    printf("please supply a temp in F to convert\n");
    return 1;
  }
  float fahr = atof(argv[1]);
  float celsius = fahr_to_celsius(fahr);
  printf("You supplied %.2f in F, which is %.2f in C.\n", fahr, celsius);
  return 0;
}

float fahr_to_celsius(float fahr) {
  return (5.0 / 9.0) * (fahr - 32.0);
}
