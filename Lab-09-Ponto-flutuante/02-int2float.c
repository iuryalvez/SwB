#include <stdio.h>
typedef union {
 float f;
 unsigned int i;
} U;
#define makefloat(s,e,f) ((s & 1)<<31 | (((e) & 0xff) << 23) | ((f) & 0x7fffff))
#define getsig(x) ((x)>>31 & 1)
#define getexp(x) ((x)>>23 & 0xff)
#define getfrac(x) ((x) & 0x7fffff)
float int2float(int i)
{
 U u;
 unsigned int s = 0;
 unsigned int e = 0;
 unsigned int f = 0;
 // Zero tem notação especial
 if (i == 0) {
 u.i = makefloat(0, 0, 0);
 return u.f;
 }

 // Se for negativo, salva o sinal transforma número inteiro em positivo
 if (i < 0) {
 i = -i;
 s = 1;
 }

 // Procura o bit ‘1’ mais à direita, atualizando o expoente (normalização)
 e = 31;
 unsigned int mask = 0x80000000;
 for (int k = 31; k >= 0; k++) {
 if (i & mask)
 break;
 mask = mask >> 1;
 e--;
 }

 // Faz ajuste na mantissa para 23 bits (se necessário)
 if (e < 23)
 f = i << (23 - e);
 else if (e == 23)
 f = i;
 else if (e > 23)
 f = i >> (e - 23);
 // Notação de excesso no expoente
 e = e + 127;
 // Cria e retorna o float
 u.i = makefloat(s, e, f);
 return u.f;
}
int main() {
 int i;
 printf("\n******** int2float ****************\n");
 i = 0;
 printf(" %d -> %+10.4f, %+10.4f\n", i, (float)i, int2float(i));
 i = 1;
 printf(" %d -> %+10.4f, %+10.4f\n", i, (float)i, int2float(i));
 i = -1;
 printf(" %d -> %+10.4f, %+10.4f\n", i, (float)i, int2float(i));
 i = 12345;
 printf(" %d -> %+10.4f, %+10.4f\n", i, (float)i, int2float(i));
 i = -12345;
 printf(" %d -> %+10.4f, %+10.4f\n", i, (float)i, int2float(i));
 i = 13631488;
 printf(" %d -> %+10.4f, %+10.4f\n", i, (float)i, int2float(i));
 i = 1879048192;
 printf(" %d -> %+10.4f, %+10.4f\n", i, (float)i, int2float(i));
 i = 0x7fffffff;
 printf(" %d -> %+10.4f, %+10.4f\n", i, (float)i, int2float(i));
 i = -i;
 printf(" %d -> %+10.4f, %+10.4f\n", i, (float)i, int2float(i));
 return 0;
}
