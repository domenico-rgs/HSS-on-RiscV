/*------------------------------------------------------------------------------
-------------------------------DEPENDENCIES-------------------------------------
------------------------------------------------------------------------------*/
#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include "cuda_runtime.h"

#define FLOAT

#ifdef DOUBLE
    typedef double datatype;
#endif
#ifdef FLOAT
    typedef float datatype;
#endif

//Constants
#define EPSILON 1e-8
#define THREADS 8

/*------------------------------------------------------------------------------
---------------------NEURAL NETOWRK ARCHITECTURE PARAMETERS---------------------
------------------------------------------------------------------------------*/

#define N_STATES 4 //Number of fundamental heart states
#define N_FEATURES 4 //Number of input features
#define N 64 //Window width in number of samples

#define K 3 //Size of the kernels

#define BASE_FILTER_SIZE 8 //Base filter size
#define NENC 4 //Number of encoding/decoding blocks


#define ENC_0_CONV_RELU_0_K K //Kernel size of the enc_0_conv_relu_0 layer
#define ENC_0_CONV_RELU_0_INPUT_FEATURES N_FEATURES //Number of input features of the enc_0_conv_relu_0 layer
#define ENC_0_CONV_RELU_0_OUTPUT_FEATURES BASE_FILTER_SIZE //Number of output features of the enc_0_conv_relu_0 layer
#define ENC_0_CONV_RELU_0_N N //Number of frames in the time dimension of the enc_0_conv_relu_0 layer

#define ENC_0_CONV_RELU_1_K K //Kernel size of the enc_0_conv_relu_1 layer
#define ENC_0_CONV_RELU_1_INPUT_FEATURES BASE_FILTER_SIZE //Number of input features of the enc_0_conv_relu_1 layer
#define ENC_0_CONV_RELU_1_OUTPUT_FEATURES BASE_FILTER_SIZE //Number of output features of the enc_0_conv_relu_1 layer
#define ENC_0_CONV_RELU_1_N N //Number of frames in the time dimension of the enc_0_conv_relu_1 layer

#define ENC_1_CONV_RELU_0_K K //Kernel size of the enc_1_conv_relu_0 layer
#define ENC_1_CONV_RELU_0_INPUT_FEATURES BASE_FILTER_SIZE*1 //Number of input features of the enc_1_conv_relu_0 layer
#define ENC_1_CONV_RELU_0_OUTPUT_FEATURES BASE_FILTER_SIZE*2 //Number of output features of the enc_1_conv_relu_0 layer
#define ENC_1_CONV_RELU_0_N N/2 //Number of frames in the time dimension of the enc_1_conv_relu_0 layer

#define ENC_1_CONV_RELU_1_K K //Kernel size of the enc_1_conv_relu_1 layer
#define ENC_1_CONV_RELU_1_INPUT_FEATURES BASE_FILTER_SIZE*2 //Number of input features of the enc_1_conv_relu_1 layer
#define ENC_1_CONV_RELU_1_OUTPUT_FEATURES BASE_FILTER_SIZE*2 //Number of output features of the enc_1_conv_relu_1 layer
#define ENC_1_CONV_RELU_1_N N/2 //Number of frames in the time dimension of the enc_1_conv_relu_1 layer

#define ENC_2_CONV_RELU_0_K K //Kernel size of the enc_2_conv_relu_0 layer
#define ENC_2_CONV_RELU_0_INPUT_FEATURES BASE_FILTER_SIZE*2 //Number of input features of the enc_2_conv_relu_0 layer
#define ENC_2_CONV_RELU_0_OUTPUT_FEATURES BASE_FILTER_SIZE*4 //Number of output features of the enc_2_conv_relu_0 layer
#define ENC_2_CONV_RELU_0_N N/4 //Number of frames in the time dimension of the enc_2_conv_relu_0 layer

#define ENC_2_CONV_RELU_1_K K //Kernel size of the enc_2_conv_relu_1 layer
#define ENC_2_CONV_RELU_1_INPUT_FEATURES BASE_FILTER_SIZE*4 //Number of input features of the enc_2_conv_relu_1 layer
#define ENC_2_CONV_RELU_1_OUTPUT_FEATURES BASE_FILTER_SIZE*4 //Number of output features of the enc_2_conv_relu_1 layer
#define ENC_2_CONV_RELU_1_N N/4 //Number of frames in the time dimension of the enc_2_conv_relu_1 layer

#define ENC_3_CONV_RELU_0_K K //Kernel size of the enc_3_conv_relu_0 layer
#define ENC_3_CONV_RELU_0_INPUT_FEATURES BASE_FILTER_SIZE*4 //Number of input features of the enc_3_conv_relu_0 layer
#define ENC_3_CONV_RELU_0_OUTPUT_FEATURES BASE_FILTER_SIZE*8 //Number of output features of the enc_3_conv_relu_0 layer
#define ENC_3_CONV_RELU_0_N N/8 //Number of frames in the time dimension of the enc_3_conv_relu_0 layer

#define ENC_3_CONV_RELU_1_K K //Kernel size of the enc_3_conv_relu_1 layer
#define ENC_3_CONV_RELU_1_INPUT_FEATURES BASE_FILTER_SIZE*8 //Number of input features of the enc_3_conv_relu_1 layer
#define ENC_3_CONV_RELU_1_OUTPUT_FEATURES BASE_FILTER_SIZE*8 //Number of output features of the enc_3_conv_relu_1 layer
#define ENC_3_CONV_RELU_1_N N/8 //Number of frames in the time dimension of the enc_3_conv_relu_1 layer

#define CENTRAL_CONV_RELU_0_K K //Kernel size of the central_conv_relu_0 layer
#define CENTRAL_CONV_RELU_0_INPUT_FEATURES BASE_FILTER_SIZE*8 //Number of input features of the central_conv_relu_0 layer
#define CENTRAL_CONV_RELU_0_OUTPUT_FEATURES BASE_FILTER_SIZE*16 //Number of output features of the central_conv_relu_0 layer
#define CENTRAL_CONV_RELU_0_N N/16 //Number of frames in the time dimension of the central_conv_relu_0 layer

#define CENTRAL_CONV_RELU_1_K K //Kernel size of the central_conv_relu_1 layer
#define CENTRAL_CONV_RELU_1_INPUT_FEATURES BASE_FILTER_SIZE*16 //Number of input features of the central_conv_relu_1 layer
#define CENTRAL_CONV_RELU_1_OUTPUT_FEATURES BASE_FILTER_SIZE*16 //Number of output features of the central_conv_relu_1 layer
#define CENTRAL_CONV_RELU_1_N N/16 //Number of frames in the time dimension of the central_conv_relu_1 layer

#define DEC_0_UP_CONV_RELU_K K //Kernel size of the dec_0_conv_relu_0 layer
#define DEC_0_UP_CONV_RELU_INPUT_FEATURES BASE_FILTER_SIZE*16 //Number of input features of the dec_0_up_conv_relu layer
#define DEC_0_UP_CONV_RELU_OUTPUT_FEATURES BASE_FILTER_SIZE*8 //Number of output features of the dec_0_up_conv_relu layer
#define DEC_0_UP_CONV_RELU_N N/8 //Number of frames in the time dimension of the dec_0_up_conv_relu layer

#define DEC_0_CONV_RELU_0_K K //Kernel size of the dec_0_conv_relu_0 layer
#define DEC_0_CONV_RELU_0_INPUT_FEATURES BASE_FILTER_SIZE*16 //Number of input features of the dec_0_conv_relu_0 layer
#define DEC_0_CONV_RELU_0_OUTPUT_FEATURES BASE_FILTER_SIZE*8 //Number of output features of the dec_0_conv_relu_0 layer
#define DEC_0_CONV_RELU_0_N N/8 //Number of frames in the time dimension of the dec_0_conv_relu_0 layer

#define DEC_0_CONV_RELU_1_K K //Kernel size of the dec_0_conv_relu_1 layer
#define DEC_0_CONV_RELU_1_INPUT_FEATURES BASE_FILTER_SIZE*8 //Number of input features of the dec_0_conv_relu_1 layer
#define DEC_0_CONV_RELU_1_OUTPUT_FEATURES BASE_FILTER_SIZE*8 //Number of output features of the dec_0_conv_relu_1 layer
#define DEC_0_CONV_RELU_1_N N/8 //Number of frames in the time dimension of the dec_0_conv_relu_1 layer

#define DEC_1_UP_CONV_RELU_K K //Kernel size of the dec_1_conv_relu_0 layer
#define DEC_1_UP_CONV_RELU_INPUT_FEATURES BASE_FILTER_SIZE*8 //Number of input features of the dec_1_up_conv_relu layer
#define DEC_1_UP_CONV_RELU_OUTPUT_FEATURES BASE_FILTER_SIZE*4 //Number of output features of the dec_1_up_conv_relu layer
#define DEC_1_UP_CONV_RELU_N N/4 //Number of frames in the time dimension of the dec_1_up_conv_relu layer

#define DEC_1_CONV_RELU_0_K K //Kernel size of the dec_1_conv_relu_0 layer
#define DEC_1_CONV_RELU_0_INPUT_FEATURES BASE_FILTER_SIZE*8 //Number of input features of the dec_1_conv_relu_0 layer
#define DEC_1_CONV_RELU_0_OUTPUT_FEATURES BASE_FILTER_SIZE*4 //Number of output features of the dec_1_conv_relu_0 layer
#define DEC_1_CONV_RELU_0_N N/4 //Number of frames in the time dimension of the dec_1_conv_relu_0 layer

#define DEC_1_CONV_RELU_1_K K //Kernel size of the dec_1_conv_relu_1 layer
#define DEC_1_CONV_RELU_1_INPUT_FEATURES BASE_FILTER_SIZE*4 //Number of input features of the dec_1_conv_relu_1 layer
#define DEC_1_CONV_RELU_1_OUTPUT_FEATURES BASE_FILTER_SIZE*4 //Number of output features of the dec_1_conv_relu_1 layer
#define DEC_1_CONV_RELU_1_N N/4 //Number of frames in the time dimension of the dec_1_conv_relu_1 layer

#define DEC_2_UP_CONV_RELU_K K //Kernel size of the dec_2_conv_relu_0 layer
#define DEC_2_UP_CONV_RELU_INPUT_FEATURES BASE_FILTER_SIZE*4 //Number of input features of the dec_2_up_conv_relu layer
#define DEC_2_UP_CONV_RELU_OUTPUT_FEATURES BASE_FILTER_SIZE*2 //Number of output features of the dec_2_up_conv_relu layer
#define DEC_2_UP_CONV_RELU_N N/2 //Number of frames in the time dimension of the dec_2_up_conv_relu layer

#define DEC_2_CONV_RELU_0_K K //Kernel size of the dec_2_conv_relu_0 layer
#define DEC_2_CONV_RELU_0_INPUT_FEATURES BASE_FILTER_SIZE*4 //Number of input features of the dec_2_conv_relu_0 layer
#define DEC_2_CONV_RELU_0_OUTPUT_FEATURES BASE_FILTER_SIZE*2 //Number of output features of the dec_2_conv_relu_0 layer
#define DEC_2_CONV_RELU_0_N N/2 //Number of frames in the time dimension of the dec_2_conv_relu_0 layer

#define DEC_2_CONV_RELU_1_K K //Kernel size of the dec_2_conv_relu_1 layer
#define DEC_2_CONV_RELU_1_INPUT_FEATURES BASE_FILTER_SIZE*2 //Number of input features of the dec_2_conv_relu_1 layer
#define DEC_2_CONV_RELU_1_OUTPUT_FEATURES BASE_FILTER_SIZE*2 //Number of output features of the dec_2_conv_relu_1 layer
#define DEC_2_CONV_RELU_1_N N/2 //Number of frames in the time dimension of the dec_2_conv_relu_1 layer

#define DEC_3_UP_CONV_RELU_K K //Kernel size of the dec_3_conv_relu_0 layer
#define DEC_3_UP_CONV_RELU_INPUT_FEATURES BASE_FILTER_SIZE*2 //Number of input features of the dec_3_up_conv_relu layer
#define DEC_3_UP_CONV_RELU_OUTPUT_FEATURES BASE_FILTER_SIZE*1 //Number of output features of the dec_3_up_conv_relu layer
#define DEC_3_UP_CONV_RELU_N N/1 //Number of frames in the time dimension of the dec_3_up_conv_relu layer

#define DEC_3_CONV_RELU_0_K K //Kernel size of the dec_3_conv_relu_0 layer
#define DEC_3_CONV_RELU_0_INPUT_FEATURES BASE_FILTER_SIZE*2 //Number of input features of the dec_3_conv_relu_0 layer
#define DEC_3_CONV_RELU_0_OUTPUT_FEATURES BASE_FILTER_SIZE*1 //Number of output features of the dec_3_conv_relu_0 layer
#define DEC_3_CONV_RELU_0_N N/1 //Number of frames in the time dimension of the dec_3_conv_relu_0 layer

#define DEC_3_CONV_RELU_1_K K //Kernel size of the dec_3_conv_relu_1 layer
#define DEC_3_CONV_RELU_1_INPUT_FEATURES BASE_FILTER_SIZE*1 //Number of input features of the dec_3_conv_relu_1 layer
#define DEC_3_CONV_RELU_1_OUTPUT_FEATURES BASE_FILTER_SIZE*1 //Number of output features of the dec_3_conv_relu_1 layer
#define DEC_3_CONV_RELU_1_N N/1 //Number of frames in the time dimension of the dec_3_conv_relu_1 layer

#define FINAL_CONV_K K //Kernel size of the final_conv layer
#define FINAL_CONV_INPUT_FEATURES BASE_FILTER_SIZE //Number of input features of the final_conv layer
#define FINAL_CONV_OUTPUT_FEATURES N_STATES //Number of output features of the final_conv layer
#define FINAL_CONV_N N //Number of frames in the time dimension of the final_conv layer

void Segmenter(datatype *d_x,
               datatype *d_enc_0_conv_relu_0_w, datatype *d_enc_0_conv_relu_1_w, datatype *d_enc_1_conv_relu_0_w,
               datatype *d_enc_1_conv_relu_1_w, datatype *d_enc_2_conv_relu_0_w, datatype *d_enc_2_conv_relu_1_w,
               datatype *d_enc_3_conv_relu_0_w, datatype *d_enc_3_conv_relu_1_w, datatype *d_central_conv_relu_0_w,
               datatype *d_central_conv_relu_1_w, datatype *d_dec_0_up_conv_relu_w, datatype *d_dec_0_conv_relu_0_w,
               datatype *d_dec_0_conv_relu_1_w, datatype *d_dec_1_up_conv_relu_w, datatype *d_dec_1_conv_relu_0_w,
               datatype *d_dec_1_conv_relu_1_w, datatype *d_dec_2_up_conv_relu_w, datatype *d_dec_2_conv_relu_0_w, 
               datatype *d_dec_2_conv_relu_1_w, datatype *d_dec_3_up_conv_relu_w, datatype *d_dec_3_conv_relu_0_w,
               datatype *d_dec_3_conv_relu_1_w, datatype *d_final_conv_w, datatype *y);