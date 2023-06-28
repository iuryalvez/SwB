#include <stdio.h>

#include <math.h>

#include <limits.h>

#define getsig(x) ((x) >> 31 & 1)

#define getexp(x) ((x) >> 23 & 0xff)

#define getfrac(x) ((x)&0x7fffff)

#define makefloat(s, e, f) ((s & 1) << 31 | (((e)&0xff) << 23) | ((f)&0x7fffff))

typedef union
{

    float f;

    unsigned int i;

} U;

int float2int(float value)
{

    U u;
    u.f = value;

    unsigned int s = getsig(u.i);
    unsigned int e = getexp(u.i);
    unsigned int f = getfrac(u.i);

    int valor;

    if (e == 0 && f == 0) return 0;
    
    // encontrando a mantissa
    f = f | (1 << 23);

    // expoente sem notação de excesso
    e -= 127;


    if (e < 31) {
        if (e < 23) valor = f >> (23 - e); 
        else if (e == 23) valor = f;
        else valor = f << (e - 23);
        valor = pow(-1,s) * valor;
    } 

    return valor;
}

int main()
{

    float f;

    printf("\n******** float2int ****************\n");

    f = 0.0;

    printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

    f = -0.0;

    printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

    f = 1.0;

    printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

    f = -1.0;

    printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

    f = 12345.0;

    printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

    f = -12345.0;

    printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

    f = 1.5;

    printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

    f = 2.5;

    printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

    f = 2.4;

    printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

    f = -2.4;

    printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

    f = 0.5;

    printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

    f = -0.5;

    printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

    f = (float)pow(2, 31);

    printf(" %+10.4f (2^31) = overflow -> %d %d\n", f, (int)f, float2int(f));

    f = -f;

    printf(" %+10.4f (-2^31) -> %d %d\n", f, (int)f, float2int(f));

    f = -((float)pow(2, 32));

    printf(" %+10.4f (-2^32 = overflow) -> %d %d\n", f, (int)f, float2int(f));

    return 0;
}
