#include <stdlib.h>

#include <stdio.h>

#include <string.h>

#include <unistd.h>

#include <sys/mman.h>

typedef int (*FuncPtr)(int x);

void *build_exec(void *code, size_t size);

// Instruções da função (código de máquina)

unsigned char code[] = {
    
    0x55,       
    0x48, 0x89, 0xe5, 
    0x89, 0x7d, 0xfc, 
    0x8b, 0x45, 0xfc, 
    0x83, 0xc0, 0x02, 
    0x5d,       
    0xc3,

    0x55,                      
    0x48, 0x89, 0xe5,                
    0x89, 0x7d, 0xfc,                
    0x8b, 0x45, 0xfc,                
    0x01, 0xc0,                   
    0x5d,                      
    0xc3,

    0x55,                        
    0x48, 0x89, 0xe5,                  
    0x48, 0x83, 0xec, 0x10,               
    0x89, 0x7d, 0xfc,                  
    0x8b, 0x45, 0xfc,                  
    0x89, 0xc7,                    
    0xe8, 0x00, 0x00, 0x00, 0x00,            
    0xc9,                      
    0xc3

};

int main() {

    int i;

    FuncPtr f;

    unsigned char *exec = build_exec(code, sizeof(code));

    //---------------------------------------

    // Alterar "process" para chamar a função "sum"

    // Seu código aqui...

    //---------------------------------------

    // Chama a função "process"

    // f = (FuncPtr)&exec[??];

    // i = f(40);

    // printf("%d\n", i);

    //---------------------------------------

    // Alterar "process" para chamar a função "mul"

    // Seu código aqui...

    //---------------------------------------

    // Chama a função "process"

    // f = (FuncPtr)&exec[??];

    // i = f(40);

    // printf("%d\n", i);

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