#include "functions.h"

void check_over(int32_t val, int layer){
    if(val>INT16_MAX || val<INT16_MIN){
        printf("Overflow at layer %d\n",layer);
    }
}