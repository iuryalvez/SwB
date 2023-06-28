#include <stdio.h>

int prog1() {
    unsigned int x = 0xffffffff;

    unsigned int y = 2;

    printf("x = %u, y = %u\n", x, y);

    printf("x é menor do que y? %s\n", (x < y) ? "sim" : "não");

    return 0;
}

int prog2() {
    int x = 0xffffffff;

    int y = 2;

    printf("x = %d, y = %d\n", x, y);

    printf("x é menor do que y? %s\n", (x < y) ? "sim" : "não");

    return 0;
}

int prog3() {
    int x = 0xffffffff;

    unsigned int y = 2;

    printf("x = %d, y = %u\n", x, y);

    printf("x é menor do que y? %s\n", (x < y) ? "sim" : "não");

    return 0;
}

int main(void)
{
 
    prog1();
    prog2();
    prog3();
    
}