#ifndef AUX_H

#define AUX_H

// alinhado para 8
// 4 + 4p + 8 + 16 = 32
struct Object {

    int type;

    long ID;

    char name[16];
};

// alinhado para 8
// 4 + 4p + 8 + 16 + 4 = 36+4p = 40
struct Person { 

    int type; // 4

    long ID; // 8

    char name[16]; // 16

    int age; // 4
};

// alinhado para 8
// 4 + 4p + 8 + 16 + 8 = 40
struct Car {

    int type;

    long ID;

    char name[16];

    char color[8];
};

void readPerson(struct Person *ptr, int *id);

void readCar(struct Car *ptr, int *id);

#endif