#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include <stdlib.h>

#define FXP 16 //fixed point precision 16 -> 32

int16_t quantize(float a, int fxp){
	int32_t maxVal = ((1 << (FXP-1)) - 1);
	int32_t value = roundf(a * (1 << fxp)); //mapping + rounding
	//int32_t value = a * (1 << fxp); //mapping without rounding

	//clipping
	if(value > maxVal){
		return (int16_t)maxVal;
	}else if(value < -maxVal-1){
		return (int16_t)(-maxVal-1);
	}else{
		return (int16_t)value;
	}
}

float dequantize(int32_t val, int fxp){
	return val/((float)(1<<fxp));
}

int main(int argc, char** argv){
    int16_t res_q = quantize(atof(argv[1]), 12); //12
    float res_d = dequantize(atoi(argv[1]), 12);
    printf("0x%x\n", res_q);
    printf("%d\n", res_q);
    printf("%.16f\n", res_d);

    return 0;
}