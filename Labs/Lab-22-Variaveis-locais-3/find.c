#include <stdio.h>

#include "common.h"

rfid_object_t gObj;

int find(guid_t *id) {

    int found = 0;

    rfid_object_t lObj;

    short pins[2][3];

    init_obj(&gObj, 0);

    init_obj(&lObj, 1);

    init_pins(pins);

    if (compare_guid(&lObj.id, id))

        printf("Objeto local igual!\n");

    if (compare_guid(id, &gObj.id))

        printf("Objeto global igual!\n");

    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            if (pins[i][j] == lObj.pin) {

                found = 1;

                goto saida;
            }
        }
    }

saida:

    return found;
}