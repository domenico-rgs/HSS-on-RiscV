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

#define FPXINT

/*------------------------------------------------------------------------------
-------------------------------DEPENDENCIES-------------------------------------
------------------------------------------------------------------------------*/
#include <algorithm>
#include <math.h>

#ifdef DOUBLE
    typedef double arraytype;
#else
    typedef float arraytype;
#endif

#ifdef DOUBLE
    typedef double datatype;
#endif
#ifdef FLOAT
    typedef float datatype;
#endif

#ifdef FPXINT
    typedef int8_t datatype;
	#define FXP 8

int8_t quantize(float a, int fxp){
	int16_t maxVal = ((1 << (FXP-1)) - 1);
	int16_t value = roundf(a * (1 << fxp)); //mapping + rounding
	//int32_t value = a * (1 << fxp); //mapping without rounding

	//clipping
	if(value > maxVal){
		return (int8_t)maxVal;
	}else if(value < -maxVal-1){
		return (int8_t)(-maxVal-1);
	}else{
		return (int8_t)value;
	}
}

//Function for dequantization, if needed uncomment
/*float dequantize(int32_t val, int fxp){
	return val/((float)(1<<fxp));
}*/
#else
	#define PRECISION 18
#endif

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