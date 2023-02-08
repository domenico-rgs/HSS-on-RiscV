#include "segmenter.h"

int min(int a, int b);
int max(int a, int b);

void conv_relu(int conv_relu_output_features, int conv_relu_n, int conv_relu_k, int conv_relu_input_features, float *weights, float *input, float *output);
void maxpooling(int enc_conv_relu_output_features, int enc_conv_relu_n, float *maxpool_output, float *input_from_conv_rel);
void upsampling(int dec_up_conv_relu_input_features, int dec_up_conv_relu_n, float *dec_upsample, float *conv_relu_input);
void concatenation(int dec_up_conv_relu_output_features, int dec_up_conv_relu_n, float *dec_concatenate, float *enc_conv_relu, float *dec_up_conv_relu);

void Argmax(float *x, float *y);
void Softmax(float *x, float *y);
float ReLU(float x);