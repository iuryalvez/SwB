#include <stdio.h>

struct S
{
    int a;

    short b[2][2];

    long c;
};

union U
{
    char r[20];

    struct S s;

    int t[4];
};

union U var;

int main()
{
    char *ptr = (char *)&var.s.b; // acessa o endereço 4 de var que é o início da matriz de short

    var.r[3] = 0xFF; // acessa o endereço 3 de var e preenche com 0xFF

    var.s.b[0][0] = 0x6548; // acessa o endereço 4 de var e preenche com 0x6548 (que é short = 2 bytes)

    // printf("var.r[3]: %x\n", var.r[3]);

    // printf("var.r[4]: %x\n", var.r[4]);

    var.s.b[0][1] = 0x6C6C; // acessa o endereço 6 de var e preenche com 0x6c6c (que é short = 2 bytes)

    var.t[2] = 0xFFFF216F; // acessa o endereço 12 de var e preenche com 0xFFFF216F

    ptr = ptr + (1 * 2 * sizeof(short)) + (1 * sizeof(short)); // ptr + 4 + 2 -> ptr + 6, 

    *ptr = 0; // acessa o endereço 10 de var e preenche com 0

    ptr = ptr - 6; // volta o ptr para o endereço 4

    var.s.a = var.s.a >> 24; // shifta 3 bytes para direita, zera os 3 últimos bytes e some com os primeiros 3

    // printf("var.r[3]: %x\n", var.r[3]);
    
    // printf("var.r[4]: %x\n", var.r[4]);
    
    printf("ptr = %s\n", ptr); 

    printf("a = %X\n", var.s.a);

    return 0;
}
