#include <stdio.h>

struct X
{
    int a; // 4 bytes

    short b; // 2 bytes

    int c; // 4 bytes
};

//               |  a   |   b  |  c   | 
//       campos: | xxxx | xx__ | xxxx | -> alinhamento da struct

struct X varx = {0xA1A2A3A4, 0xB1B2, 0xC1C2C3C4};

void dump(void *p, int n)
{

    unsigned char *p1 = p;

    while (n--)
    {

        printf("%p - 0x%02X\n", p1, *p1); // vai printar 0xB2 B1 00 00 -> começa do primeiro byte e é little endian

        p1++;
    }
}

int main()
{

    dump(&varx, sizeof(varx));

    return 0;
}