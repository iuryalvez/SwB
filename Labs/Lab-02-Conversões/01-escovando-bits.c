// Programa que mostra os bits de um byte em hexadecimal.

#include <stdio.h>

void dump(void *addr, int n)
{

    unsigned char *p = (unsigned char *)addr;
    int i = 1;

    while (n--)
    {

        printf("%iº byte:", i);
        printf("%p - %02x\n", p, *p);

        i++;
        p++;
    }
}

// int main() {

//   char p[] = "7509";

//   dump(p, sizeof(p));

//   return 0;

// }

int main()
{

    char i = 12;

    dump(&i, sizeof(i));

    return 0;
}
