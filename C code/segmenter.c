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
#include "functions.h"

void Segmenter(datatype x[N*N_FEATURES],
               datatype enc_0_conv_relu_0_w[ENC_0_CONV_RELU_0_K*ENC_0_CONV_RELU_0_INPUT_FEATURES*ENC_0_CONV_RELU_0_OUTPUT_FEATURES],
               datatype enc_0_conv_relu_1_w[ENC_0_CONV_RELU_1_K*ENC_0_CONV_RELU_1_INPUT_FEATURES*ENC_0_CONV_RELU_1_OUTPUT_FEATURES],
               datatype enc_1_conv_relu_0_w[ENC_1_CONV_RELU_0_K*ENC_1_CONV_RELU_0_INPUT_FEATURES*ENC_1_CONV_RELU_0_OUTPUT_FEATURES],
               datatype enc_1_conv_relu_1_w[ENC_1_CONV_RELU_1_K*ENC_1_CONV_RELU_1_INPUT_FEATURES*ENC_1_CONV_RELU_1_OUTPUT_FEATURES],
               datatype enc_2_conv_relu_0_w[ENC_2_CONV_RELU_0_K*ENC_2_CONV_RELU_0_INPUT_FEATURES*ENC_2_CONV_RELU_0_OUTPUT_FEATURES],
               datatype enc_2_conv_relu_1_w[ENC_2_CONV_RELU_1_K*ENC_2_CONV_RELU_1_INPUT_FEATURES*ENC_2_CONV_RELU_1_OUTPUT_FEATURES],
               datatype enc_3_conv_relu_0_w[ENC_3_CONV_RELU_0_K*ENC_3_CONV_RELU_0_INPUT_FEATURES*ENC_3_CONV_RELU_0_OUTPUT_FEATURES],
               datatype enc_3_conv_relu_1_w[ENC_3_CONV_RELU_1_K*ENC_3_CONV_RELU_1_INPUT_FEATURES*ENC_3_CONV_RELU_1_OUTPUT_FEATURES],
               datatype central_conv_relu_0_w[CENTRAL_CONV_RELU_0_K*CENTRAL_CONV_RELU_0_INPUT_FEATURES*CENTRAL_CONV_RELU_0_OUTPUT_FEATURES],
               datatype central_conv_relu_1_w[CENTRAL_CONV_RELU_1_K*CENTRAL_CONV_RELU_1_INPUT_FEATURES*CENTRAL_CONV_RELU_1_OUTPUT_FEATURES],
               datatype dec_0_up_conv_relu_w[DEC_0_UP_CONV_RELU_K*DEC_0_UP_CONV_RELU_INPUT_FEATURES*DEC_0_UP_CONV_RELU_OUTPUT_FEATURES],
               datatype dec_0_conv_relu_0_w[DEC_0_CONV_RELU_0_K*DEC_0_CONV_RELU_0_INPUT_FEATURES*DEC_0_CONV_RELU_0_OUTPUT_FEATURES],
               datatype dec_0_conv_relu_1_w[DEC_0_CONV_RELU_1_K*DEC_0_CONV_RELU_1_INPUT_FEATURES*DEC_0_CONV_RELU_1_OUTPUT_FEATURES],
               datatype dec_1_up_conv_relu_w[DEC_1_UP_CONV_RELU_K*DEC_1_UP_CONV_RELU_INPUT_FEATURES*DEC_1_UP_CONV_RELU_OUTPUT_FEATURES],
               datatype dec_1_conv_relu_0_w[DEC_1_CONV_RELU_0_K*DEC_1_CONV_RELU_0_INPUT_FEATURES*DEC_1_CONV_RELU_0_OUTPUT_FEATURES],
               datatype dec_1_conv_relu_1_w[DEC_1_CONV_RELU_1_K*DEC_1_CONV_RELU_1_INPUT_FEATURES*DEC_1_CONV_RELU_1_OUTPUT_FEATURES],
               datatype dec_2_up_conv_relu_w[DEC_2_UP_CONV_RELU_K*DEC_2_UP_CONV_RELU_INPUT_FEATURES*DEC_2_UP_CONV_RELU_OUTPUT_FEATURES],
               datatype dec_2_conv_relu_0_w[DEC_2_CONV_RELU_0_K*DEC_2_CONV_RELU_0_INPUT_FEATURES*DEC_2_CONV_RELU_0_OUTPUT_FEATURES],
               datatype dec_2_conv_relu_1_w[DEC_2_CONV_RELU_1_K*DEC_2_CONV_RELU_1_INPUT_FEATURES*DEC_2_CONV_RELU_1_OUTPUT_FEATURES],
               datatype dec_3_up_conv_relu_w[DEC_3_UP_CONV_RELU_K*DEC_3_UP_CONV_RELU_INPUT_FEATURES*DEC_3_UP_CONV_RELU_OUTPUT_FEATURES],
               datatype dec_3_conv_relu_0_w[DEC_3_CONV_RELU_0_K*DEC_3_CONV_RELU_0_INPUT_FEATURES*DEC_3_CONV_RELU_0_OUTPUT_FEATURES],
               datatype dec_3_conv_relu_1_w[DEC_3_CONV_RELU_1_K*DEC_3_CONV_RELU_1_INPUT_FEATURES*DEC_3_CONV_RELU_1_OUTPUT_FEATURES],
               datatype final_conv_w[FINAL_CONV_K*FINAL_CONV_INPUT_FEATURES*FINAL_CONV_OUTPUT_FEATURES],
               datatype y[N][N_STATES]){

  // Initialize the feature maps
  datatype enc_0_conv_relu_0[ENC_0_CONV_RELU_0_N][ENC_0_CONV_RELU_0_OUTPUT_FEATURES];
  datatype enc_0_conv_relu_1[ENC_0_CONV_RELU_1_N][ENC_0_CONV_RELU_1_OUTPUT_FEATURES];
  datatype enc_0_maxpool[ENC_0_CONV_RELU_1_N/2][ENC_0_CONV_RELU_1_OUTPUT_FEATURES];

  datatype enc_1_conv_relu_0[ENC_1_CONV_RELU_0_N][ENC_1_CONV_RELU_0_OUTPUT_FEATURES];
  datatype enc_1_conv_relu_1[ENC_1_CONV_RELU_1_N][ENC_1_CONV_RELU_1_OUTPUT_FEATURES];
  datatype enc_1_maxpool[ENC_1_CONV_RELU_1_N/2][ENC_1_CONV_RELU_1_OUTPUT_FEATURES];

  datatype enc_2_conv_relu_0[ENC_2_CONV_RELU_0_N][ENC_2_CONV_RELU_0_OUTPUT_FEATURES];
  datatype enc_2_conv_relu_1[ENC_2_CONV_RELU_1_N][ENC_2_CONV_RELU_1_OUTPUT_FEATURES];
  datatype enc_2_maxpool[ENC_2_CONV_RELU_1_N/2][ENC_2_CONV_RELU_1_OUTPUT_FEATURES];

  datatype enc_3_conv_relu_0[ENC_3_CONV_RELU_0_N][ENC_3_CONV_RELU_0_OUTPUT_FEATURES];
  datatype enc_3_conv_relu_1[ENC_3_CONV_RELU_1_N][ENC_3_CONV_RELU_1_OUTPUT_FEATURES];
  datatype enc_3_maxpool[ENC_3_CONV_RELU_1_N/2][ENC_3_CONV_RELU_1_OUTPUT_FEATURES];

  datatype central_conv_relu_0[CENTRAL_CONV_RELU_0_N][CENTRAL_CONV_RELU_0_OUTPUT_FEATURES];
  datatype central_conv_relu_1[CENTRAL_CONV_RELU_1_N][CENTRAL_CONV_RELU_1_OUTPUT_FEATURES];

  datatype dec_0_upsample[DEC_0_UP_CONV_RELU_N][DEC_0_UP_CONV_RELU_INPUT_FEATURES];
  datatype dec_0_up_conv_relu[DEC_0_UP_CONV_RELU_N][DEC_0_UP_CONV_RELU_OUTPUT_FEATURES];
  datatype dec_0_concatenate[DEC_0_UP_CONV_RELU_N][DEC_0_UP_CONV_RELU_OUTPUT_FEATURES*2];
  datatype dec_0_conv_relu_0[DEC_0_CONV_RELU_0_N][DEC_0_CONV_RELU_0_OUTPUT_FEATURES];
  datatype dec_0_conv_relu_1[DEC_0_CONV_RELU_1_N][DEC_0_CONV_RELU_1_OUTPUT_FEATURES];

  datatype dec_1_upsample[DEC_1_UP_CONV_RELU_N][DEC_1_UP_CONV_RELU_INPUT_FEATURES];
  datatype dec_1_up_conv_relu[DEC_1_UP_CONV_RELU_N][DEC_1_UP_CONV_RELU_OUTPUT_FEATURES];
  datatype dec_1_concatenate[DEC_1_UP_CONV_RELU_N][DEC_1_UP_CONV_RELU_OUTPUT_FEATURES*2];
  datatype dec_1_conv_relu_0[DEC_1_CONV_RELU_0_N][DEC_1_CONV_RELU_0_OUTPUT_FEATURES];
  datatype dec_1_conv_relu_1[DEC_1_CONV_RELU_1_N][DEC_1_CONV_RELU_1_OUTPUT_FEATURES];

  datatype dec_2_upsample[DEC_2_UP_CONV_RELU_N][DEC_2_UP_CONV_RELU_INPUT_FEATURES];
  datatype dec_2_up_conv_relu[DEC_2_UP_CONV_RELU_N][DEC_2_UP_CONV_RELU_OUTPUT_FEATURES];
  datatype dec_2_concatenate[DEC_2_UP_CONV_RELU_N][DEC_2_UP_CONV_RELU_OUTPUT_FEATURES*2];
  datatype dec_2_conv_relu_0[DEC_2_CONV_RELU_0_N][DEC_2_CONV_RELU_0_OUTPUT_FEATURES];
  datatype dec_2_conv_relu_1[DEC_2_CONV_RELU_1_N][DEC_2_CONV_RELU_1_OUTPUT_FEATURES];

  datatype dec_3_upsample[DEC_3_UP_CONV_RELU_N][DEC_3_UP_CONV_RELU_INPUT_FEATURES];
  datatype dec_3_up_conv_relu[DEC_3_UP_CONV_RELU_N][DEC_3_UP_CONV_RELU_OUTPUT_FEATURES];
  datatype dec_3_concatenate[DEC_3_UP_CONV_RELU_N][DEC_3_UP_CONV_RELU_OUTPUT_FEATURES*2];
  datatype dec_3_conv_relu_0[DEC_3_CONV_RELU_0_N][DEC_3_CONV_RELU_0_OUTPUT_FEATURES];
  datatype dec_3_conv_relu_1[DEC_3_CONV_RELU_1_N][DEC_3_CONV_RELU_1_OUTPUT_FEATURES];

  datatype final_conv[FINAL_CONV_N][FINAL_CONV_OUTPUT_FEATURES]={{0}};

  datatype acc; // The accumulator

  int l_min; // Two auxiliary variables for the fitter's positions
  int l_max;

  //CALLGRIND_START_INSTRUMENTATION;
  //CALLGRIND_TOGGLE_COLLECT;
  //-----------------------------ENCODER 0--------------------------------------
  //-------------------------enc_0_conv_relu_0----------------------------------
  for(int k=0; k<ENC_0_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<ENC_0_CONV_RELU_0_N; i++){    // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_0_CONV_RELU_0_K/2);
      l_max = min(ENC_0_CONV_RELU_0_N, i + ENC_0_CONV_RELU_0_K/2 + 1);
      
      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_0_CONV_RELU_0_INPUT_FEATURES; j++){
          //acc += x[l*ENC_0_CONV_RELU_0_INPUT_FEATURES+j]*enc_0_conv_relu_0_w[(l-i+ENC_0_CONV_RELU_0_K/2)*ENC_0_CONV_RELU_0_INPUT_FEATURES*ENC_0_CONV_RELU_0_OUTPUT_FEATURES+j*ENC_0_CONV_RELU_0_OUTPUT_FEATURES+k];  // Multiply the input and the weight
          acc += x[l*ENC_0_CONV_RELU_0_INPUT_FEATURES+j]*enc_0_conv_relu_0_w[k*ENC_0_CONV_RELU_0_K*ENC_0_CONV_RELU_0_INPUT_FEATURES+(l-i+ENC_0_CONV_RELU_0_K/2)*ENC_0_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
          //printf("%f %f\n",enc_0_conv_relu_0_w[k*l_max*ENC_0_CONV_RELU_0_INPUT_FEATURES+(l-i+ENC_0_CONV_RELU_0_K/2)*ENC_0_CONV_RELU_0_INPUT_FEATURES+j],enc_0_conv_relu_0_w[(l-i+ENC_0_CONV_RELU_0_K/2)*ENC_0_CONV_RELU_0_INPUT_FEATURES*ENC_0_CONV_RELU_0_OUTPUT_FEATURES+j*ENC_0_CONV_RELU_0_OUTPUT_FEATURES+k]);
        }
      }

      enc_0_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
               
  //CALLGRIND_TOGGLE_COLLECT;          
  //-------------------------enc_0_conv_relu_1----------------------------------
  for(int k=0; k<ENC_0_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<ENC_0_CONV_RELU_1_N; i++){    // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_0_CONV_RELU_1_K/2);
      l_max = min(ENC_0_CONV_RELU_1_N, i + ENC_0_CONV_RELU_1_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_0_CONV_RELU_1_INPUT_FEATURES; j++){
          acc += enc_0_conv_relu_0[l][j]*enc_0_conv_relu_1_w[k*ENC_0_CONV_RELU_1_K*ENC_0_CONV_RELU_1_INPUT_FEATURES+(l-i+ENC_0_CONV_RELU_1_K/2)*ENC_0_CONV_RELU_1_INPUT_FEATURES+j]; // Multiply the input and the weight
        }
      }

      enc_0_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }

  //-----------------------------enc_0_maxpool----------------------------------
  for(int i=0; i<ENC_0_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<ENC_0_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      enc_0_maxpool[i][k] = max(enc_0_conv_relu_1[2*i][k], enc_0_conv_relu_1[2*i+1][k]);
    }
  }
  //----------------------------------------------------------------------------

  //-----------------------------ENCODER 1--------------------------------------
  //-------------------------enc_1_conv_relu_0----------------------------------
  for(int k=0; k<ENC_1_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<ENC_1_CONV_RELU_0_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_1_CONV_RELU_0_K/2);
      l_max = min(ENC_1_CONV_RELU_0_N, i + ENC_1_CONV_RELU_0_K/2 + 1);
      
      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_1_CONV_RELU_0_INPUT_FEATURES; j++){
          acc += enc_0_maxpool[l][j]*enc_1_conv_relu_0_w[k*ENC_1_CONV_RELU_0_K*ENC_1_CONV_RELU_0_INPUT_FEATURES+(l-i+ENC_1_CONV_RELU_0_K/2)*ENC_1_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }

      enc_1_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }

  //-------------------------enc_1_conv_relu_1----------------------------------
  for(int k=0; k<ENC_1_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<ENC_1_CONV_RELU_1_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_1_CONV_RELU_1_K/2);
      l_max = min(ENC_1_CONV_RELU_1_N, i + ENC_1_CONV_RELU_1_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_1_CONV_RELU_1_INPUT_FEATURES; j++){
          acc += enc_1_conv_relu_0[l][j]*enc_1_conv_relu_1_w[k*ENC_1_CONV_RELU_1_K*ENC_1_CONV_RELU_1_INPUT_FEATURES+(l-i+ENC_1_CONV_RELU_1_K/2)*ENC_1_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }

      enc_1_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }

  //-----------------------------enc_1_maxpool----------------------------------
  for(int i=0; i<ENC_1_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<ENC_1_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      enc_1_maxpool[i][k] = max(enc_1_conv_relu_1[2*i][k], enc_1_conv_relu_1[2*i+1][k]);
    }
  }
  //----------------------------------------------------------------------------

  //-----------------------------ENCODER 2--------------------------------------
  //-------------------------enc_2_conv_relu_0----------------------------------
  for(int k=0; k<ENC_2_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<ENC_2_CONV_RELU_0_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_2_CONV_RELU_0_K/2);
      l_max = min(ENC_2_CONV_RELU_0_N, i + ENC_2_CONV_RELU_0_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_2_CONV_RELU_0_INPUT_FEATURES; j++){
          acc += enc_1_maxpool[l][j]*enc_2_conv_relu_0_w[k*ENC_2_CONV_RELU_0_K*ENC_2_CONV_RELU_0_INPUT_FEATURES+(l-i+ENC_2_CONV_RELU_0_K/2)*ENC_2_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }

      enc_2_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }

  //-------------------------enc_2_conv_relu_1----------------------------------
  for(int k=0; k<ENC_2_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<ENC_2_CONV_RELU_1_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_2_CONV_RELU_1_K/2);
      l_max = min(ENC_2_CONV_RELU_1_N, i + ENC_2_CONV_RELU_1_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_2_CONV_RELU_1_INPUT_FEATURES; j++){
          acc += enc_2_conv_relu_0[l][j]*enc_2_conv_relu_1_w[k*ENC_2_CONV_RELU_1_K*ENC_2_CONV_RELU_1_INPUT_FEATURES+(l-i+ENC_2_CONV_RELU_1_K/2)*ENC_2_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }

      enc_2_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }

  //-----------------------------enc_2_maxpool----------------------------------
  for(int i=0; i<ENC_2_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<ENC_2_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      enc_2_maxpool[i][k] = max(enc_2_conv_relu_1[2*i][k], enc_2_conv_relu_1[2*i+1][k]);
    }
  }
  //----------------------------------------------------------------------------

  //-----------------------------ENCODER 3--------------------------------------
  //-------------------------enc_3_conv_relu_0----------------------------------
  for(int k=0; k<ENC_3_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<ENC_3_CONV_RELU_0_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_3_CONV_RELU_0_K/2);
      l_max = min(ENC_3_CONV_RELU_0_N, i + ENC_3_CONV_RELU_0_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_3_CONV_RELU_0_INPUT_FEATURES; j++){
          acc += enc_2_maxpool[l][j]*enc_3_conv_relu_0_w[k*ENC_3_CONV_RELU_0_K*ENC_3_CONV_RELU_0_INPUT_FEATURES+(l-i+ENC_3_CONV_RELU_0_K/2)*ENC_3_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }

      enc_3_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }

  //-------------------------enc_3_conv_relu_1----------------------------------
  for(int k=0; k<ENC_3_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<ENC_3_CONV_RELU_1_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_3_CONV_RELU_1_K/2);
      l_max = min(ENC_3_CONV_RELU_1_N, i + ENC_3_CONV_RELU_1_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_3_CONV_RELU_1_INPUT_FEATURES; j++){
          acc += enc_3_conv_relu_0[l][j]*enc_3_conv_relu_1_w[k*ENC_3_CONV_RELU_1_K*ENC_3_CONV_RELU_1_INPUT_FEATURES+(l-i+ENC_3_CONV_RELU_1_K/2)*ENC_3_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }

      enc_3_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }

  //-----------------------------enc_3_maxpool----------------------------------
  for(int i=0; i<ENC_3_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<ENC_3_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      enc_3_maxpool[i][k] = max(enc_3_conv_relu_1[2*i][k], enc_3_conv_relu_1[2*i+1][k]);
    }
  }
  //----------------------------------------------------------------------------


  //--------------------------CENTRAL PART--------------------------------------

  //-------------------------central_conv_relu_0----------------------------------
  for(int k=0; k<CENTRAL_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<CENTRAL_CONV_RELU_0_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - CENTRAL_CONV_RELU_0_K/2);
      l_max = min(CENTRAL_CONV_RELU_0_N, i + CENTRAL_CONV_RELU_0_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<CENTRAL_CONV_RELU_0_INPUT_FEATURES; j++){
          acc += enc_3_maxpool[l][j]*central_conv_relu_0_w[k*CENTRAL_CONV_RELU_0_K*CENTRAL_CONV_RELU_0_INPUT_FEATURES+(l-i+CENTRAL_CONV_RELU_0_K/2)*CENTRAL_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }
      central_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }

  //-------------------------central_conv_relu_1----------------------------------
  for(int k=0; k<CENTRAL_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<CENTRAL_CONV_RELU_1_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - CENTRAL_CONV_RELU_1_K/2);
      l_max = min(CENTRAL_CONV_RELU_1_N, i + CENTRAL_CONV_RELU_1_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<CENTRAL_CONV_RELU_1_INPUT_FEATURES; j++){
          acc += central_conv_relu_0[l][j]*central_conv_relu_1_w[k*CENTRAL_CONV_RELU_1_K*CENTRAL_CONV_RELU_1_INPUT_FEATURES+(l-i+CENTRAL_CONV_RELU_1_K/2)*CENTRAL_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }

      central_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-----------------------------DECODER 0--------------------------------------
  //-----------------------------dec_0_upsample---------------------------------
  for(int i=0; i<DEC_0_UP_CONV_RELU_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_0_UP_CONV_RELU_INPUT_FEATURES; k++){  // Iterate over the number of filters
      dec_0_upsample[2*i][k] = central_conv_relu_1[i][k];
      dec_0_upsample[2*i+1][k] = central_conv_relu_1[i][k];
    }
  }

  //-------------------------dec_0_up_conv_relu----------------------------------
  for(int k=0; k<DEC_0_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<DEC_0_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_0_UP_CONV_RELU_K/2);
      l_max = min(DEC_0_UP_CONV_RELU_N, i + DEC_0_UP_CONV_RELU_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_0_UP_CONV_RELU_INPUT_FEATURES; j++){
          acc += dec_0_upsample[l][j]*dec_0_up_conv_relu_w[k*DEC_0_UP_CONV_RELU_K*DEC_0_UP_CONV_RELU_INPUT_FEATURES+(l-i+DEC_0_UP_CONV_RELU_K/2)*DEC_0_UP_CONV_RELU_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }
      dec_0_up_conv_relu[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }

  //--------------------------dec_0_concatenate---------------------------------
  for(int i=0; i<DEC_0_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_0_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      dec_0_concatenate[i][k] = enc_3_conv_relu_1[i][k];
      dec_0_concatenate[i][k+DEC_0_UP_CONV_RELU_OUTPUT_FEATURES] = dec_0_up_conv_relu[i][k];
    }
  }

  //-------------------------dec_0_conv_relu_0----------------------------------
  for(int k=0; k<DEC_0_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<DEC_0_CONV_RELU_0_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_0_CONV_RELU_0_K/2);
      l_max = min(DEC_0_CONV_RELU_0_N, i + DEC_0_CONV_RELU_0_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_0_CONV_RELU_0_INPUT_FEATURES; j++){
          acc += dec_0_concatenate[l][j]*dec_0_conv_relu_0_w[k*DEC_0_CONV_RELU_0_K*DEC_0_CONV_RELU_0_INPUT_FEATURES+(l-i+DEC_0_CONV_RELU_0_K/2)*DEC_0_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }
      dec_0_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }

  //-------------------------dec_0_conv_relu_1----------------------------------
  for(int k=0; k<DEC_0_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<DEC_0_CONV_RELU_1_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_0_CONV_RELU_1_K/2);
      l_max = min(DEC_0_CONV_RELU_1_N, i + DEC_0_CONV_RELU_1_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_0_CONV_RELU_1_INPUT_FEATURES; j++){
          acc += dec_0_conv_relu_0[l][j]*dec_0_conv_relu_1_w[k*DEC_0_CONV_RELU_1_K*DEC_0_CONV_RELU_1_INPUT_FEATURES+(l-i+DEC_0_CONV_RELU_1_K/2)*DEC_0_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }

      dec_0_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------
              
  //-----------------------------DECODER 1--------------------------------------
  //-----------------------------dec_1_upsample---------------------------------
  for(int i=0; i<DEC_1_UP_CONV_RELU_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_1_UP_CONV_RELU_INPUT_FEATURES; k++){  // Iterate over the number of filters
      dec_1_upsample[2*i][k] = dec_0_conv_relu_1[i][k];
      dec_1_upsample[2*i+1][k] = dec_0_conv_relu_1[i][k];
    }
  }

  //-------------------------dec_1_up_conv_relu----------------------------------
  for(int k=0; k<DEC_1_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<DEC_1_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_1_UP_CONV_RELU_K/2);
      l_max = min(DEC_1_UP_CONV_RELU_N, i + DEC_1_UP_CONV_RELU_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_1_UP_CONV_RELU_INPUT_FEATURES; j++){
          acc += dec_1_upsample[l][j]*dec_1_up_conv_relu_w[k*DEC_1_UP_CONV_RELU_K*DEC_1_UP_CONV_RELU_INPUT_FEATURES+(l-i+DEC_1_UP_CONV_RELU_K/2)*DEC_1_UP_CONV_RELU_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }

      dec_1_up_conv_relu[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }

  //--------------------------dec_1_concatenate---------------------------------
  for(int i=0; i<DEC_1_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_1_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      dec_1_concatenate[i][k] = enc_2_conv_relu_1[i][k];
      dec_1_concatenate[i][k+DEC_1_UP_CONV_RELU_OUTPUT_FEATURES] = dec_1_up_conv_relu[i][k];
    }
  }

  //-------------------------dec_1_conv_relu_0----------------------------------
  for(int k=0; k<DEC_1_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<DEC_1_CONV_RELU_0_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_1_CONV_RELU_0_K/2);
      l_max = min(DEC_1_CONV_RELU_0_N, i + DEC_1_CONV_RELU_0_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_1_CONV_RELU_0_INPUT_FEATURES; j++){
          acc += dec_1_concatenate[l][j]*dec_1_conv_relu_0_w[k*DEC_1_CONV_RELU_0_K*DEC_1_CONV_RELU_0_INPUT_FEATURES+(l-i+DEC_1_CONV_RELU_0_K/2)*DEC_1_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }

      dec_1_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }

  //-------------------------dec_1_conv_relu_1----------------------------------
  for(int k=0; k<DEC_1_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<DEC_1_CONV_RELU_1_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_1_CONV_RELU_1_K/2);
      l_max = min(DEC_1_CONV_RELU_1_N, i + DEC_1_CONV_RELU_1_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_1_CONV_RELU_1_INPUT_FEATURES; j++){
          acc += dec_1_conv_relu_0[l][j]*dec_1_conv_relu_1_w[k*DEC_1_CONV_RELU_1_K*DEC_1_CONV_RELU_1_INPUT_FEATURES+(l-i+DEC_1_CONV_RELU_1_K/2)*DEC_1_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }

      dec_1_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-----------------------------DECODER 2--------------------------------------
  //-----------------------------dec_2_upsample---------------------------------
  for(int i=0; i<DEC_2_UP_CONV_RELU_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_2_UP_CONV_RELU_INPUT_FEATURES; k++){  // Iterate over the number of filters
      dec_2_upsample[2*i][k] = dec_1_conv_relu_1[i][k];
      dec_2_upsample[2*i+1][k] = dec_1_conv_relu_1[i][k];
    }
  }

  //-------------------------dec_2_up_conv_relu----------------------------------
  for(int k=0; k<DEC_2_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<DEC_2_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_2_UP_CONV_RELU_K/2);
      l_max = min(DEC_2_UP_CONV_RELU_N, i + DEC_2_UP_CONV_RELU_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_2_UP_CONV_RELU_INPUT_FEATURES; j++){
          acc += dec_2_upsample[l][j]*dec_2_up_conv_relu_w[k*DEC_2_UP_CONV_RELU_K*DEC_2_UP_CONV_RELU_INPUT_FEATURES+(l-i+DEC_2_UP_CONV_RELU_K/2)*DEC_2_UP_CONV_RELU_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }

      dec_2_up_conv_relu[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }

  //--------------------------dec_2_concatenate---------------------------------
  for(int i=0; i<DEC_2_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_2_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      dec_2_concatenate[i][k] = enc_1_conv_relu_1[i][k];
      dec_2_concatenate[i][k+DEC_2_UP_CONV_RELU_OUTPUT_FEATURES] = dec_2_up_conv_relu[i][k];
    }
  }

  //-------------------------dec_2_conv_relu_0----------------------------------
  for(int k=0; k<DEC_2_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<DEC_2_CONV_RELU_0_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_2_CONV_RELU_0_K/2);
      l_max = min(DEC_2_CONV_RELU_0_N, i + DEC_2_CONV_RELU_0_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_2_CONV_RELU_0_INPUT_FEATURES; j++){
          acc += dec_2_concatenate[l][j]*dec_2_conv_relu_0_w[k*DEC_2_CONV_RELU_0_K*DEC_2_CONV_RELU_0_INPUT_FEATURES+(l-i+DEC_2_CONV_RELU_0_K/2)*DEC_2_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }

      dec_2_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }

  //-------------------------dec_2_conv_relu_1----------------------------------
  for(int k=0; k<DEC_2_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<DEC_2_CONV_RELU_1_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_2_CONV_RELU_1_K/2);
      l_max = min(DEC_2_CONV_RELU_1_N, i + DEC_2_CONV_RELU_1_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_2_CONV_RELU_1_INPUT_FEATURES; j++){
          acc += dec_2_conv_relu_0[l][j]*dec_2_conv_relu_1_w[k*DEC_2_CONV_RELU_1_K*DEC_2_CONV_RELU_1_INPUT_FEATURES+(l-i+DEC_2_CONV_RELU_1_K/2)*DEC_2_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }

      dec_2_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-----------------------------DECODER 3--------------------------------------
  //-----------------------------dec_3_upsample---------------------------------
  for(int i=0; i<DEC_3_UP_CONV_RELU_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_3_UP_CONV_RELU_INPUT_FEATURES; k++){  // Iterate over the number of filters
      dec_3_upsample[2*i][k] = dec_2_conv_relu_1[i][k];
      dec_3_upsample[2*i+1][k] = dec_2_conv_relu_1[i][k];
    }
  }

  //-------------------------dec_3_up_conv_relu----------------------------------
  for(int k=0; k<DEC_3_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<DEC_3_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_3_UP_CONV_RELU_K/2);
      l_max = min(DEC_3_UP_CONV_RELU_N, i + DEC_3_UP_CONV_RELU_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_3_UP_CONV_RELU_INPUT_FEATURES; j++){
          acc += dec_3_upsample[l][j]*dec_3_up_conv_relu_w[k*DEC_3_UP_CONV_RELU_K*DEC_3_UP_CONV_RELU_INPUT_FEATURES+(l-i+DEC_3_UP_CONV_RELU_K/2)*DEC_3_UP_CONV_RELU_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }

      dec_3_up_conv_relu[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }

  //--------------------------dec_3_concatenate---------------------------------
  for(int i=0; i<DEC_3_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_3_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      dec_3_concatenate[i][k] = enc_0_conv_relu_1[i][k];
      dec_3_concatenate[i][k+DEC_3_UP_CONV_RELU_OUTPUT_FEATURES] = dec_3_up_conv_relu[i][k];
    }
  }

  //-------------------------dec_3_conv_relu_0----------------------------------
  for(int k=0; k<DEC_3_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<DEC_3_CONV_RELU_0_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_3_CONV_RELU_0_K/2);
      l_max = min(DEC_3_CONV_RELU_0_N, i + DEC_3_CONV_RELU_0_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_3_CONV_RELU_0_INPUT_FEATURES; j++){
          acc += dec_3_concatenate[l][j]*dec_3_conv_relu_0_w[k*DEC_3_CONV_RELU_0_K*DEC_3_CONV_RELU_0_INPUT_FEATURES+(l-i+DEC_3_CONV_RELU_0_K/2)*DEC_3_CONV_RELU_0_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }

      dec_3_conv_relu_0[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }

  //-------------------------dec_3_conv_relu_1----------------------------------
  for(int k=0; k<DEC_3_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<DEC_3_CONV_RELU_1_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - DEC_3_CONV_RELU_1_K/2);
      l_max = min(DEC_3_CONV_RELU_1_N, i + DEC_3_CONV_RELU_1_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_3_CONV_RELU_1_INPUT_FEATURES; j++){
          acc += dec_3_conv_relu_0[l][j]*dec_3_conv_relu_1_w[k*DEC_3_CONV_RELU_1_K*DEC_3_CONV_RELU_1_INPUT_FEATURES+(l-i+DEC_3_CONV_RELU_1_K/2)*DEC_3_CONV_RELU_1_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }

      dec_3_conv_relu_1[i][k] = ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //----------------------------FINAL CONV--------------------------------------
  for(int k=0; k<FINAL_CONV_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<FINAL_CONV_N; i++){  // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - FINAL_CONV_K/2);
      l_max = min(FINAL_CONV_N, i + FINAL_CONV_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<FINAL_CONV_INPUT_FEATURES; j++){
          acc += dec_3_conv_relu_1[l][j]*final_conv_w[k*FINAL_CONV_K*FINAL_CONV_INPUT_FEATURES+(l-i+FINAL_CONV_K/2)*FINAL_CONV_INPUT_FEATURES+j];  // Multiply the input and the weight
        }
      }

      final_conv[i][k] = acc; // Save the accumulator value
    }  
  }

  //----------------------------softmax-----------------------------------------
  for(int i=0; i<FINAL_CONV_N; i++){  // Iterate over the input matrix
    Softmax(final_conv[i], y[i]);
  }
  //----------------------------------------------------------------------------

  //CALLGRIND_STOP_INSTRUMENTATION;
}