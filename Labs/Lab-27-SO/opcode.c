//  gcc -no-pie -c -o add.o add.c
//  gcc -no-pie -o opcode opcode.c

#include <stdlib.h>

#include <stdio.h>

#include <string.h>

#include <unistd.h>

#include <sys/mman.h>

typedef int (*IntFunc)(int x);

void *build_exec(void *code, size_t size);

// Instruções da função (código de máquina)

unsigned char code[] = {

    0xf3, 0x0f, 0x1e, 0xfa,
    0x55,
    0x48, 0x89, 0xe5,
    0x89, 0x7d, 0xfc,
    0x8b, 0x45, 0xfc,
    0x83, 0xc0, 0x01,
    0x5d,
    0xc3

};

int main() {

    // Copia as instruções para região executável

    unsigned char *exec = build_exec(code, sizeof(code));

    // f é um ponteiro para o código da função add()

    IntFunc f = (IntFunc)exec;

    int resp = f(41);

    printf("%d\n", resp);

    return 0;
}

// Copia o código para uma área de memória executável para o código

void *build_exec(void *src, size_t size) {

    // Pede ao SO uma área de memória para código executável

    void *dst = mmap(NULL,

                     getpagesize(),

                     PROT_EXEC | PROT_READ | PROT_WRITE,

                     MAP_PRIVATE | MAP_ANONYMOUS,

                     -1, 0);

    if (dst == MAP_FAILED)

    {

        printf("[ERRO] Não foi possível alocar memória executável\n");

        exit(1);
    }

    // Copia o código binário para a área executável

    memcpy(dst, src, size);
}