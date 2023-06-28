// Programa que converte string para números com bases acima de 10.

#include <stdio.h>
#include <ctype.h>

int string2num(char *s, int base)
{

    int a = 0;

    for (; *s; s++) {
        if (isdigit(*s) != 0) a = a * base + (*s - '0'); // se for dígito faz normal para a base 
        else if (isalpha(*s) != 0 && *s < 97) a = a * base + (*s - 'A' + 10);
        else a = a * base + (*s - 'a' + 10);
    }

    return a;
}

int main()
{
    printf("O numero escolhido na base escolhida vale: %d\n", string2num("1A", 10));
    
    printf("O numero escolhido na base escolhida vale: %d\n", string2num("20", 8));

    return 0;
}
