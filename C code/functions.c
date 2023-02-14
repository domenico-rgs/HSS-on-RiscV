#include "functions.h"

/*
 Returns the smallest of a and b. If both are equivalent, a is returned.
*/
apfixed min(apfixed a, apfixed b) {
  apfixed min = a;

  if (a > b) {
    min = b;
  }

  return min;
}

/*
 Returns the largest of a and b. If both are equivalent, a is returned.
*/
apfixed max(apfixed a, apfixed b) {
  apfixed max = a;

  if (b > a) {
    max = b;
  }

  return max;
}

/*
Rectified Linear Unit implementation.
  Args:
    x - Input value
  Returns:
    The ReLU output of x
*/
apfixed ReLU(apfixed x) {
  if (x < 0) {
    return 0;
  }
    
  return x;
}

/*
Softmax implementation
  Args:
    x - Input array to perform softmax
    y - Array to save the softmax resultant values
*/
void Softmax(apfixed x[N_STATES], apfixed y[N_STATES]) {
  apfixed expx[N_STATES];
  apfixed expsum = 0;

  for (int i = 0; i < N_STATES; i++) {
    expx[i] = exp(x[i]);
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
void Argmax(apfixed x[N_STATES], apfixed y[N_STATES]) {
  apfixed maxvalue = __FLT_MIN__;
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