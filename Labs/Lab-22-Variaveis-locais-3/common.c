#include <stdlib.h>

#include <stdio.h>

#include <string.h>

#include "common.h"

guid_t g1 = {0x752f3136, 0x4e16, 0x4fdc, {0xa2, 0x2a, 0xe5, 0xf4, 0x68, 0x12, 0xf4, 0xca}};

guid_t g2 = {0xbc62157e, 0x3e33, 0x4fec, {0x99, 0x20, 0x2d, 0x3b, 0x36, 0xd7, 0x50, 0xdf}};

void init_obj(rfid_object_t *obj, int base) {

    guid_t *id = (base % 2) ? &g1 : &g2;

    memcpy(&obj->id, id, sizeof(guid_t));

    obj->pin = base % 3;

    obj->enabled = 1;
}

void init_pins(short pins[2][3]) {

    for (int i = 0; i < 2; i++)
        for (int j = 0; j < 3; j++)
            pins[i][j] = (i + j) % 3;
}

int main() {

    if (find(&g1))

        printf("Pin encontrado\n");

    else

        printf("Pin não encontrado\n");
}