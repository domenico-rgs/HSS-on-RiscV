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

#include "segmenter.h"

apfixed ReLU(apfixed x){

    /* Rectified Linear Unit implementation.
    Args:
      x - Input value
    Returns: The ReLU output of x
    */

    if(x<0) return 0;
    else return x;
}

void Softmax(apfixed x[N_STATES], apfixed y[N_STATES]){

  /* Softmax implementation
  Args:
    x - Input array to perform softmax
    y - Array to save the softmax resultant values
  */
  
  apfixed expx[N_STATES];

  apfixed expsum = 0;

  SoftmaxAccLoop: for(apint i=0; i<N_STATES; i++){
    #pragma HLS loop_tripcount
    #ifdef FLOAT
      expx[i] = exp(x[i]);
    #endif
    #ifdef FIXED
      expx[i] = hls::expf(x[i]);
    #endif
    expsum += expx[i];
  }

  // To prevent division by zero errors, add EPSILON if expsum is zero
  if(expsum == 0) expsum = EPSILON;

  SoftmaxDivLoop: for(apint i=0; i<N_STATES; i++){
    #pragma HLS loop_tripcount
    y[i] = expx[i]/expsum;
  }
}

void Argmax(apfixed x[N_STATES], apfixed y[N_STATES]){

  /* Argmax implementation
  Args:
    x - Input array to perform argmax
    y - Array to save the argmax resultant values
  */
 
  apfixed maxvalue = MIN_VALUE;
  apint maxindex = 0;
  
  ArgmaxCompLoop: for(apint i=0; i<N_STATES; i++){
    #pragma HLS loop_tripcount
    if (x[i] > maxvalue){
      maxvalue = x[i];
      maxindex = i;
    }
  }

  ArgmaxWriteLoop: for(apint i=0; i<N_STATES; i++){
    #pragma HLS loop_tripcount
    if (i == maxindex) y[i] = 1;
    else y[i] = 0;
  }
}

void Segmenter(apfixed x[N][N_FEATURES],
               apfixed enc_0_conv_relu_0_w[ENC_0_CONV_RELU_0_K][ENC_0_CONV_RELU_0_INPUT_FEATURES][ENC_0_CONV_RELU_0_OUTPUT_FEATURES],
               apfixed enc_0_conv_relu_1_w[ENC_0_CONV_RELU_1_K][ENC_0_CONV_RELU_1_INPUT_FEATURES][ENC_0_CONV_RELU_1_OUTPUT_FEATURES],
               apfixed enc_1_conv_relu_0_w[ENC_1_CONV_RELU_0_K][ENC_1_CONV_RELU_0_INPUT_FEATURES][ENC_1_CONV_RELU_0_OUTPUT_FEATURES],
               apfixed enc_1_conv_relu_1_w[ENC_1_CONV_RELU_1_K][ENC_1_CONV_RELU_1_INPUT_FEATURES][ENC_1_CONV_RELU_1_OUTPUT_FEATURES],
               apfixed enc_2_conv_relu_0_w[ENC_2_CONV_RELU_0_K][ENC_2_CONV_RELU_0_INPUT_FEATURES][ENC_2_CONV_RELU_0_OUTPUT_FEATURES],
               apfixed enc_2_conv_relu_1_w[ENC_2_CONV_RELU_1_K][ENC_2_CONV_RELU_1_INPUT_FEATURES][ENC_2_CONV_RELU_1_OUTPUT_FEATURES],
               apfixed enc_3_conv_relu_0_w[ENC_3_CONV_RELU_0_K][ENC_3_CONV_RELU_0_INPUT_FEATURES][ENC_3_CONV_RELU_0_OUTPUT_FEATURES],
               apfixed enc_3_conv_relu_1_w[ENC_3_CONV_RELU_1_K][ENC_3_CONV_RELU_1_INPUT_FEATURES][ENC_3_CONV_RELU_1_OUTPUT_FEATURES],
               apfixed central_conv_relu_0_w[CENTRAL_CONV_RELU_0_K][CENTRAL_CONV_RELU_0_INPUT_FEATURES][CENTRAL_CONV_RELU_0_OUTPUT_FEATURES],
               apfixed central_conv_relu_1_w[CENTRAL_CONV_RELU_1_K][CENTRAL_CONV_RELU_1_INPUT_FEATURES][CENTRAL_CONV_RELU_1_OUTPUT_FEATURES],
               apfixed dec_0_up_conv_relu_w[DEC_0_UP_CONV_RELU_K][DEC_0_UP_CONV_RELU_INPUT_FEATURES][DEC_0_UP_CONV_RELU_OUTPUT_FEATURES],
               apfixed dec_0_conv_relu_0_w[DEC_0_CONV_RELU_0_K][DEC_0_CONV_RELU_0_INPUT_FEATURES][DEC_0_CONV_RELU_0_OUTPUT_FEATURES],
               apfixed dec_0_conv_relu_1_w[DEC_0_CONV_RELU_1_K][DEC_0_CONV_RELU_1_INPUT_FEATURES][DEC_0_CONV_RELU_1_OUTPUT_FEATURES],
               apfixed dec_1_up_conv_relu_w[DEC_1_UP_CONV_RELU_K][DEC_1_UP_CONV_RELU_INPUT_FEATURES][DEC_1_UP_CONV_RELU_OUTPUT_FEATURES],
               apfixed dec_1_conv_relu_0_w[DEC_1_CONV_RELU_0_K][DEC_1_CONV_RELU_0_INPUT_FEATURES][DEC_1_CONV_RELU_0_OUTPUT_FEATURES],
               apfixed dec_1_conv_relu_1_w[DEC_1_CONV_RELU_1_K][DEC_1_CONV_RELU_1_INPUT_FEATURES][DEC_1_CONV_RELU_1_OUTPUT_FEATURES],
               apfixed dec_2_up_conv_relu_w[DEC_2_UP_CONV_RELU_K][DEC_2_UP_CONV_RELU_INPUT_FEATURES][DEC_2_UP_CONV_RELU_OUTPUT_FEATURES],
               apfixed dec_2_conv_relu_0_w[DEC_2_CONV_RELU_0_K][DEC_2_CONV_RELU_0_INPUT_FEATURES][DEC_2_CONV_RELU_0_OUTPUT_FEATURES],
               apfixed dec_2_conv_relu_1_w[DEC_2_CONV_RELU_1_K][DEC_2_CONV_RELU_1_INPUT_FEATURES][DEC_2_CONV_RELU_1_OUTPUT_FEATURES],
               apfixed dec_3_up_conv_relu_w[DEC_3_UP_CONV_RELU_K][DEC_3_UP_CONV_RELU_INPUT_FEATURES][DEC_3_UP_CONV_RELU_OUTPUT_FEATURES],
               apfixed dec_3_conv_relu_0_w[DEC_3_CONV_RELU_0_K][DEC_3_CONV_RELU_0_INPUT_FEATURES][DEC_3_CONV_RELU_0_OUTPUT_FEATURES],
               apfixed dec_3_conv_relu_1_w[DEC_3_CONV_RELU_1_K][DEC_3_CONV_RELU_1_INPUT_FEATURES][DEC_3_CONV_RELU_1_OUTPUT_FEATURES],
               apfixed final_conv_w[FINAL_CONV_K][FINAL_CONV_INPUT_FEATURES][FINAL_CONV_OUTPUT_FEATURES],
               apfixed y[N][N_STATES]){
    
  // Set all the inputs to the function as s_axilite interfaces
  #pragma HLS INTERFACE s_axilite port=x
  #pragma HLS INTERFACE s_axilite port=enc_0_conv_relu_0_w
  #pragma HLS INTERFACE s_axilite port=enc_0_conv_relu_1_w
  #pragma HLS INTERFACE s_axilite port=enc_1_conv_relu_0_w
  #pragma HLS INTERFACE s_axilite port=enc_1_conv_relu_1_w
  #pragma HLS INTERFACE s_axilite port=enc_2_conv_relu_0_w
  #pragma HLS INTERFACE s_axilite port=enc_2_conv_relu_1_w
  #pragma HLS INTERFACE s_axilite port=enc_3_conv_relu_0_w
  #pragma HLS INTERFACE s_axilite port=enc_3_conv_relu_1_w
  #pragma HLS INTERFACE s_axilite port=central_conv_relu_0_w
  #pragma HLS INTERFACE s_axilite port=central_conv_relu_1_w
  #pragma HLS INTERFACE s_axilite port=dec_0_up_conv_relu_w
  #pragma HLS INTERFACE s_axilite port=dec_0_conv_relu_0_w
  #pragma HLS INTERFACE s_axilite port=dec_0_conv_relu_1_w
  #pragma HLS INTERFACE s_axilite port=dec_1_up_conv_relu_w
  #pragma HLS INTERFACE s_axilite port=dec_1_conv_relu_0_w
  #pragma HLS INTERFACE s_axilite port=dec_1_conv_relu_1_w
  #pragma HLS INTERFACE s_axilite port=dec_2_up_conv_relu_w
  #pragma HLS INTERFACE s_axilite port=dec_2_conv_relu_0_w
  #pragma HLS INTERFACE s_axilite port=dec_2_conv_relu_1_w
  #pragma HLS INTERFACE s_axilite port=dec_3_up_conv_relu_w
  #pragma HLS INTERFACE s_axilite port=dec_3_conv_relu_0_w
  #pragma HLS INTERFACE s_axilite port=dec_3_conv_relu_1_w
  #pragma HLS INTERFACE s_axilite port=final_conv_w
  #pragma HLS INTERFACE s_axilite port=y 

  // Initialize the feature maps

  apfixed enc_0_conv_relu_0[ENC_0_CONV_RELU_0_N][ENC_0_CONV_RELU_0_OUTPUT_FEATURES];
  apfixed enc_0_conv_relu_1[ENC_0_CONV_RELU_1_N][ENC_0_CONV_RELU_1_OUTPUT_FEATURES];
  apfixed enc_0_maxpool[ENC_0_CONV_RELU_1_N/2][ENC_0_CONV_RELU_1_OUTPUT_FEATURES];

  apfixed enc_1_conv_relu_0[ENC_1_CONV_RELU_0_N][ENC_1_CONV_RELU_0_OUTPUT_FEATURES];
  apfixed enc_1_conv_relu_1[ENC_1_CONV_RELU_1_N][ENC_1_CONV_RELU_1_OUTPUT_FEATURES];
  apfixed enc_1_maxpool[ENC_1_CONV_RELU_1_N/2][ENC_1_CONV_RELU_1_OUTPUT_FEATURES];

  apfixed enc_2_conv_relu_0[ENC_2_CONV_RELU_0_N][ENC_2_CONV_RELU_0_OUTPUT_FEATURES];
  apfixed enc_2_conv_relu_1[ENC_2_CONV_RELU_1_N][ENC_2_CONV_RELU_1_OUTPUT_FEATURES];
  apfixed enc_2_maxpool[ENC_2_CONV_RELU_1_N/2][ENC_2_CONV_RELU_1_OUTPUT_FEATURES];

  apfixed enc_3_conv_relu_0[ENC_3_CONV_RELU_0_N][ENC_3_CONV_RELU_0_OUTPUT_FEATURES];
  apfixed enc_3_conv_relu_1[ENC_3_CONV_RELU_1_N][ENC_3_CONV_RELU_1_OUTPUT_FEATURES];
  apfixed enc_3_maxpool[ENC_3_CONV_RELU_1_N/2][ENC_3_CONV_RELU_1_OUTPUT_FEATURES];

  apfixed central_conv_relu_0[CENTRAL_CONV_RELU_0_N][CENTRAL_CONV_RELU_0_OUTPUT_FEATURES];
  apfixed central_conv_relu_1[CENTRAL_CONV_RELU_1_N][CENTRAL_CONV_RELU_1_OUTPUT_FEATURES];

  apfixed dec_0_upsample[DEC_0_UP_CONV_RELU_N][DEC_0_UP_CONV_RELU_INPUT_FEATURES];
  apfixed dec_0_up_conv_relu[DEC_0_UP_CONV_RELU_N][DEC_0_UP_CONV_RELU_OUTPUT_FEATURES];
  apfixed dec_0_concatenate[DEC_0_UP_CONV_RELU_N][DEC_0_UP_CONV_RELU_OUTPUT_FEATURES*2];
  apfixed dec_0_conv_relu_0[DEC_0_CONV_RELU_0_N][DEC_0_CONV_RELU_0_OUTPUT_FEATURES];
  apfixed dec_0_conv_relu_1[DEC_0_CONV_RELU_1_N][DEC_0_CONV_RELU_1_OUTPUT_FEATURES];

  apfixed dec_1_upsample[DEC_1_UP_CONV_RELU_N][DEC_1_UP_CONV_RELU_INPUT_FEATURES];
  apfixed dec_1_up_conv_relu[DEC_1_UP_CONV_RELU_N][DEC_1_UP_CONV_RELU_OUTPUT_FEATURES];
  apfixed dec_1_concatenate[DEC_1_UP_CONV_RELU_N][DEC_1_UP_CONV_RELU_OUTPUT_FEATURES*2];
  apfixed dec_1_conv_relu_0[DEC_1_CONV_RELU_0_N][DEC_1_CONV_RELU_0_OUTPUT_FEATURES];
  apfixed dec_1_conv_relu_1[DEC_1_CONV_RELU_1_N][DEC_1_CONV_RELU_1_OUTPUT_FEATURES];

  apfixed dec_2_upsample[DEC_2_UP_CONV_RELU_N][DEC_2_UP_CONV_RELU_INPUT_FEATURES];
  apfixed dec_2_up_conv_relu[DEC_2_UP_CONV_RELU_N][DEC_2_UP_CONV_RELU_OUTPUT_FEATURES];
  apfixed dec_2_concatenate[DEC_2_UP_CONV_RELU_N][DEC_2_UP_CONV_RELU_OUTPUT_FEATURES*2];
  apfixed dec_2_conv_relu_0[DEC_2_CONV_RELU_0_N][DEC_2_CONV_RELU_0_OUTPUT_FEATURES];
  apfixed dec_2_conv_relu_1[DEC_2_CONV_RELU_1_N][DEC_2_CONV_RELU_1_OUTPUT_FEATURES];

  apfixed dec_3_upsample[DEC_3_UP_CONV_RELU_N][DEC_3_UP_CONV_RELU_INPUT_FEATURES];
  apfixed dec_3_up_conv_relu[DEC_3_UP_CONV_RELU_N][DEC_3_UP_CONV_RELU_OUTPUT_FEATURES];
  apfixed dec_3_concatenate[DEC_3_UP_CONV_RELU_N][DEC_3_UP_CONV_RELU_OUTPUT_FEATURES*2];
  apfixed dec_3_conv_relu_0[DEC_3_CONV_RELU_0_N][DEC_3_CONV_RELU_0_OUTPUT_FEATURES];
  apfixed dec_3_conv_relu_1[DEC_3_CONV_RELU_1_N][DEC_3_CONV_RELU_1_OUTPUT_FEATURES];

  apfixed final_conv[FINAL_CONV_N][FINAL_CONV_OUTPUT_FEATURES];

  apfixed acc; // The accumulator

  apint l_min; // Two auxiliary variables for the fitter's positions
  apint l_max;


  //-----------------------------ENCODER 0--------------------------------------

  //-------------------------enc_0_conv_relu_0----------------------------------
  // Iterate over the number of filters
  enc_0_conv_relu_0_k: for(apint k=0; k<ENC_0_CONV_RELU_0_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    enc_0_conv_relu_0_i: for(apint i=0; i<ENC_0_CONV_RELU_0_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_0_CONV_RELU_0_K/2);
      l_max = min(ENC_0_CONV_RELU_0_N, i + ENC_0_CONV_RELU_0_K/2 + 1);
      acc = 0; // Reset the accumulator
      enc_0_conv_relu_0_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        enc_0_conv_relu_0_j: for(apint j=0; j<ENC_0_CONV_RELU_0_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += x[l][j]*enc_0_conv_relu_0_w[l-i+ENC_0_CONV_RELU_0_K/2][j][k];
        }
      }
    enc_0_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-------------------------enc_0_conv_relu_1----------------------------------
  // Iterate over the number of filters
  enc_0_conv_relu_1_k: for(apint k=0; k<ENC_0_CONV_RELU_1_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    enc_0_conv_relu_1_i: for(apint i=0; i<ENC_0_CONV_RELU_1_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_0_CONV_RELU_1_K/2);
      l_max = min(ENC_0_CONV_RELU_1_N, i + ENC_0_CONV_RELU_1_K/2 + 1);
      acc = 0; // Reset the accumulator
      enc_0_conv_relu_1_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        enc_0_conv_relu_1_j: for(apint j=0; j<ENC_0_CONV_RELU_1_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += enc_0_conv_relu_0[l][j]*enc_0_conv_relu_1_w[l-i+ENC_0_CONV_RELU_1_K/2][j][k];
        }
      }
      enc_0_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-----------------------------enc_0_maxpool----------------------------------
  // Iterate over the number of filters
  enc_0_maxpool_k: for(apint k=0; k<ENC_0_CONV_RELU_1_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    enc_0_maxpool_i: for(apint i=0; i<ENC_0_CONV_RELU_1_N/2; i++){
      enc_0_maxpool[i][k] = max(enc_0_conv_relu_1[2*i][k], enc_0_conv_relu_1[2*i+1][k]);
    }
  }
  //----------------------------------------------------------------------------

  //-----------------------------ENCODER 1--------------------------------------

  //-------------------------enc_1_conv_relu_0----------------------------------
  // Iterate over the number of filters
  enc_1_conv_relu_0_k: for(apint k=0; k<ENC_1_CONV_RELU_0_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    enc_1_conv_relu_0_i: for(apint i=0; i<ENC_1_CONV_RELU_0_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_1_CONV_RELU_0_K/2);
      l_max = min(ENC_1_CONV_RELU_0_N, i + ENC_1_CONV_RELU_0_K/2 + 1);
      acc = 0; // Reset the accumulator
      enc_1_conv_relu_0_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        enc_1_conv_relu_0_j: for(apint j=0; j<ENC_1_CONV_RELU_0_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += enc_0_maxpool[l][j]*enc_1_conv_relu_0_w[l-i+ENC_1_CONV_RELU_0_K/2][j][k];
        }
      }
    enc_1_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-------------------------enc_1_conv_relu_1----------------------------------
  // Iterate over the number of filters
  enc_1_conv_relu_1_k: for(apint k=0; k<ENC_1_CONV_RELU_1_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    enc_1_conv_relu_1_i: for(apint i=0; i<ENC_1_CONV_RELU_1_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_1_CONV_RELU_1_K/2);
      l_max = min(ENC_1_CONV_RELU_1_N, i + ENC_1_CONV_RELU_1_K/2 + 1);
      acc = 0; // Reset the accumulator
      enc_1_conv_relu_1_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        enc_1_conv_relu_1_j: for(apint j=0; j<ENC_1_CONV_RELU_1_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += enc_1_conv_relu_0[l][j]*enc_1_conv_relu_1_w[l-i+ENC_1_CONV_RELU_1_K/2][j][k];
        }
      }
      enc_1_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-----------------------------enc_1_maxpool----------------------------------
  // Iterate over the number of filters
  enc_1_maxpool_k: for(apint k=0; k<ENC_1_CONV_RELU_1_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    enc_1_maxpool_i: for(apint i=0; i<ENC_1_CONV_RELU_1_N/2; i++){
      enc_1_maxpool[i][k] = max(enc_1_conv_relu_1[2*i][k], enc_1_conv_relu_1[2*i+1][k]);
    }
  }
  //----------------------------------------------------------------------------

  //-----------------------------ENCODER 2--------------------------------------

  //-------------------------enc_2_conv_relu_0----------------------------------
  // Iterate over the number of filters
  enc_2_conv_relu_0_k: for(apint k=0; k<ENC_2_CONV_RELU_0_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    enc_2_conv_relu_0_i: for(apint i=0; i<ENC_2_CONV_RELU_0_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_2_CONV_RELU_0_K/2);
      l_max = min(ENC_2_CONV_RELU_0_N, i + ENC_2_CONV_RELU_0_K/2 + 1);
      acc = 0; // Reset the accumulator
      enc_2_conv_relu_0_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        enc_2_conv_relu_0_j: for(apint j=0; j<ENC_2_CONV_RELU_0_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += enc_1_maxpool[l][j]*enc_2_conv_relu_0_w[l-i+ENC_2_CONV_RELU_0_K/2][j][k];
        }
      }
    enc_2_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-------------------------enc_2_conv_relu_1----------------------------------
  // Iterate over the number of filters
  enc_2_conv_relu_1_k: for(apint k=0; k<ENC_2_CONV_RELU_1_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    enc_2_conv_relu_1_i: for(apint i=0; i<ENC_2_CONV_RELU_1_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_2_CONV_RELU_1_K/2);
      l_max = min(ENC_2_CONV_RELU_1_N, i + ENC_2_CONV_RELU_1_K/2 + 1);
      acc = 0; // Reset the accumulator
      enc_2_conv_relu_1_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        enc_2_conv_relu_1_j: for(apint j=0; j<ENC_2_CONV_RELU_1_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += enc_2_conv_relu_0[l][j]*enc_2_conv_relu_1_w[l-i+ENC_2_CONV_RELU_1_K/2][j][k];
        }
      }
      enc_2_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-----------------------------enc_2_maxpool----------------------------------
  // Iterate over the number of filters
  enc_2_maxpool_k: for(apint k=0; k<ENC_2_CONV_RELU_1_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    enc_2_maxpool_i: for(apint i=0; i<ENC_2_CONV_RELU_1_N/2; i++){
      enc_2_maxpool[i][k] = max(enc_2_conv_relu_1[2*i][k], enc_2_conv_relu_1[2*i+1][k]);
    }
  }
  //----------------------------------------------------------------------------

  //-----------------------------ENCODER 3--------------------------------------

  //-------------------------enc_3_conv_relu_0----------------------------------
  // Iterate over the number of filters
  enc_3_conv_relu_0_k: for(apint k=0; k<ENC_3_CONV_RELU_0_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    enc_3_conv_relu_0_i: for(apint i=0; i<ENC_3_CONV_RELU_0_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_3_CONV_RELU_0_K/2);
      l_max = min(ENC_3_CONV_RELU_0_N, i + ENC_3_CONV_RELU_0_K/2 + 1);
      acc = 0; // Reset the accumulator
      enc_3_conv_relu_0_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        enc_3_conv_relu_0_j: for(apint j=0; j<ENC_3_CONV_RELU_0_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += enc_2_maxpool[l][j]*enc_3_conv_relu_0_w[l-i+ENC_3_CONV_RELU_0_K/2][j][k];
        }
      }
    enc_3_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-------------------------enc_3_conv_relu_1----------------------------------
  // Iterate over the number of filters
  enc_3_conv_relu_1_k: for(apint k=0; k<ENC_3_CONV_RELU_1_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    enc_3_conv_relu_1_i: for(apint i=0; i<ENC_3_CONV_RELU_1_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_3_CONV_RELU_1_K/2);
      l_max = min(ENC_3_CONV_RELU_1_N, i + ENC_3_CONV_RELU_1_K/2 + 1);
      acc = 0; // Reset the accumulator
      enc_3_conv_relu_1_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        enc_3_conv_relu_1_j: for(apint j=0; j<ENC_3_CONV_RELU_1_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += enc_3_conv_relu_0[l][j]*enc_3_conv_relu_1_w[l-i+ENC_3_CONV_RELU_1_K/2][j][k];
        }
      }
      enc_3_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-----------------------------enc_3_maxpool----------------------------------
  // Iterate over the number of filters
  enc_3_maxpool_k: for(apint k=0; k<ENC_3_CONV_RELU_1_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    enc_3_maxpool_i: for(apint i=0; i<ENC_3_CONV_RELU_1_N/2; i++){
      enc_3_maxpool[i][k] = max(enc_3_conv_relu_1[2*i][k], enc_3_conv_relu_1[2*i+1][k]);
    }
  }
  //----------------------------------------------------------------------------


  //--------------------------CENTRAL PART--------------------------------------

  //-------------------------central_conv_relu_0----------------------------------
  // Iterate over the number of filters
  central_conv_relu_0_k: for(apint k=0; k<CENTRAL_CONV_RELU_0_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    central_conv_relu_0_i: for(apint i=0; i<CENTRAL_CONV_RELU_0_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - CENTRAL_CONV_RELU_0_K/2);
      l_max = min(CENTRAL_CONV_RELU_0_N, i + CENTRAL_CONV_RELU_0_K/2 + 1);
      acc = 0; // Reset the accumulator
      central_conv_relu_0_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        central_conv_relu_0_j: for(apint j=0; j<CENTRAL_CONV_RELU_0_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += enc_3_maxpool[l][j]*central_conv_relu_0_w[l-i+CENTRAL_CONV_RELU_0_K/2][j][k];
        }
      }
      central_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-------------------------central_conv_relu_1----------------------------------
  // Iterate over the number of filters
  central_conv_relu_1_k: for(apint k=0; k<CENTRAL_CONV_RELU_1_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    central_conv_relu_1_i: for(apint i=0; i<CENTRAL_CONV_RELU_1_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - CENTRAL_CONV_RELU_1_K/2);
      l_max = min(CENTRAL_CONV_RELU_1_N, i + CENTRAL_CONV_RELU_1_K/2 + 1);
      acc = 0; // Reset the accumulator
      central_conv_relu_1_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        central_conv_relu_1_j: for(apint j=0; j<CENTRAL_CONV_RELU_1_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += central_conv_relu_0[l][j]*central_conv_relu_1_w[l-i+CENTRAL_CONV_RELU_1_K/2][j][k];
        }
      }
      central_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------


  //-----------------------------DECODER 0--------------------------------------
  //-----------------------------dec_0_upsample---------------------------------
  // Iterate over the number of filters
  dec_0_upsample_k: for(apint k=0; k<DEC_0_UP_CONV_RELU_INPUT_FEATURES; k++){
    // Iterate over the input matrix
    dec_0_upsample_i: for(apint i=0; i<DEC_0_UP_CONV_RELU_N/2; i++){
      dec_0_upsample[2*i][k] = central_conv_relu_1[i][k];
      dec_0_upsample[2*i+1][k] = central_conv_relu_1[i][k];
    }
  }
  //----------------------------------------------------------------------------

  //-------------------------dec_0_up_conv_relu----------------------------------
  // Iterate over the number of filters
  dec_0_up_conv_relu_k: for(apint k=0; k<DEC_0_UP_CONV_RELU_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    dec_0_up_conv_relu_i: for(apint i=0; i<DEC_0_UP_CONV_RELU_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_0_UP_CONV_RELU_K/2);
      l_max = min(DEC_0_UP_CONV_RELU_N, i + DEC_0_UP_CONV_RELU_K/2 + 1);
      acc = 0; // Reset the accumulator
      dec_0_up_conv_relu_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        dec_0_up_conv_relu_j: for(apint j=0; j<DEC_0_UP_CONV_RELU_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += dec_0_upsample[l][j]*dec_0_up_conv_relu_w[l-i+DEC_0_UP_CONV_RELU_K/2][j][k];
        }
      }
      dec_0_up_conv_relu[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //--------------------------dec_0_concatenate---------------------------------
  // Iterate over the number of filters
  dec_0_concatenate_k: for(apint k=0; k<DEC_0_UP_CONV_RELU_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    dec_0_concatenate_i: for(apint i=0; i<DEC_0_UP_CONV_RELU_N; i++){
      dec_0_concatenate[i][k] = enc_3_conv_relu_1[i][k];
      dec_0_concatenate[i][k+DEC_0_UP_CONV_RELU_OUTPUT_FEATURES] = dec_0_up_conv_relu[i][k];
    }
  }
  //----------------------------------------------------------------------------

  //-------------------------dec_0_conv_relu_0----------------------------------
  // Iterate over the number of filters
  dec_0_conv_relu_0_k: for(apint k=0; k<DEC_0_CONV_RELU_0_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    dec_0_conv_relu_0_i: for(apint i=0; i<DEC_0_CONV_RELU_0_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_0_CONV_RELU_0_K/2);
      l_max = min(DEC_0_CONV_RELU_0_N, i + DEC_0_CONV_RELU_0_K/2 + 1);
      acc = 0; // Reset the accumulator
      dec_0_conv_relu_0_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        dec_0_conv_relu_0_j: for(apint j=0; j<DEC_0_CONV_RELU_0_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += dec_0_concatenate[l][j]*dec_0_conv_relu_0_w[l-i+DEC_0_CONV_RELU_0_K/2][j][k];
        }
      }
      dec_0_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-------------------------dec_0_conv_relu_1----------------------------------
  // Iterate over the number of filters
  dec_0_conv_relu_1_k: for(apint k=0; k<DEC_0_CONV_RELU_1_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    dec_0_conv_relu_1_i: for(apint i=0; i<DEC_0_CONV_RELU_1_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_0_CONV_RELU_1_K/2);
      l_max = min(DEC_0_CONV_RELU_1_N, i + DEC_0_CONV_RELU_1_K/2 + 1);
      acc = 0; // Reset the accumulator
      dec_0_conv_relu_1_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        dec_0_conv_relu_1_j: for(apint j=0; j<DEC_0_CONV_RELU_1_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += dec_0_conv_relu_0[l][j]*dec_0_conv_relu_1_w[l-i+DEC_0_CONV_RELU_1_K/2][j][k];
        }
      }
      dec_0_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-----------------------------DECODER 1--------------------------------------
  //-----------------------------dec_1_upsample---------------------------------
  // Iterate over the number of filters
  dec_1_upsample_k: for(apint k=0; k<DEC_1_UP_CONV_RELU_INPUT_FEATURES; k++){
    // Iterate over the input matrix
    dec_1_upsample_i: for(apint i=0; i<DEC_1_UP_CONV_RELU_N/2; i++){
      dec_1_upsample[2*i][k] = dec_0_conv_relu_1[i][k];
      dec_1_upsample[2*i+1][k] = dec_0_conv_relu_1[i][k];
    }
  }
  //----------------------------------------------------------------------------

  //-------------------------dec_1_up_conv_relu----------------------------------
  // Iterate over the number of filters
  dec_1_up_conv_relu_k: for(apint k=0; k<DEC_1_UP_CONV_RELU_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    dec_1_up_conv_relu_i: for(apint i=0; i<DEC_1_UP_CONV_RELU_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_1_UP_CONV_RELU_K/2);
      l_max = min(DEC_1_UP_CONV_RELU_N, i + DEC_1_UP_CONV_RELU_K/2 + 1);
      acc = 0; // Reset the accumulator
      dec_1_up_conv_relu_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        dec_1_up_conv_relu_j: for(apint j=0; j<DEC_1_UP_CONV_RELU_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += dec_1_upsample[l][j]*dec_1_up_conv_relu_w[l-i+DEC_1_UP_CONV_RELU_K/2][j][k];
        }
      }
      dec_1_up_conv_relu[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //--------------------------dec_1_concatenate---------------------------------
  // Iterate over the number of filters
  dec_1_concatenate_k: for(apint k=0; k<DEC_1_UP_CONV_RELU_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    dec_1_concatenate_i: for(apint i=0; i<DEC_1_UP_CONV_RELU_N; i++){
      dec_1_concatenate[i][k] = enc_2_conv_relu_1[i][k];
      dec_1_concatenate[i][k+DEC_1_UP_CONV_RELU_OUTPUT_FEATURES] = dec_1_up_conv_relu[i][k];
    }
  }
  //----------------------------------------------------------------------------

  //-------------------------dec_1_conv_relu_0----------------------------------
  // Iterate over the number of filters
  dec_1_conv_relu_0_k: for(apint k=0; k<DEC_1_CONV_RELU_0_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    dec_1_conv_relu_0_i: for(apint i=0; i<DEC_1_CONV_RELU_0_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_1_CONV_RELU_0_K/2);
      l_max = min(DEC_1_CONV_RELU_0_N, i + DEC_1_CONV_RELU_0_K/2 + 1);
      acc = 0; // Reset the accumulator
      dec_1_conv_relu_0_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        dec_1_conv_relu_0_j: for(apint j=0; j<DEC_1_CONV_RELU_0_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += dec_1_concatenate[l][j]*dec_1_conv_relu_0_w[l-i+DEC_1_CONV_RELU_0_K/2][j][k];
        }
      }
      dec_1_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-------------------------dec_1_conv_relu_1----------------------------------
  // Iterate over the number of filters
  dec_1_conv_relu_1_k: for(apint k=0; k<DEC_1_CONV_RELU_1_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    dec_1_conv_relu_1_i: for(apint i=0; i<DEC_1_CONV_RELU_1_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_1_CONV_RELU_1_K/2);
      l_max = min(DEC_1_CONV_RELU_1_N, i + DEC_1_CONV_RELU_1_K/2 + 1);
      acc = 0; // Reset the accumulator
      dec_1_conv_relu_1_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        dec_1_conv_relu_1_j: for(apint j=0; j<DEC_1_CONV_RELU_1_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += dec_1_conv_relu_0[l][j]*dec_1_conv_relu_1_w[l-i+DEC_1_CONV_RELU_1_K/2][j][k];
        }
      }
      dec_1_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-----------------------------DECODER 2--------------------------------------
  //-----------------------------dec_2_upsample---------------------------------
  // Iterate over the number of filters
  dec_2_upsample_k: for(apint k=0; k<DEC_2_UP_CONV_RELU_INPUT_FEATURES; k++){
    // Iterate over the input matrix
    dec_2_upsample_i: for(apint i=0; i<DEC_2_UP_CONV_RELU_N/2; i++){
      dec_2_upsample[2*i][k] = dec_1_conv_relu_1[i][k];
      dec_2_upsample[2*i+1][k] = dec_1_conv_relu_1[i][k];
    }
  }
  //----------------------------------------------------------------------------

  //-------------------------dec_2_up_conv_relu----------------------------------
  // Iterate over the number of filters
  dec_2_up_conv_relu_k: for(apint k=0; k<DEC_2_UP_CONV_RELU_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    dec_2_up_conv_relu_i: for(apint i=0; i<DEC_2_UP_CONV_RELU_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_2_UP_CONV_RELU_K/2);
      l_max = min(DEC_2_UP_CONV_RELU_N, i + DEC_2_UP_CONV_RELU_K/2 + 1);
      acc = 0; // Reset the accumulator
      dec_2_up_conv_relu_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        dec_2_up_conv_relu_j: for(apint j=0; j<DEC_2_UP_CONV_RELU_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += dec_2_upsample[l][j]*dec_2_up_conv_relu_w[l-i+DEC_2_UP_CONV_RELU_K/2][j][k];
        }
      }
      dec_2_up_conv_relu[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //--------------------------dec_2_concatenate---------------------------------
  // Iterate over the number of filters
  dec_2_concatenate_k: for(apint k=0; k<DEC_2_UP_CONV_RELU_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    dec_2_concatenate_i: for(apint i=0; i<DEC_2_UP_CONV_RELU_N; i++){
      dec_2_concatenate[i][k] = enc_1_conv_relu_1[i][k];
      dec_2_concatenate[i][k+DEC_2_UP_CONV_RELU_OUTPUT_FEATURES] = dec_2_up_conv_relu[i][k];
    }
  }
  //----------------------------------------------------------------------------

  //-------------------------dec_2_conv_relu_0----------------------------------
  // Iterate over the number of filters
  dec_2_conv_relu_0_k: for(apint k=0; k<DEC_2_CONV_RELU_0_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    dec_2_conv_relu_0_i: for(apint i=0; i<DEC_2_CONV_RELU_0_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_2_CONV_RELU_0_K/2);
      l_max = min(DEC_2_CONV_RELU_0_N, i + DEC_2_CONV_RELU_0_K/2 + 1);
      acc = 0; // Reset the accumulator
      dec_2_conv_relu_0_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        dec_2_conv_relu_0_j: for(apint j=0; j<DEC_2_CONV_RELU_0_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += dec_2_concatenate[l][j]*dec_2_conv_relu_0_w[l-i+DEC_2_CONV_RELU_0_K/2][j][k];
        }
      }
      dec_2_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-------------------------dec_2_conv_relu_1----------------------------------
  // Iterate over the number of filters
  dec_2_conv_relu_1_k: for(apint k=0; k<DEC_2_CONV_RELU_1_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    dec_2_conv_relu_1_i: for(apint i=0; i<DEC_2_CONV_RELU_1_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_2_CONV_RELU_1_K/2);
      l_max = min(DEC_2_CONV_RELU_1_N, i + DEC_2_CONV_RELU_1_K/2 + 1);
      acc = 0; // Reset the accumulator
      dec_2_conv_relu_1_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        dec_2_conv_relu_1_j: for(apint j=0; j<DEC_2_CONV_RELU_1_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += dec_2_conv_relu_0[l][j]*dec_2_conv_relu_1_w[l-i+DEC_2_CONV_RELU_1_K/2][j][k];
        }
      }
      dec_2_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-----------------------------DECODER 3--------------------------------------
  //-----------------------------dec_3_upsample---------------------------------
  // Iterate over the number of filters
  dec_3_upsample_k: for(apint k=0; k<DEC_3_UP_CONV_RELU_INPUT_FEATURES; k++){
    // Iterate over the input matrix
    dec_3_upsample_i: for(apint i=0; i<DEC_3_UP_CONV_RELU_N/2; i++){
      dec_3_upsample[2*i][k] = dec_2_conv_relu_1[i][k];
      dec_3_upsample[2*i+1][k] = dec_2_conv_relu_1[i][k];
    }
  }
  //----------------------------------------------------------------------------

  //-------------------------dec_3_up_conv_relu----------------------------------
  // Iterate over the number of filters
  dec_3_up_conv_relu_k: for(apint k=0; k<DEC_3_UP_CONV_RELU_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    dec_3_up_conv_relu_i: for(apint i=0; i<DEC_3_UP_CONV_RELU_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_3_UP_CONV_RELU_K/2);
      l_max = min(DEC_3_UP_CONV_RELU_N, i + DEC_3_UP_CONV_RELU_K/2 + 1);
      acc = 0; // Reset the accumulator
      dec_3_up_conv_relu_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        dec_3_up_conv_relu_j: for(apint j=0; j<DEC_3_UP_CONV_RELU_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += dec_3_upsample[l][j]*dec_3_up_conv_relu_w[l-i+DEC_3_UP_CONV_RELU_K/2][j][k];
        }
      }
      dec_3_up_conv_relu[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //--------------------------dec_3_concatenate---------------------------------
  // Iterate over the number of filters
  dec_3_concatenate_k: for(apint k=0; k<DEC_3_UP_CONV_RELU_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    dec_3_concatenate_i: for(apint i=0; i<DEC_3_UP_CONV_RELU_N; i++){
      dec_3_concatenate[i][k] = enc_0_conv_relu_1[i][k];
      dec_3_concatenate[i][k+DEC_3_UP_CONV_RELU_OUTPUT_FEATURES] = dec_3_up_conv_relu[i][k];
    }
  }
  //----------------------------------------------------------------------------

  //-------------------------dec_3_conv_relu_0----------------------------------
  // Iterate over the number of filters
  dec_3_conv_relu_0_k: for(apint k=0; k<DEC_3_CONV_RELU_0_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    dec_3_conv_relu_0_i: for(apint i=0; i<DEC_3_CONV_RELU_0_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_3_CONV_RELU_0_K/2);
      l_max = min(DEC_3_CONV_RELU_0_N, i + DEC_3_CONV_RELU_0_K/2 + 1);
      acc = 0; // Reset the accumulator
      dec_3_conv_relu_0_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        dec_3_conv_relu_0_j: for(apint j=0; j<DEC_3_CONV_RELU_0_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += dec_3_concatenate[l][j]*dec_3_conv_relu_0_w[l-i+DEC_3_CONV_RELU_0_K/2][j][k];
        }
      }
      dec_3_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-------------------------dec_3_conv_relu_1----------------------------------
  // Iterate over the number of filters
  dec_3_conv_relu_1_k: for(apint k=0; k<DEC_3_CONV_RELU_1_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    dec_3_conv_relu_1_i: for(apint i=0; i<DEC_3_CONV_RELU_1_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_3_CONV_RELU_1_K/2);
      l_max = min(DEC_3_CONV_RELU_1_N, i + DEC_3_CONV_RELU_1_K/2 + 1);
      acc = 0; // Reset the accumulator
      dec_3_conv_relu_1_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        dec_3_conv_relu_1_j: for(apint j=0; j<DEC_3_CONV_RELU_1_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += dec_3_conv_relu_0[l][j]*dec_3_conv_relu_1_w[l-i+DEC_3_CONV_RELU_1_K/2][j][k];
        }
      }
      dec_3_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //----------------------------FINAL CONV--------------------------------------
  //----------------------------final_conv--------------------------------------
  // Iterate over the number of filters
  final_conv_k: for(apint k=0; k<FINAL_CONV_OUTPUT_FEATURES; k++){
    // Iterate over the input matrix
    final_conv_i: for(apint i=0; i<FINAL_CONV_N; i++){
      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - FINAL_CONV_K/2);
      l_max = min(FINAL_CONV_N, i + FINAL_CONV_K/2 + 1);
      acc = 0; // Reset the accumulator
      final_conv_l: for(apint l=l_min; l<l_max; l++){
        #pragma HLS loop_tripcount min=2 max=3 avg=3
        final_conv_j: for(apint j=0; j<FINAL_CONV_INPUT_FEATURES; j++){
          // Multiply the input and the weight
          acc += dec_3_conv_relu_1[l][j]*final_conv_w[l-i+FINAL_CONV_K/2][j][k];
        }
      }
      final_conv[i][k] = acc; // Save the accumulator value
    }  
  }

  //----------------------------argmax-----------------------------------------
  // Iterate over the input matrix
  argmax_i: for(apint i=0; i<FINAL_CONV_N; i++){
    #pragma HLS loop_tripcount
    Argmax(final_conv[i], y[i]);
  }
  //----------------------------------------------------------------------------

}