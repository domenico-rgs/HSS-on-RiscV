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

void check_over(int32_t val, int layer){
    if(val>INT16_MAX || val<INT16_MIN){
        printf("Overflow at layer %d\n",layer);
    }
}

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

  // Arrays for feature maps
  datatype array_1[1024];
  datatype array_2[1024];
  
  //Skip connections
  datatype enc_0_conv_relu_1[ENC_0_CONV_RELU_1_N][ENC_0_CONV_RELU_1_OUTPUT_FEATURES];
  datatype enc_1_conv_relu_1[ENC_1_CONV_RELU_1_N][ENC_1_CONV_RELU_1_OUTPUT_FEATURES];
  datatype enc_2_conv_relu_1[ENC_2_CONV_RELU_1_N][ENC_2_CONV_RELU_1_OUTPUT_FEATURES];
  datatype enc_3_conv_relu_1[ENC_3_CONV_RELU_1_N][ENC_3_CONV_RELU_1_OUTPUT_FEATURES];

  // The accumulator
  #ifdef FP16INT
    int32_t acc;
  #else
    datatype acc;
  #endif 

  // Two auxiliary variables for the fitter's positions
  int l_min;
  int l_max;

  //-----------------------------ENCODER 0--------------------------------------
  //-------------------------enc_0_conv_relu_0----------------------------------
  for(int k=0; k<ENC_0_CONV_RELU_0_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<ENC_0_CONV_RELU_0_N; i++){    // Iterate over the input matrix
      acc = 0; // Reset the accumulator//check

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_0_CONV_RELU_0_K/2);
      l_max = min(ENC_0_CONV_RELU_0_N, i + ENC_0_CONV_RELU_0_K/2 + 1);
      
      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_0_CONV_RELU_0_INPUT_FEATURES; j++){
          acc += (x[l*ENC_0_CONV_RELU_0_INPUT_FEATURES+j]*enc_0_conv_relu_0_w[k*ENC_0_CONV_RELU_0_K*ENC_0_CONV_RELU_0_INPUT_FEATURES+(l-i+ENC_0_CONV_RELU_0_K/2)*ENC_0_CONV_RELU_0_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP;
        }
      }
      
      //check_over(acc,0);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }

      array_1[i*ENC_0_CONV_RELU_0_OUTPUT_FEATURES+k] = (datatype)ReLU(acc); // Save the accumulator value
    }  
  }
               
  //-------------------------enc_0_conv_relu_1----------------------------------
  for(int k=0; k<ENC_0_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
    for(int i=0; i<ENC_0_CONV_RELU_1_N; i++){    // Iterate over the input matrix
      acc = 0; // Reset the accumulator

      // Calculate the auxiliary positions respect to the input
      l_min = max(0, i - ENC_0_CONV_RELU_1_K/2);
      l_max = min(ENC_0_CONV_RELU_1_N, i + ENC_0_CONV_RELU_1_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_0_CONV_RELU_1_INPUT_FEATURES; j++){
          acc += (array_1[l*ENC_0_CONV_RELU_0_OUTPUT_FEATURES+j]*enc_0_conv_relu_1_w[k*ENC_0_CONV_RELU_1_K*ENC_0_CONV_RELU_1_INPUT_FEATURES+(l-i+ENC_0_CONV_RELU_1_K/2)*ENC_0_CONV_RELU_1_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP; // Multiply the input and the weight
          
        }
      }

      //check_over(acc,1);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      enc_0_conv_relu_1[i][k] = (datatype)ReLU(acc); // Save the accumulator value
    }  
  }

  //-----------------------------enc_0_maxpool----------------------------------
  for(int i=0; i<ENC_0_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<ENC_0_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      array_1[i*ENC_0_CONV_RELU_1_OUTPUT_FEATURES+k] = max(enc_0_conv_relu_1[2*i][k], enc_0_conv_relu_1[2*i+1][k]);
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
          acc += (array_1[l*ENC_0_CONV_RELU_1_OUTPUT_FEATURES+j]*enc_1_conv_relu_0_w[k*ENC_1_CONV_RELU_0_K*ENC_1_CONV_RELU_0_INPUT_FEATURES+(l-i+ENC_1_CONV_RELU_0_K/2)*ENC_1_CONV_RELU_0_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP;  // Multiply the input and the weight
          
        }
      }

      //check_over(acc,2);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      array_2[i*ENC_1_CONV_RELU_0_OUTPUT_FEATURES+k] = (datatype)ReLU(acc); // Save the accumulator value
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
          acc += (array_2[l*ENC_1_CONV_RELU_0_OUTPUT_FEATURES+j]*enc_1_conv_relu_1_w[k*ENC_1_CONV_RELU_1_K*ENC_1_CONV_RELU_1_INPUT_FEATURES+(l-i+ENC_1_CONV_RELU_1_K/2)*ENC_1_CONV_RELU_1_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP;  // Multiply the input and the weight
          
        }
      }

      //check_over(acc,3);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      enc_1_conv_relu_1[i][k] = (datatype)ReLU(acc); // Save the accumulator value
    }  
  }


  //-----------------------------enc_1_maxpool----------------------------------
  for(int i=0; i<ENC_1_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<ENC_1_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      array_2[i*ENC_1_CONV_RELU_1_OUTPUT_FEATURES+k] = max(enc_1_conv_relu_1[2*i][k], enc_1_conv_relu_1[2*i+1][k]);
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
          acc += (array_2[l*ENC_1_CONV_RELU_1_OUTPUT_FEATURES+j]*enc_2_conv_relu_0_w[k*ENC_2_CONV_RELU_0_K*ENC_2_CONV_RELU_0_INPUT_FEATURES+(l-i+ENC_2_CONV_RELU_0_K/2)*ENC_2_CONV_RELU_0_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP;  // Multiply the input and the weight
          
        }
      }

      //check_over(acc,4);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      array_1[i*ENC_2_CONV_RELU_0_OUTPUT_FEATURES+k] = (datatype)ReLU(acc); // Save the accumulator value
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
          acc += (array_1[l*ENC_2_CONV_RELU_0_OUTPUT_FEATURES+j]*enc_2_conv_relu_1_w[k*ENC_2_CONV_RELU_1_K*ENC_2_CONV_RELU_1_INPUT_FEATURES+(l-i+ENC_2_CONV_RELU_1_K/2)*ENC_2_CONV_RELU_1_INPUT_FEATURES+j] + (1<<((FXP-1))) )>>FXP;  // Multiply the input and the weight
          
        }
      }

      //check_over(acc,5);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      enc_2_conv_relu_1[i][k] = (datatype)ReLU(acc); // Save the accumulator value
    }  
  }

  //-----------------------------enc_2_maxpool----------------------------------
  for(int i=0; i<ENC_2_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<ENC_2_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      array_1[i*ENC_2_CONV_RELU_1_OUTPUT_FEATURES+k] = max(enc_2_conv_relu_1[2*i][k], enc_2_conv_relu_1[2*i+1][k]);
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
          acc += (array_1[l*ENC_2_CONV_RELU_1_OUTPUT_FEATURES+j]*enc_3_conv_relu_0_w[k*ENC_3_CONV_RELU_0_K*ENC_3_CONV_RELU_0_INPUT_FEATURES+(l-i+ENC_3_CONV_RELU_0_K/2)*ENC_3_CONV_RELU_0_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP;  // Multiply the input and the weight
          
        }
      }

      //check_over(acc,6);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      array_2[i*ENC_3_CONV_RELU_0_OUTPUT_FEATURES+k] = (datatype)ReLU(acc); // Save the accumulator value
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
          acc += (array_2[l*ENC_3_CONV_RELU_0_OUTPUT_FEATURES+j]*enc_3_conv_relu_1_w[k*ENC_3_CONV_RELU_1_K*ENC_3_CONV_RELU_1_INPUT_FEATURES+(l-i+ENC_3_CONV_RELU_1_K/2)*ENC_3_CONV_RELU_1_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP;  // Multiply the input and the weight
        }
      }

      //check_over(acc,7);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      enc_3_conv_relu_1[i][k] = (datatype)ReLU(acc); // Save the accumulator value
    }  
  }

  //-----------------------------enc_3_maxpool----------------------------------
  for(int i=0; i<ENC_3_CONV_RELU_1_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<ENC_3_CONV_RELU_1_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      array_2[i*ENC_3_CONV_RELU_1_OUTPUT_FEATURES+k] = max(enc_3_conv_relu_1[2*i][k], enc_3_conv_relu_1[2*i+1][k]);
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
          acc += (array_2[l*ENC_3_CONV_RELU_1_OUTPUT_FEATURES+j]*central_conv_relu_0_w[k*CENTRAL_CONV_RELU_0_K*CENTRAL_CONV_RELU_0_INPUT_FEATURES+(l-i+CENTRAL_CONV_RELU_0_K/2)*CENTRAL_CONV_RELU_0_INPUT_FEATURES+j]  + (1<<((FXP-1))))>>FXP;  // Multiply the input and the weight
          
        }
      }

      //check_over(acc,8);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      array_1[i*CENTRAL_CONV_RELU_0_OUTPUT_FEATURES+k] = (datatype)ReLU(acc); // Save the accumulator value
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
          acc += (array_1[l*CENTRAL_CONV_RELU_0_OUTPUT_FEATURES+j]*central_conv_relu_1_w[k*CENTRAL_CONV_RELU_1_K*CENTRAL_CONV_RELU_1_INPUT_FEATURES+(l-i+CENTRAL_CONV_RELU_1_K/2)*CENTRAL_CONV_RELU_1_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP;  // Multiply the input and the weight
        }
      }

      //check_over(acc,9);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      array_2[i*CENTRAL_CONV_RELU_1_OUTPUT_FEATURES+k] = (datatype)ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-----------------------------DECODER 0--------------------------------------
  //-----------------------------dec_0_upsample---------------------------------
  for(int i=0; i<DEC_0_UP_CONV_RELU_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_0_UP_CONV_RELU_INPUT_FEATURES; k++){  // Iterate over the number of filters
      array_1[(2*i)*DEC_0_UP_CONV_RELU_INPUT_FEATURES+k] = array_2[i*CENTRAL_CONV_RELU_0_OUTPUT_FEATURES+k];
      array_1[(2*i+1)*DEC_0_UP_CONV_RELU_INPUT_FEATURES+k] = array_2[i*CENTRAL_CONV_RELU_0_OUTPUT_FEATURES+k];
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
          acc += (array_1[l*DEC_0_UP_CONV_RELU_INPUT_FEATURES+j]*dec_0_up_conv_relu_w[k*DEC_0_UP_CONV_RELU_K*DEC_0_UP_CONV_RELU_INPUT_FEATURES+(l-i+DEC_0_UP_CONV_RELU_K/2)*DEC_0_UP_CONV_RELU_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP;  // Multiply the input and the weight
          
        }
      }

      //check_over(acc,10);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      array_2[i*DEC_0_UP_CONV_RELU_OUTPUT_FEATURES+k] = (datatype)ReLU(acc); // Save the accumulator value
    }  
  }


//--------------------------dec_0_concatenate---------------------------------
  for(int i=0; i<DEC_0_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_0_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      array_1[i*(DEC_0_UP_CONV_RELU_OUTPUT_FEATURES*2)+k] = enc_3_conv_relu_1[i][k]; //Q12
      array_1[i*(DEC_0_UP_CONV_RELU_OUTPUT_FEATURES*2)+(k+DEC_0_UP_CONV_RELU_OUTPUT_FEATURES)] = array_2[i*DEC_0_UP_CONV_RELU_OUTPUT_FEATURES+k]; //Q12
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
          acc += (array_1[l*(DEC_0_UP_CONV_RELU_OUTPUT_FEATURES*2)+j]*dec_0_conv_relu_0_w[k*DEC_0_CONV_RELU_0_K*DEC_0_CONV_RELU_0_INPUT_FEATURES+(l-i+DEC_0_CONV_RELU_0_K/2)*DEC_0_CONV_RELU_0_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP;  // Multiply the input and the weight
          
        }
      }

      //check_over(acc,11);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      array_2[i*DEC_0_CONV_RELU_0_OUTPUT_FEATURES+k] = (datatype)ReLU(acc); // Save the accumulator value
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
          acc += (array_2[l*DEC_0_CONV_RELU_0_OUTPUT_FEATURES+j]*dec_0_conv_relu_1_w[k*DEC_0_CONV_RELU_1_K*DEC_0_CONV_RELU_1_INPUT_FEATURES+(l-i+DEC_0_CONV_RELU_1_K/2)*DEC_0_CONV_RELU_1_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP;  // Multiply the input and the weight
          
        }
      }

      //check_over(acc,12);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      array_1[i*DEC_0_CONV_RELU_1_OUTPUT_FEATURES+k] = (datatype)ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------
    
  //-----------------------------DECODER 1--------------------------------------
  //-----------------------------dec_1_upsample---------------------------------
  for(int i=0; i<DEC_1_UP_CONV_RELU_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_1_UP_CONV_RELU_INPUT_FEATURES; k++){  // Iterate over the number of filters
      array_2[(2*i)*DEC_1_UP_CONV_RELU_INPUT_FEATURES+k] = array_1[i*DEC_0_CONV_RELU_0_OUTPUT_FEATURES+k];
      array_2[(2*i+1)*DEC_1_UP_CONV_RELU_INPUT_FEATURES+k] = array_1[i*DEC_0_CONV_RELU_0_OUTPUT_FEATURES+k];
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
          acc += (array_2[l*DEC_1_UP_CONV_RELU_INPUT_FEATURES+j]*dec_1_up_conv_relu_w[k*DEC_1_UP_CONV_RELU_K*DEC_1_UP_CONV_RELU_INPUT_FEATURES+(l-i+DEC_1_UP_CONV_RELU_K/2)*DEC_1_UP_CONV_RELU_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP;  // Multiply the input and the weight
          
        }
      }

      //check_over(acc,13);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      array_1[i*DEC_1_UP_CONV_RELU_OUTPUT_FEATURES+k] = (datatype)ReLU(acc); // Save the accumulator value
    }  
  }

  //--------------------------dec_1_concatenate---------------------------------
  for(int i=0; i<DEC_1_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_1_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      array_2[i*(DEC_1_UP_CONV_RELU_OUTPUT_FEATURES*2)+k] = enc_2_conv_relu_1[i][k]; //Q12
      array_2[i*(DEC_1_UP_CONV_RELU_OUTPUT_FEATURES*2)+(k+DEC_1_UP_CONV_RELU_OUTPUT_FEATURES)] = array_1[i*DEC_1_UP_CONV_RELU_OUTPUT_FEATURES+k]; //Q12
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
          acc += (array_2[l*(DEC_1_UP_CONV_RELU_OUTPUT_FEATURES*2)+j]*dec_1_conv_relu_0_w[k*DEC_1_CONV_RELU_0_K*DEC_1_CONV_RELU_0_INPUT_FEATURES+(l-i+DEC_1_CONV_RELU_0_K/2)*DEC_1_CONV_RELU_0_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP;  // Multiply the input and the weight
          
        }
      }

      //check_over(acc,14);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      array_1[i*DEC_1_CONV_RELU_0_OUTPUT_FEATURES+k] = (datatype)ReLU(acc); // Save the accumulator value
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
          acc += (array_1[l*DEC_1_CONV_RELU_0_OUTPUT_FEATURES+j]*dec_1_conv_relu_1_w[k*DEC_1_CONV_RELU_1_K*DEC_1_CONV_RELU_1_INPUT_FEATURES+(l-i+DEC_1_CONV_RELU_1_K/2)*DEC_1_CONV_RELU_1_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP;  // Multiply the input and the weight
          
        }
      }

      //check_over(acc,15);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      array_2[i*DEC_1_CONV_RELU_1_OUTPUT_FEATURES+k] = (datatype)ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-----------------------------DECODER 2--------------------------------------
  //-----------------------------dec_2_upsample---------------------------------
  for(int i=0; i<DEC_2_UP_CONV_RELU_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_2_UP_CONV_RELU_INPUT_FEATURES; k++){  // Iterate over the number of filters
      array_1[(2*i)*DEC_2_UP_CONV_RELU_INPUT_FEATURES+k] = array_2[i*DEC_1_CONV_RELU_1_OUTPUT_FEATURES+k];
      array_1[(2*i+1)*DEC_2_UP_CONV_RELU_INPUT_FEATURES+k] = array_2[i*DEC_1_CONV_RELU_1_OUTPUT_FEATURES+k];
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
          acc += (array_1[l*DEC_2_UP_CONV_RELU_INPUT_FEATURES+j]*dec_2_up_conv_relu_w[k*DEC_2_UP_CONV_RELU_K*DEC_2_UP_CONV_RELU_INPUT_FEATURES+(l-i+DEC_2_UP_CONV_RELU_K/2)*DEC_2_UP_CONV_RELU_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP;  // Multiply the input and the weight
          
        }
      }

      //check_over(acc,16);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      array_2[i*DEC_2_UP_CONV_RELU_OUTPUT_FEATURES+k] = (datatype)ReLU(acc); // Save the accumulator value
    }  
  }

  //--------------------------dec_2_concatenate---------------------------------
  for(int i=0; i<DEC_2_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_2_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      array_1[i*(DEC_2_UP_CONV_RELU_OUTPUT_FEATURES*2)+k] = enc_1_conv_relu_1[i][k]; //Q13
      array_1[i*(DEC_2_UP_CONV_RELU_OUTPUT_FEATURES*2)+(k+DEC_2_UP_CONV_RELU_OUTPUT_FEATURES)] = array_2[i*DEC_2_UP_CONV_RELU_OUTPUT_FEATURES+k]; //Q13
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
          acc += (array_1[l*(DEC_2_UP_CONV_RELU_OUTPUT_FEATURES*2)+j]*dec_2_conv_relu_0_w[k*DEC_2_CONV_RELU_0_K*DEC_2_CONV_RELU_0_INPUT_FEATURES+(l-i+DEC_2_CONV_RELU_0_K/2)*DEC_2_CONV_RELU_0_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP;  // Multiply the input and the weight
          
        }
      }

      //check_over(acc,17);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      array_2[i*DEC_2_CONV_RELU_0_OUTPUT_FEATURES+k] = (datatype)ReLU(acc); // Save the accumulator value
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
          acc += (array_2[l*DEC_2_CONV_RELU_0_OUTPUT_FEATURES+j]*dec_2_conv_relu_1_w[k*DEC_2_CONV_RELU_1_K*DEC_2_CONV_RELU_1_INPUT_FEATURES+(l-i+DEC_2_CONV_RELU_1_K/2)*DEC_2_CONV_RELU_1_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP;  // Multiply the input and the weight
          
        }
      }

      //check_over(acc,18);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      array_1[i*DEC_2_CONV_RELU_1_OUTPUT_FEATURES+k] = (datatype)ReLU(acc); // Save the accumulator value
    }  
  }
  //----------------------------------------------------------------------------

  //-----------------------------DECODER 3--------------------------------------
  //-----------------------------dec_3_upsample---------------------------------
  for(int i=0; i<DEC_3_UP_CONV_RELU_N/2; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_3_UP_CONV_RELU_INPUT_FEATURES; k++){  // Iterate over the number of filters
      array_2[(2*i)*DEC_3_UP_CONV_RELU_INPUT_FEATURES+k] = array_1[i*DEC_2_CONV_RELU_1_OUTPUT_FEATURES+k];
      array_2[(2*i+1)*DEC_3_UP_CONV_RELU_INPUT_FEATURES+k] = array_1[i*DEC_2_CONV_RELU_1_OUTPUT_FEATURES+k];
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
          acc += (array_2[l*DEC_3_UP_CONV_RELU_INPUT_FEATURES+j]*dec_3_up_conv_relu_w[k*DEC_3_UP_CONV_RELU_K*DEC_3_UP_CONV_RELU_INPUT_FEATURES+(l-i+DEC_3_UP_CONV_RELU_K/2)*DEC_3_UP_CONV_RELU_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP;  // Multiply the input and the weight
          
        }
      }

      //check_over(acc,19);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      array_1[i*DEC_3_UP_CONV_RELU_OUTPUT_FEATURES+k] = (datatype)ReLU(acc); // Save the accumulator value
    }  
  }

  //--------------------------dec_3_concatenate---------------------------------
  for(int i=0; i<DEC_3_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_3_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      array_2[i*(DEC_3_UP_CONV_RELU_OUTPUT_FEATURES*2)+k] = enc_0_conv_relu_1[i][k]; //Q12
      array_2[i*(DEC_3_UP_CONV_RELU_OUTPUT_FEATURES*2)+(k+DEC_3_UP_CONV_RELU_OUTPUT_FEATURES)] = array_1[i*DEC_3_UP_CONV_RELU_OUTPUT_FEATURES+k]; //Q12
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
          acc += (array_2[l*(DEC_3_UP_CONV_RELU_OUTPUT_FEATURES*2)+j]*dec_3_conv_relu_0_w[k*DEC_3_CONV_RELU_0_K*DEC_3_CONV_RELU_0_INPUT_FEATURES+(l-i+DEC_3_CONV_RELU_0_K/2)*DEC_3_CONV_RELU_0_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP;  // Multiply the input and the weight
          
        }
      }

      //check_over(acc,20);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      array_1[i*DEC_3_CONV_RELU_0_OUTPUT_FEATURES+k] = (datatype)ReLU(acc); // Save the accumulator value
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
          acc += (array_1[l*DEC_3_CONV_RELU_0_OUTPUT_FEATURES+j]*dec_3_conv_relu_1_w[k*DEC_3_CONV_RELU_1_K*DEC_3_CONV_RELU_1_INPUT_FEATURES+(l-i+DEC_3_CONV_RELU_1_K/2)*DEC_3_CONV_RELU_1_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP;  // Multiply the input and the weight
          
        }
      }

      //check_over(acc,21);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      array_2[i*DEC_3_CONV_RELU_1_OUTPUT_FEATURES+k] = (datatype)ReLU(acc); // Save the accumulator value
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
          acc += (array_2[l*DEC_3_CONV_RELU_1_OUTPUT_FEATURES+j]*final_conv_w[k*FINAL_CONV_K*FINAL_CONV_INPUT_FEATURES+(l-i+FINAL_CONV_K/2)*FINAL_CONV_INPUT_FEATURES+j] + (1<<((FXP-1))))>>FXP;  // Multiply the input and the weight
          
        }
      }

      //check_over(acc,22);
      if(acc>INT16_MAX){
        acc = INT16_MAX;
      }else if(acc<INT16_MIN){
        acc = INT16_MIN;
      }
      array_1[i*FINAL_CONV_OUTPUT_FEATURES+k] = (datatype)acc; // Save the accumulator value
    }  
  }

  //----------------------------softmax-----------------------------------------
  for(int i=0; i<FINAL_CONV_N; i++){  // Iterate over the input matrix
    Argmax((array_1+i*N_STATES), y[i]);
  }
  //----------------------------------------------------------------------------
}