#include <stdio.h>

int odd_ones(unsigned int x)
{
    // escreva seu código aqui
    int cont = 0;

    while (x) {
        if (x & 0x01) cont++;
        x = x >> 1;
    }
    
    return cont & 1;
}

int main()
{

    unsigned int v;

    v = 0x01010101;

    printf("%X tem número %s de bits\n", v, odd_ones(v) ? "impar" : "par");

    v = 0x01030101;

    printf("%X tem número %s de bits\n", v, odd_ones(v) ? "impar" : "par");

    return 0;
}