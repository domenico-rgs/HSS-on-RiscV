#include "functions.cuh"

/*
Softmax implementation
  Args:
    x - Input array to perform softmax
    y - Array to save the softmax resultant values
*/
__global__ void Softmax(datatype *x, datatype *y) {
	int index = blockIdx.x*blockDim.x+threadIdx.x; //0*64+0...63

  datatype expx[N_STATES];
  datatype expsum = 0;

  for (int i = 0; i < N_STATES; i++) {
    expx[i] = exp((x+index*N_STATES)[i]);
    expsum += expx[i];
  }

  // To prevent division by zero errors, add EPSILON if expsum is zero
  if (expsum == 0) {
    expsum = EPSILON;
  }

  for (int i = 0; i < N_STATES; i++) {
    (y+index*N_STATES)[i] = expx[i] / expsum;
  }
}

/*
Argmax implementation
  Args:
    x - Input array to perform argmax
    y - Array to save the argmax resultant values
*/
__global__ void Argmax(datatype *x, datatype *y) {
	int index = blockIdx.x*blockDim.x+threadIdx.x;
  #ifdef FLOAT
  datatype maxvalue = FLT_MIN;
  #endif
  #ifdef DOUBLE
  datatype maxvalue = DBL_MIN;
  #endif 
  int maxindex = 0;

  for (int i = 0; i < N_STATES; i++) {
    if ((x+index*N_STATES)[i] > maxvalue) {
      maxvalue = (x+index*N_STATES)[i];
      maxindex = i;
    }
  }

  for (int i = 0; i < N_STATES; i++) {
    if (i == maxindex) {
      (y+index*N_STATES)[i] = 1;
    } else {
      (y+index*N_STATES)[i] = 0;
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

__global__ void conv_relu(int conv_relu_output_features, int conv_relu_n, int conv_relu_k, int conv_relu_input_features, datatype *d_weights, datatype *d_input, datatype *d_output){
	int i = blockIdx.x*blockDim.x+threadIdx.x;
  int k = blockIdx.y*blockDim.y+threadIdx.y;
  
  if((k<conv_relu_output_features)&&(i<conv_relu_n)){
    datatype acc = 0;
    int l_min, l_max;

    // Calculate the auxiliary positions respect to the input
    l_min = 0 > (i - conv_relu_k / 2) ? 0 : (i - conv_relu_k / 2); //max
    l_max = (conv_relu_n) < (i + conv_relu_k / 2 + 1) ? (conv_relu_n) : (i + conv_relu_k / 2 + 1); //min

    for (int l = l_min; l < l_max; l++) {
      for (int j = 0; j < conv_relu_input_features; j++) {
        acc += d_input[l*conv_relu_input_features+j] * d_weights[k*conv_relu_k*conv_relu_input_features+(l-i+conv_relu_k/2)*conv_relu_input_features+j]; // Multiply the input and the weight

      }
    }
    d_output[i*conv_relu_output_features+k] = acc < 0 ? 0 : acc; // Relu
  }
}

__global__ void conv_relu_last_layer(int conv_relu_output_features, int conv_relu_n, int conv_relu_k, int conv_relu_input_features, datatype *d_weights, datatype *d_input, datatype *d_output){
	int i = blockIdx.x*blockDim.x+threadIdx.x;
  int k = blockIdx.y*blockDim.y+threadIdx.y;

  if((k<conv_relu_output_features)&&(i<conv_relu_n)){
    datatype acc = 0;
    int l_min, l_max;

    // Calculate the auxiliary positions respect to the input
    l_min = 0 > (i - conv_relu_k / 2) ? 0 : (i - conv_relu_k / 2); //max
    l_max = (conv_relu_n) < (i + conv_relu_k / 2 + 1) ? (conv_relu_n) : (i + conv_relu_k / 2 + 1); //min

    for (int l = l_min; l < l_max; l++) {
      for (int j = 0; j < conv_relu_input_features; j++) {
        acc += d_input[l*conv_relu_input_features+j] * d_weights[k*conv_relu_k*conv_relu_input_features+(l-i+conv_relu_k/2)*conv_relu_input_features+j]; // Multiply the input and the weight
      }
    }
    d_output[i*conv_relu_output_features+k] = acc;
  }
}

__global__ void maxpooling(int enc_conv_relu_output_features, int enc_conv_relu_n, datatype *d_maxpool_output, datatype *d_input_from_conv_rel){
  int k = blockIdx.x*blockDim.x+threadIdx.x;
  int i = blockIdx.y*blockDim.y+threadIdx.y;
  
  if((k<enc_conv_relu_output_features)&&(i<enc_conv_relu_n / 2)){
    d_maxpool_output[i*enc_conv_relu_output_features+k] = d_input_from_conv_rel[(2 * i)*enc_conv_relu_output_features+k] > d_input_from_conv_rel[(2 * i + 1)*enc_conv_relu_output_features+k] ? d_input_from_conv_rel[(2 * i)*enc_conv_relu_output_features+k] : d_input_from_conv_rel[(2 * i + 1)*enc_conv_relu_output_features+k]; //max
    
  }
}

__global__ void upsampling(int dec_up_conv_relu_input_features, int dec_up_conv_relu_n, int dim_conv_relu_input, datatype *d_dec_upsample, datatype *d_conv_relu_input){
  int k = blockIdx.x*blockDim.x+threadIdx.x;
  int i = blockIdx.y*blockDim.y+threadIdx.y;

  if((k<dec_up_conv_relu_input_features)&&(i<(dec_up_conv_relu_n / 2))){
    d_dec_upsample[(2 * i)*dec_up_conv_relu_input_features+k] = d_conv_relu_input[i*dim_conv_relu_input+k];
    d_dec_upsample[(2 * i + 1)*dec_up_conv_relu_input_features+k] = d_conv_relu_input[i*dim_conv_relu_input+k];
  }
}

__global__ void concatenation(int dec_up_conv_relu_output_features, int dec_up_conv_relu_n, datatype *d_dec_concatenate, datatype *d_enc_conv_relu, datatype *d_dec_up_conv_relu){
  int k = blockIdx.x*blockDim.x+threadIdx.x;
  int i = blockIdx.y*blockDim.y+threadIdx.y;

  if((k<dec_up_conv_relu_output_features)&&(i<dec_up_conv_relu_n)){
    d_dec_concatenate[i*dec_up_conv_relu_output_features*2+k] = d_enc_conv_relu[i*dec_up_conv_relu_output_features+k];
    d_dec_concatenate[i*dec_up_conv_relu_output_features*2+(k + dec_up_conv_relu_output_features)] = d_dec_up_conv_relu[i*dec_up_conv_relu_output_features+k];
  }
}