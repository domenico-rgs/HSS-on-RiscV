#include "functions.h"

/*
 Returns the smallest of a and b. If both are equivalent, a is returned.
*/
int min(int a, int b) {
  int min = a;

  if (a > b) {
    min = b;
  }

  return min;
}

/*
 Returns the largest of a and b. If both are equivalent, a is returned.
*/
int max(int a, int b) {
  int max = a;

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
float ReLU(float x) {
  if (x < 0) {
    return 0;
  } else {
    return x;
  }
}

/*
Softmax implementation
  Args:
    x - Input array to perform softmax
    y - Array to save the softmax resultant values
*/
void Softmax(float *x, float *y) {
  float expx[N_STATES];
  float expsum = 0;

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
void Argmax(float *x, float *y) {
  float maxvalue = __FLT_MIN__;
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

void conv_relu(int conv_relu_output_features, int conv_relu_n, int conv_relu_k, int conv_relu_input_features, float *weights, float *input, float *output){
  float acc;
  int l_min, l_max;

  for (int k = 0; k < conv_relu_output_features; k++) { // Iterate over the number of filters
    for (int i = 0; i < conv_relu_n; i++) { // Iterate over the input matrix
      acc = 0;                                // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - conv_relu_k / 2);
      l_max = min(conv_relu_n, i + conv_relu_k / 2 + 1);

      for (int l = l_min; l < l_max; l++) {
        for (int j = 0; j < conv_relu_input_features; j++) {
          acc += input[l*conv_relu_input_features+j] * weights[(l - i + conv_relu_k / 2)*conv_relu_input_features*conv_relu_output_features+j*conv_relu_output_features+k]; // Multiply the input and the weight
        }
      }

      output[i*conv_relu_output_features+k] = ReLU(acc); // Save the accumulator value
    }
  }
}

void maxpooling(int enc_conv_relu_output_features, int enc_conv_relu_n, float *maxpool_output, float *input_from_conv_rel){
  for (int k = 0; k < enc_conv_relu_output_features; k++) { // Iterate over the number of filters
    for (int i = 0; i < enc_conv_relu_n / 2; i++) { // Iterate over the input matrix
      maxpool_output[i*enc_conv_relu_output_features+k] = max(input_from_conv_rel[(2 * i)*enc_conv_relu_output_features+k], input_from_conv_rel[(2 * i + 1)*enc_conv_relu_output_features+k]);
    }
  }
}

void upsampling(int dec_up_conv_relu_input_features, int dec_up_conv_relu_n, float *dec_upsample, float *conv_relu_input){
  for (int k = 0; k < dec_up_conv_relu_input_features; k++) { // Iterate over the number of filters
    for (int i = 0; i < dec_up_conv_relu_n / 2; i++) { // Iterate over the input matrix
      dec_upsample[(2 * i)*dec_up_conv_relu_input_features+k] = conv_relu_input[i*dec_up_conv_relu_input_features+k];
      dec_upsample[(2 * i + 1)*dec_up_conv_relu_input_features+k] = conv_relu_input[i*dec_up_conv_relu_input_features+k];
    }
  }
}

void concatenation(int dec_up_conv_relu_output_features, int dec_up_conv_relu_n, float *dec_concatenate, float *enc_conv_relu, float *dec_up_conv_relu){
  for (int k = 0; k < dec_up_conv_relu_output_features; k++) { // Iterate over the number of filters
    for (int i = 0; i < dec_up_conv_relu_n; i++) { // Iterate over the input matrix
      dec_concatenate[i*dec_up_conv_relu_output_features+k] = enc_conv_relu[i*dec_up_conv_relu_output_features+k];
      dec_concatenate[i*dec_up_conv_relu_output_features+(k + dec_up_conv_relu_output_features)] = dec_up_conv_relu[i*dec_up_conv_relu_output_features+k];
    }
  }
}