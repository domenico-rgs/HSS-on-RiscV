#include "functions.h"

/*
Softmax implementation - CAN'T BE USE IF WE NOT USE F EXTENSION IN RISC-V
  Args:
    x - Input array to perform softmax
    y - Array to save the softmax resultant values
*/
void Softmax(datatype x[N_STATES], float y[N_STATES]) {
  float expx[N_STATES];
  float expsum = 0;

  for (int i = 0; i < N_STATES; i++) {
    //#ifdef FLOAT
    expx[i] = expf((int32_t)x[i]/((float)(1<<10)));
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

/*
Argmax implementation
  Args:
    x - Input array to perform argmax
    y - Array to save the argmax resultant values
*/
void Argmax(datatype x[N_STATES], datatype y[N_STATES]) {
  datatype maxvalue = INT16_MIN;
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