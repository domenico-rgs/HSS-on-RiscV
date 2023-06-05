/* -----------------------------DEPENDENCIES------------------------------------*/
#include <math.h> 
#include <stdio.h>
#include <stdint.h>
#include <airisc.h>

//Constants
#define EPSILON 1e-8
#define FXP 14

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

void Segmenter(int16_t x[N_FEATURES*N],
               int16_t enc_0_conv_relu_0_w[ENC_0_CONV_RELU_0_K*ENC_0_CONV_RELU_0_INPUT_FEATURES*ENC_0_CONV_RELU_0_OUTPUT_FEATURES],
               int16_t enc_0_conv_relu_1_w[ENC_0_CONV_RELU_1_K*ENC_0_CONV_RELU_1_INPUT_FEATURES*ENC_0_CONV_RELU_1_OUTPUT_FEATURES],
               int16_t enc_1_conv_relu_0_w[ENC_1_CONV_RELU_0_K*ENC_1_CONV_RELU_0_INPUT_FEATURES*ENC_1_CONV_RELU_0_OUTPUT_FEATURES],
               int16_t enc_1_conv_relu_1_w[ENC_1_CONV_RELU_1_K*ENC_1_CONV_RELU_1_INPUT_FEATURES*ENC_1_CONV_RELU_1_OUTPUT_FEATURES],
               int16_t enc_2_conv_relu_0_w[ENC_2_CONV_RELU_0_K*ENC_2_CONV_RELU_0_INPUT_FEATURES*ENC_2_CONV_RELU_0_OUTPUT_FEATURES],
               int16_t enc_2_conv_relu_1_w[ENC_2_CONV_RELU_1_K*ENC_2_CONV_RELU_1_INPUT_FEATURES*ENC_2_CONV_RELU_1_OUTPUT_FEATURES],
               int16_t enc_3_conv_relu_0_w[ENC_3_CONV_RELU_0_K*ENC_3_CONV_RELU_0_INPUT_FEATURES*ENC_3_CONV_RELU_0_OUTPUT_FEATURES],
               int16_t enc_3_conv_relu_1_w[ENC_3_CONV_RELU_1_K*ENC_3_CONV_RELU_1_INPUT_FEATURES*ENC_3_CONV_RELU_1_OUTPUT_FEATURES],
               int16_t central_conv_relu_0_w[CENTRAL_CONV_RELU_0_K*CENTRAL_CONV_RELU_0_INPUT_FEATURES*CENTRAL_CONV_RELU_0_OUTPUT_FEATURES],
               int16_t central_conv_relu_1_w[CENTRAL_CONV_RELU_1_K*CENTRAL_CONV_RELU_1_INPUT_FEATURES*CENTRAL_CONV_RELU_1_OUTPUT_FEATURES],
               int16_t dec_0_up_conv_relu_w[DEC_0_UP_CONV_RELU_K*DEC_0_UP_CONV_RELU_INPUT_FEATURES*DEC_0_UP_CONV_RELU_OUTPUT_FEATURES],
               int16_t dec_0_conv_relu_0_w[DEC_0_CONV_RELU_0_K*DEC_0_CONV_RELU_0_INPUT_FEATURES*DEC_0_CONV_RELU_0_OUTPUT_FEATURES],
               int16_t dec_0_conv_relu_1_w[DEC_0_CONV_RELU_1_K*DEC_0_CONV_RELU_1_INPUT_FEATURES*DEC_0_CONV_RELU_1_OUTPUT_FEATURES],
               int16_t dec_1_up_conv_relu_w[DEC_1_UP_CONV_RELU_K*DEC_1_UP_CONV_RELU_INPUT_FEATURES*DEC_1_UP_CONV_RELU_OUTPUT_FEATURES],
               int16_t dec_1_conv_relu_0_w[DEC_1_CONV_RELU_0_K*DEC_1_CONV_RELU_0_INPUT_FEATURES*DEC_1_CONV_RELU_0_OUTPUT_FEATURES],
               int16_t dec_1_conv_relu_1_w[DEC_1_CONV_RELU_1_K*DEC_1_CONV_RELU_1_INPUT_FEATURES*DEC_1_CONV_RELU_1_OUTPUT_FEATURES],
               int16_t dec_2_up_conv_relu_w[DEC_2_UP_CONV_RELU_K*DEC_2_UP_CONV_RELU_INPUT_FEATURES*DEC_2_UP_CONV_RELU_OUTPUT_FEATURES],
               int16_t dec_2_conv_relu_0_w[DEC_2_CONV_RELU_0_K*DEC_2_CONV_RELU_0_INPUT_FEATURES*DEC_2_CONV_RELU_0_OUTPUT_FEATURES],
               int16_t dec_2_conv_relu_1_w[DEC_2_CONV_RELU_1_K*DEC_2_CONV_RELU_1_INPUT_FEATURES*DEC_2_CONV_RELU_1_OUTPUT_FEATURES],
               int16_t dec_3_up_conv_relu_w[DEC_3_UP_CONV_RELU_K*DEC_3_UP_CONV_RELU_INPUT_FEATURES*DEC_3_UP_CONV_RELU_OUTPUT_FEATURES],
               int16_t dec_3_conv_relu_0_w[DEC_3_CONV_RELU_0_K*DEC_3_CONV_RELU_0_INPUT_FEATURES*DEC_3_CONV_RELU_0_OUTPUT_FEATURES],
               int16_t dec_3_conv_relu_1_w[DEC_3_CONV_RELU_1_K*DEC_3_CONV_RELU_1_INPUT_FEATURES*DEC_3_CONV_RELU_1_OUTPUT_FEATURES],
               int16_t final_conv_w[FINAL_CONV_K*FINAL_CONV_INPUT_FEATURES*FINAL_CONV_OUTPUT_FEATURES],
               int16_t y[N][N_STATES]);