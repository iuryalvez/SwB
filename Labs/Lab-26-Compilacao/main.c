#include <stdio.h>

void fill_a(int *ptr);

int get_b();

int a = 0;

int main (void) {

  fill_a(&a);

  int b = get_b();

  printf("a = %d, b = %d\n", a, b);

  return 0;

}

// gcc -c -o aux.o aux.c
// gcc -c -o main.o main.c
// gcc -o prog main.o aux.o

// man nm
// nm aux.o 
// nm main.o

// objdump -d aux.o
// objdump -d main.o

// readelf -r main.o
// readelf -l prog
