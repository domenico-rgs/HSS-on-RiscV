// Copyright (C) 2022 Daniel Enériz and Antonio Rodriguez-Almeida
// 
// This file is part of PCG Segmentation Model Implementation.
// 
// PCG Segmentation Model Implementation is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// PCG Segmentation Model Implementation is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with PCG Segmentation Model Implementation.  If not, see <http://www.gnu.org/licenses/>.

/*------------------------------------------------------------------------------
-------------------------------DEFINING DATA TYPE-------------------------------
------------------------------------------------------------------------------*/

// #define FIXED // FLOAT or FIXED
//#define FLOAT // FLOAT or FIXED

/*------------------------------------------------------------------------------
-------------------------------DEPENDENCIES-------------------------------------
------------------------------------------------------------------------------*/

#include <algorithm> //To use max() and min() (for 'same' padding method)
// // // #ifdef FIXED
// // //     #include "ap_fixed.h" //Fixed type support
// // //     #include "hls_math.h" //If fixed type is used
// // // #endif
// #ifdef FLOAT
//     #include <cmath> //If float type is used
// #endif

#define FLOAT

#ifdef DOUBLE
    typedef double datatype;
#endif
#ifdef FLOAT
    typedef float datatype;
#endif

#define PRECISION 18


/*------------------------------------------------------------------------------
-------------------------------TESTING METHOD PARAMETERS------------------------
------------------------------------------------------------------------------*/

#define TEST_SAMPLES_BATCH 250 //Number of samples in the test file, limited by the maximum allocable C++ array size
#define TEST_FILES 169 //Number of test files
#define TOTAL_SAMPLES 55293

/*------------------------------------------------------------------------------
---------------------NEURAL NETOWRK ARCHITECTURE PARAMETERS---------------------
------------------------------------------------------------------------------*/

#define N_STATES 4 //Number of fundamental heart states
#define N_FEATURES 4 //Number of input features
#define N 64 //Window width in number of samples

#define K 3 //Size of the kernels

#define BASE_FILTER_SIZE 8 //Base filter size


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

/*------------------------------------------------------------------------------
-----------------------------NEURAL NETWORK DATATYPES---------------------------
------------------------------------------------------------------------------*/
// #ifdef FIXED
//     typedef ap_fixed<16,8,AP_RND,AP_SAT> apfixed;
//     typedef int apint;
//     typedef ap_uint<18> apuint;
// #endif
// #ifdef FLOAT
//     typedef float apfixed;
//     typedef int apint;
//     typedef int apuint;
// #endif


// using namespace std;

// void Segmenter(float x[N][N_FEATURES],
//                float enc_0_conv_relu_0_w[ENC_0_CONV_RELU_0_K][ENC_0_CONV_RELU_0_INPUT_FEATURES][ENC_0_CONV_RELU_0_OUTPUT_FEATURES],
//                float enc_0_conv_relu_1_w[ENC_0_CONV_RELU_1_K][ENC_0_CONV_RELU_1_INPUT_FEATURES][ENC_0_CONV_RELU_1_OUTPUT_FEATURES],
//                float enc_1_conv_relu_0_w[ENC_1_CONV_RELU_0_K][ENC_1_CONV_RELU_0_INPUT_FEATURES][ENC_1_CONV_RELU_0_OUTPUT_FEATURES],
//                float enc_1_conv_relu_1_w[ENC_1_CONV_RELU_1_K][ENC_1_CONV_RELU_1_INPUT_FEATURES][ENC_1_CONV_RELU_1_OUTPUT_FEATURES],
//                float enc_2_conv_relu_0_w[ENC_2_CONV_RELU_0_K][ENC_2_CONV_RELU_0_INPUT_FEATURES][ENC_2_CONV_RELU_0_OUTPUT_FEATURES],
//                float enc_2_conv_relu_1_w[ENC_2_CONV_RELU_1_K][ENC_2_CONV_RELU_1_INPUT_FEATURES][ENC_2_CONV_RELU_1_OUTPUT_FEATURES],
//                float enc_3_conv_relu_0_w[ENC_3_CONV_RELU_0_K][ENC_3_CONV_RELU_0_INPUT_FEATURES][ENC_3_CONV_RELU_0_OUTPUT_FEATURES],
//                float enc_3_conv_relu_1_w[ENC_3_CONV_RELU_1_K][ENC_3_CONV_RELU_1_INPUT_FEATURES][ENC_3_CONV_RELU_1_OUTPUT_FEATURES],
//                float central_conv_relu_0_w[CENTRAL_CONV_RELU_0_K][CENTRAL_CONV_RELU_0_INPUT_FEATURES][CENTRAL_CONV_RELU_0_OUTPUT_FEATURES],
//                float central_conv_relu_1_w[CENTRAL_CONV_RELU_1_K][CENTRAL_CONV_RELU_1_INPUT_FEATURES][CENTRAL_CONV_RELU_1_OUTPUT_FEATURES],
//                float dec_0_up_conv_relu_w[DEC_0_UP_CONV_RELU_K][DEC_0_UP_CONV_RELU_INPUT_FEATURES][DEC_0_UP_CONV_RELU_OUTPUT_FEATURES],
//                float dec_0_conv_relu_0_w[DEC_0_CONV_RELU_0_K][DEC_0_CONV_RELU_0_INPUT_FEATURES][DEC_0_CONV_RELU_0_OUTPUT_FEATURES],
//                float dec_0_conv_relu_1_w[DEC_0_CONV_RELU_1_K][DEC_0_CONV_RELU_1_INPUT_FEATURES][DEC_0_CONV_RELU_1_OUTPUT_FEATURES],
//                float dec_1_up_conv_relu_w[DEC_1_UP_CONV_RELU_K][DEC_1_UP_CONV_RELU_INPUT_FEATURES][DEC_1_UP_CONV_RELU_OUTPUT_FEATURES],
//                float dec_1_conv_relu_0_w[DEC_1_CONV_RELU_0_K][DEC_1_CONV_RELU_0_INPUT_FEATURES][DEC_1_CONV_RELU_0_OUTPUT_FEATURES],
//                float dec_1_conv_relu_1_w[DEC_1_CONV_RELU_1_K][DEC_1_CONV_RELU_1_INPUT_FEATURES][DEC_1_CONV_RELU_1_OUTPUT_FEATURES],
//                float dec_2_up_conv_relu_w[DEC_2_UP_CONV_RELU_K][DEC_2_UP_CONV_RELU_INPUT_FEATURES][DEC_2_UP_CONV_RELU_OUTPUT_FEATURES],
//                float dec_2_conv_relu_0_w[DEC_2_CONV_RELU_0_K][DEC_2_CONV_RELU_0_INPUT_FEATURES][DEC_2_CONV_RELU_0_OUTPUT_FEATURES],
//                float dec_2_conv_relu_1_w[DEC_2_CONV_RELU_1_K][DEC_2_CONV_RELU_1_INPUT_FEATURES][DEC_2_CONV_RELU_1_OUTPUT_FEATURES],
//                float dec_3_up_conv_relu_w[DEC_3_UP_CONV_RELU_K][DEC_3_UP_CONV_RELU_INPUT_FEATURES][DEC_3_UP_CONV_RELU_OUTPUT_FEATURES],
//                float dec_3_conv_relu_0_w[DEC_3_CONV_RELU_0_K][DEC_3_CONV_RELU_0_INPUT_FEATURES][DEC_3_CONV_RELU_0_OUTPUT_FEATURES],
//                float dec_3_conv_relu_1_w[DEC_3_CONV_RELU_1_K][DEC_3_CONV_RELU_1_INPUT_FEATURES][DEC_3_CONV_RELU_1_OUTPUT_FEATURES],
//                float final_conv_w[FINAL_CONV_K][FINAL_CONV_INPUT_FEATURES][FINAL_CONV_OUTPUT_FEATURES],
//                float y[N][N_STATES]);