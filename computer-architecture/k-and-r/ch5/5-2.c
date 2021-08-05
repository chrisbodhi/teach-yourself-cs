#include <stdio.h>

float getfloat(float *ptr) {
    float n;
    n = *ptr;
    printf("ptr is %.1f\n", n);
    return 0.0;
}

int main(void) {
    float arr[2] = {4.3, 5.5};

    getfloat(&arr[0]);

    return 0;
}
