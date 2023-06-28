#include <stdio.h>

int main()
{
    // 1 byte com representação 1111 1111
    signed char sc = -1;

    // conversão ficaria 1111 1111 1111 1111 ...
    unsigned int ui = sc;

    printf("0x%08X\n", ui); 
    // 0xFFFFFFFF -> o compilador repete o valor do sinal pelos 3 primeiros bytes e no final mantém o original, não há tratamento de negativo para positivo
    // é uma extensão de representação
    // se printasse 0x000000FF seria truncamento de representação

    // extensão: mais confiável
    // truncamento: menos confiável

    printf("%d\n", ui);
    // como raios printou negativo o.O

    return 0;
}