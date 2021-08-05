/* Write a pointer version of strcat; strcat(s, t) copies the string t to the end of s */

#include <stdio.h>

void strcatPoint(char *s, char *t) {
    printf("%s, %s", s, t);
}

int main() {
    char s[] = "string starts with s";
    char t[] = "t comes in second";

    strcatPoint(s, t);
    return 0;
}
