#ifndef COMMON_H

#define COMMON_H

// 4 + 2 + 2 + 8 = 16 bytes
struct guid_s {

    unsigned int part1; // 4 bytes

    unsigned short part2; // 2 bytes

    unsigned short part3; // 2 bytes

    unsigned char part4[8]; // 8 bytes
};

typedef struct guid_s guid_t;

// 1 + 3p + 16 + 2 +2p = 24 bytes
struct rfid_object_s {

    char enabled; // 1 byte 

    guid_t id; // 16 bytes (alinhado p 4)

    short pin; // 2 bytes
};

typedef struct rfid_object_s rfid_object_t;

void init_obj(rfid_object_t *obj, int base);

void init_pins(short pins[2][3]);

int compare_guid(guid_t *id1, guid_t *id2);

int find(guid_t *id);

#endif