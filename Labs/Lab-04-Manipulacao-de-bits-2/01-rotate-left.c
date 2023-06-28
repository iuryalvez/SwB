#include <stdio.h>

unsigned char rotate_left(unsigned char x, int n);

int main()
{
    unsigned char x = 0x61;
    x = rotate_left(x,1);
    printf("O novo byte eh igual a 0x%08x\n", x);
    return 0;
}

unsigned char rotate_left(unsigned char x, int n)
{

    unsigned char p_bit;
    while (n--) {
        
        p_bit =  x & 0x80;
        p_bit = p_bit >> 7;

        x = x << 1;
        x = x | p_bit;

    }

    return x;

}
