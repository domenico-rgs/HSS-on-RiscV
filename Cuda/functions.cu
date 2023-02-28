#include "functions.cuh"

/*
Softmax implementation
  Args:
    x - Input array to perform softmax
    y - Array to save the softmax resultant values
*/
__global__ void Softmax(float *x, float *y) {
	int index = blockIdx.x*blockDim.x+threadIdx.x;

  float expx[N_STATES];
  float expsum = 0;

  for (int i = 0; i < N_STATES; i++) {
    expx[i] = exp(x[index+i]);
    expsum += expx[i];
  }

  // To prevent division by zero errors, add EPSILON if expsum is zero
  if (expsum == 0) {
    expsum = EPSILON;
  }

  for (int i = 0; i < N_STATES; i++) {
    y[index+i] = expx[i] / expsum;
  }
}

/*
Argmax implementation
  Args:
    x - Input array to perform argmax
    y - Array to save the argmax resultant values
*/
__global__ void Argmax(float *x, float *y) {
	int index = blockIdx.x*blockDim.x+threadIdx.x;

  float maxvalue = __FLT_MIN__;
  int maxindex = 0;

  for (int i = 0; i < N_STATES; i++) {
    if (x[index+i] > maxvalue) {
      maxvalue = x[index+i];
      maxindex = i;
    }
  }

  for (int i = 0; i < N_STATES; i++) {
    if (i == maxindex) {
      y[index+i] = 1;
    } else {
      y[index+i] = 0;
    }
  }
}

__host__ void checkCudaError(int line) {
	cudaError err = cudaGetLastError();
	if (err != cudaSuccess) {
		printf("cuda error: %s. Line: %d\n", cudaGetErrorString(err), line);
		exit(-1);
	}
}

__global__ void conv_relu(int conv_relu_output_features, int conv_relu_n, int conv_relu_k, int conv_relu_input_features, float *d_weights, float *d_input, float *d_output){
  int k = blockIdx.y*blockDim.y+threadIdx.y;
	int i = blockIdx.x*blockDim.x+threadIdx.x;

  float acc = 0;
  int l_min, l_max;

  if((k<conv_relu_output_features)&&(i<conv_relu_n)){
    // Calculate the auxiliary positions respect to the input
    l_min = max(0, i - conv_relu_k / 2);
    l_max = min(conv_relu_n, i + conv_relu_k / 2 + 1);

    for (int l = l_min; l < l_max; l++) {
      for (int j = 0; j < conv_relu_input_features; j++) {
        acc += d_input[l*conv_relu_input_features+j] * d_weights[k*conv_relu_k*conv_relu_input_features+(l-i+conv_relu_k/2)*conv_relu_input_features+j]; // Multiply the input and the weight
      }
    }
    d_output[i*conv_relu_output_features+k] = ReLU(acc); // Save the accumulator value
  }
}

__global__ void maxpooling(int enc_conv_relu_output_features, int enc_conv_relu_n, float *d_maxpool_output, float *d_input_from_conv_rel){
  int k = blockIdx.y*blockDim.y+threadIdx.y;
	int i = blockIdx.x*blockDim.x+threadIdx.x;

  if((k<enc_conv_relu_output_features)&&(i<enc_conv_relu_n / 2)){
    d_maxpool_output[i*enc_conv_relu_output_features+k] = max(d_input_from_conv_rel[(2 * i)*enc_conv_relu_output_features+k], d_input_from_conv_rel[(2 * i + 1)*enc_conv_relu_output_features+k]);
  }
}

__global__ void upsampling(int dec_up_conv_relu_input_features, int dec_up_conv_relu_n, float *d_dec_upsample, float *d_conv_relu_input){
  int k = blockIdx.y*blockDim.y+threadIdx.y;
	int i = blockIdx.x*blockDim.x+threadIdx.x;

  if((k<dec_up_conv_relu_input_features)&&(i<dec_up_conv_relu_n / 2)){
    d_dec_upsample[(2 * i)*dec_up_conv_relu_input_features+k] = d_conv_relu_input[i*dec_up_conv_relu_input_features+k];
    d_dec_upsample[(2 * i + 1)*dec_up_conv_relu_input_features+k] = d_conv_relu_input[i*dec_up_conv_relu_input_features+k];
  }
}

__global__ void concatenation(int dec_up_conv_relu_output_features, int dec_up_conv_relu_n, float *d_dec_concatenate, float *d_enc_conv_relu, float *d_dec_up_conv_relu){
  int k = blockIdx.y*blockDim.y+threadIdx.y;
	int i = blockIdx.x*blockDim.x+threadIdx.x;

  if((k<dec_up_conv_relu_output_features)&&(i<dec_up_conv_relu_n)){
    d_dec_concatenate[i*dec_up_conv_relu_output_features+k] = d_enc_conv_relu[i*dec_up_conv_relu_output_features+k];
    d_dec_concatenate[i*dec_up_conv_relu_output_features+(k + dec_up_conv_relu_output_features)] = d_dec_up_conv_relu[i*dec_up_conv_relu_output_features+k];
  }
}