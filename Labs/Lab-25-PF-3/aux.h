#ifndef AUX_H

#define AUX_H

// alinhamento: 1 + 7p + 8 + 4 = 22
struct Temperatura {
    char scale; // 1 

    double value; // 8

    int repeated; // 4
};

// 4 + 4 = 8
struct Data {

    float sum; // 4

    int fail; // 4
};

#endif