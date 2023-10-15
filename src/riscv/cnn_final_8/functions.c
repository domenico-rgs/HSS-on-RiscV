#include "functions.h"

void check_over(int16_t val, int layer){
    if(val>INT8_MAX || val<INT8_MIN){
        printf("Overflow at layer %d\n",layer);
    }
}