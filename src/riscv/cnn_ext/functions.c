#include "functions.h"

/*
Argmax implementation
  Args:
    x - Input array to perform argmax
    y - Array to save the argmax resultant values
*/
void Argmax(int16_t x[N_STATES], int16_t y[N_STATES]) {
  int16_t maxvalue = INT16_MIN;
  int maxindex = 0;

  for (int i = 0; i < N_STATES; i++) {
    if (x[i] > maxvalue) {
      maxvalue = x[i];
      maxindex = i;
    }
  }

  for (int i = 0; i < N_STATES; i++) {
    if (i == maxindex) {
      y[i] = 1; //no need for quantization, we only need to know if it's 1 or 0 (read as it is)
    } else {
      y[i] = 0;
    }
  }
}

/*
Softmax implementation - CAN'T BE USED IF F EXTENSION IN RISC-V IS NOT AVAILABLE
  Args:
    x - Input array to perform softmax
    y - Array to save the softmax resultant values
*/
/*void Softmax(float x[N_STATES], float y[N_STATES]) {
  float expx[N_STATES];
  float expsum = 0;

  for (int i = 0; i < N_STATES; i++) {
    //#ifdef FLOAT
    expx[i] = expf((int32_t)x[i]/((float)(1<<10))); //dequantization before exp
    //#endif
    //#ifdef DOUBLE
    //expx[i] = exp(x[i]);
    //#endif 
    expsum += expx[i];
  }

  // To prevent division by zero errors, add EPSILON if expsum is zero
  if (expsum == 0) {
    expsum = EPSILON;
  }

  for (int i = 0; i < N_STATES; i++) {
    y[i] = expx[i] / expsum;
  }
}
*/

void check_over(int32_t val, int layer){
    if(val>INT16_MAX || val<INT16_MIN){
        printf("Overflow at layer %d\n",layer);
    }
}