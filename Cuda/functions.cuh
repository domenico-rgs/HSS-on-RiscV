#include "segmenter.cuh"
#include "float.h"

__global__ void conv_relu(int conv_relu_output_features, int conv_relu_n, int conv_relu_k, int conv_relu_input_features, float *d_weights, float *d_input, float *d_output);
__global__ void conv_relu_last_layer(int conv_relu_output_features, int conv_relu_n, int conv_relu_k, int conv_relu_input_features, float *d_weights, float *d_input, float *d_output);
__global__ void maxpooling(int enc_conv_relu_output_features, int enc_conv_relu_n, float *d_maxpool_output, float *d_input_from_conv_rel);
__global__ void upsampling(int dec_up_conv_relu_input_features, int dec_up_conv_relu_n, int dim_conv_relu_input, float *d_dec_upsample, float *d_conv_relu_input);
__global__ void concatenation(int dec_up_conv_relu_output_features, int dec_up_conv_relu_n, float *d_dec_concatenate, float *d_enc_conv_relu, float *d_dec_up_conv_relu);

__host__ void checkCudaError(int line);

__global__ void Argmax(float *x, float *y);
__global__ void Softmax(float *x, float *y);