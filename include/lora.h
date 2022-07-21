#include <stdio.h>
#include <stdlib.h>
#include <rc/uart.h>
#include <rc/time.h>

#define UART2 2 //uart2
#define BAUD96 9600
#define TIMEOUT 1 //1SEC
#define CAN_EN 0 //canonical mode enable
#define SB 1 //stop bits
#define PAR 0 //parity

#define MAX_PAYLOAD_LENGTH 528 //512 characters maximum
#define SKEY_MSG_LEN 52

#define SUCCESS 0
#define ERROR -1

enum error_codes {
    TX_ERROR = 1,
    LENGTH_MISMATCH,
    RX_ERROR,
    RESPONSE_ERROR
};


// int Grove_Init(int bus, int baud, int timeout, int stop_bits, int parity);

// int ATModule_Init();
int ATModule_SerialTransmit(int bus, const char *data);
int ATModule_SerialReceive(int bus, uint8_t buf[]);

int ATModule_TestConnection(int bus);
int ATModule_GetVersion(int bus);

int ATModule_SetNwkSKey(int bus, uint8_t *key);
int ATModule_SetAppSKey(int bus, uint8_t *key);