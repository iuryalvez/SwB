struct X
{
    char a;

    long b;

    int c;
};

// tamanho: múltiplo de 8
// inicial: múltiplo de 8
// a_______ bbbbbbbb cccc____ = 24 bytes
// p: 7              p: 4

union Y
{
    unsigned int a;

    char b[26];

    short c[4];
};

// alinhamento? 4 bytes
// campos? não há pq é union
// tamanho? 26 bytes + alinhamento se necessário -> 26+2 = 28 bytes

union S
{
    int a[4]; // 16 bytes

    union Y y; // 30 bytes

    struct X x; // 24 bytes
};

// alinhamento: 8 bytes
// campos? não tem
// tamanho: 28 + alinhamento se necessário -> 28+4 = 32 que é múltiplo de 8 bytes
