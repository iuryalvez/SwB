// struct X
// {
//     int m; // offset: +0 bytes do início

//     int n; // +4 bytes do início

//     long p; // +8 bytes do início
// };

#include <stdio.h>

struct S {
    long a;
    char b;
    int c;
    short d;
};

// void offsets(struct S *ptr)
// {

//     int cont = 0;
    
//     printf("Offset de a: +0 bytes\n");
    
//     while ((sizeof(ptr->a)+cont) % sizeof(ptr->b) != 0) {
//         cont++;
//     }
//     printf("Offset de b: +%d bytes\n", sizeof(ptr->a)+cont);
//     cont = 0;

//     while ((sizeof(ptr->a)+sizeof(ptr->b)+cont) % sizeof(ptr->c) != 0) {
//         cont++;
//     }
//     printf("Offset de c: +%d bytes\n", sizeof(ptr->a)+sizeof(ptr->b)+cont);
//     cont = 0;

//     while ((sizeof(ptr->a)+sizeof(ptr->b)+sizeof(ptr->c)+cont) % sizeof(ptr->d) != 0) {
//         cont++;
//     }
//     printf("Offset de d: +%d bytes\n", sizeof(ptr->a)+sizeof(ptr->b)+sizeof(ptr->c)+cont);
//     cont = 0;
// }

void offsets(struct S *ptr) {
    unsigned long inicio;

    inicio = (unsigned long) ptr;

    printf("Offset de a: %lu\n", (unsigned long) (&ptr->a) - inicio);
    printf("Offset de b: %lu\n", (unsigned long) (&ptr->b) - inicio);
    printf("Offset de c: %lu\n", (unsigned long) (&ptr->c) - inicio);
    printf("Offset de d: %lu\n", (unsigned long) (&ptr->d)- inicio);
}

//----------------------------------------------

// Cria a variável varS

struct S varS;

int main()
{

    offsets(&varS);

    return 0;
}