#include <stdio.h>

unsigned int convertB2L(unsigned int x)
{
    // escreva seu código aqui
    unsigned int a = 0x000000FF;
    unsigned int b = 0x0000FF00;
    unsigned int c = 0x00FF0000;
    unsigned int d = 0xFF000000;
    
    a = a << 24;
    b = b << 8;
    c = c >> 8;
    d = d >> 24;

    return a | b | c | d;
}

int main()
{

    unsigned int b = 0x12AB34CD;

    unsigned int l = convertB2L(b);

    printf("b = 0x%08X\n", b);

    printf("l = 0x%08X\n", l);

    return 0;
}