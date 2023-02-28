#include "segmenter.cuh"

//Returns the largest of a and b. If both are equivalent, a is returned.
#define max(a,b)             \
({                           \
    __typeof__ (a) _a = (a); \
    __typeof__ (b) _b = (b); \
    _a > _b ? _a : _b;       \
})

//Returns the smallest of a and b. If both are equivalent, a is returned.
#define min(a,b)             \
({                           \
    __typeof__ (a) _a = (a); \
    __typeof__ (b) _b = (b); \
    _a < _b ? _a : _b;       \
})

/*
Rectified Linear Unit implementation.
  Args:
    x - Input value
  Returns:
    The ReLU output of x
*/
#define ReLU(x)             \
({                           \
    __typeof__ (x) _x = (x); \
    _x < 0 ? 0 : _x;       \
})

__global__ void conv_relu(int conv_relu_output_features, int conv_relu_n, int conv_relu_k, int conv_relu_input_features, float *d_weights, float *d_input, float *d_output);
__global__ void maxpooling(int enc_conv_relu_output_features, int enc_conv_relu_n, float *d_maxpool_output, float *d_input_from_conv_rel);
__global__ void upsampling(int dec_up_conv_relu_input_features, int dec_up_conv_relu_n, float *d_dec_upsample, float *d_conv_relu_input);
__global__ void concatenation(int dec_up_conv_relu_output_features, int dec_up_conv_relu_n, float *d_dec_concatenate, float *d_enc_conv_relu, float *d_dec_up_conv_relu);

__host__ void checkCudaError(int line);

__global__ void Argmax(float *x, float *y);
__global__ void Softmax(float *x, float *y);