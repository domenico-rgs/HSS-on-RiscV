#include "functions.h"

/*
Softmax implementation
  Args:
    x - Input array to perform softmax
    y - Array to save the softmax resultant values
*/
void Softmax(datatype x[N_STATES], datatype y[N_STATES]) {
  datatype expx[N_STATES];
  datatype expsum = 0;

  for (int i = 0; i < N_STATES; i++) {
    #ifdef FLOAT
    expx[i] = expf(x[i]);
    #endif
    #ifdef DOUBLE
    expx[i] = exp(x[i]);
    #endif 
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
  #ifdef FLOAT
  datatype maxvalue = __FLT_MIN__;
  #endif
  #ifdef DOUBLE
  datatype maxvalue = __DBL_MIN__;
  #endif  
  int maxindex = 0;

  for (int i = 0; i < N_STATES; i++) {
    if (x[i] > maxvalue) {
      maxvalue = x[i];
      maxindex = i;
    }
  }

  for (int i = 0; i < N_STATES; i++) {
    if (i == maxindex) {
      y[i] = 1;
    } else {
      y[i] = 0;
    }
  }
}