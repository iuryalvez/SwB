#include <stdio.h>

union Y // 12 bytes
{
    int a; // 4 bytes

    short b; // 2 bytes

    char c; // 1 byte
};

union Y vary;

void dump(void *p, int n)
{
    unsigned char *p1 = p;

    while (n--)
    {
        printf("%p - 0x%02X\n", p1, *p1);

        p1++;
    }
}

int main()
{
    vary.a = 0xA1A2A3A4;

    printf("vary.a: \n"); // A4 A3 A2 A1

    dump(&vary, sizeof(vary));

    printf("---\n");

    vary.b = 0xB1B2; // B2 B1 A2 A1

    printf("vary.b: \n");

    dump(&vary, sizeof(vary));

    printf("---\n");
 
    vary.c = 0xC1; // C1 B1 A2 A1

    printf("vary.c: \n");

    dump(&vary, sizeof(vary));

    return 0;
}
