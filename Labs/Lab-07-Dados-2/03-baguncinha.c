#include <stdio.h>

struct X
{
    int a;

    short b;

    int c;
};

// Cria a variável x e inicializa os campos da estrutura

struct X x = {
    .a = 2048,

    .b = 17,

    .c = 0xBebaCafe
};

int main()
{
    char *pChar;

    short *pShort;

    printf("x.a = %d\n", x.a);

    printf("x.b = %d\n", x.b);

    printf("x.c = %x\n", x.c);

    printf("---\n");

    pChar = (char *)&x;

    pChar = pChar + 4;

    *pChar = *pChar | 0x20; // 0010 0000 |
    //                         0001 0001
    //                         0011 0001 -> 31 que é 49 em decimal

    printf("x.a = %d\n", x.a);

    printf("x.b = %d\n", x.b);

    printf("x.c = %x\n", x.c);

    printf("x.b-padding = %x\n", pShort[3]);

    printf("---\n");

    pShort = (short *)&x;

    pShort[3] = 0xbaca; // 0x800 -> 1000 0000 0000 0000 no primeiro int
                       // 0xFFFF -> 1000 0000 0000 0000 0011 0001 1111 1111 bebacafe
             // dentro da struct -> aaaa aaaa aaaa aaaa bbbb bbbb ____ ____ cccc cccc ... cccc
                                    // cai exatamente no padding ->

    printf("x.a = %d\n", x.a);

    printf("x.b = %d\n", x.b);

    printf("x.b-padding = %x\n", pShort[3]);

    printf("x.c = %x\n", x.c);

    return 0;
}