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

void Segmenter(float *x,
               float *enc_0_conv_relu_0_w, float *enc_0_conv_relu_1_w, float *enc_1_conv_relu_0_w,
               float *enc_1_conv_relu_1_w, float *enc_2_conv_relu_0_w, float *enc_2_conv_relu_1_w,
               float *enc_3_conv_relu_0_w, float *enc_3_conv_relu_1_w, float *central_conv_relu_0_w,
               float *central_conv_relu_1_w, float *dec_0_up_conv_relu_w, float *dec_0_conv_relu_0_w,
               float *dec_0_conv_relu_1_w, float *dec_1_up_conv_relu_w, float *dec_1_conv_relu_0_w,
               float *dec_1_conv_relu_1_w, float *dec_2_up_conv_relu_w, float *dec_2_conv_relu_0_w, 
               float *dec_2_conv_relu_1_w, float *dec_3_up_conv_relu_w, float *dec_3_conv_relu_0_w,
               float *dec_3_conv_relu_1_w, float *final_conv_w, float *y){

  // Initialize the feature maps
  float *enc_0_conv_relu_0 = (float *)malloc(sizeof(float) * ENC_0_CONV_RELU_0_N * ENC_0_CONV_RELU_0_OUTPUT_FEATURES);
  float *enc_0_conv_relu_1 = (float *)malloc(sizeof(float) * ENC_0_CONV_RELU_1_N * ENC_0_CONV_RELU_1_OUTPUT_FEATURES);
  
  float *enc_0_maxpool = (float *)malloc(sizeof(float) * (ENC_0_CONV_RELU_1_N/2) * ENC_0_CONV_RELU_1_OUTPUT_FEATURES);

  float *enc_1_conv_relu_0 = (float *)malloc(sizeof(float) * ENC_1_CONV_RELU_0_N * ENC_1_CONV_RELU_0_OUTPUT_FEATURES);
  float *enc_1_conv_relu_1 = (float *)malloc(sizeof(float) * ENC_1_CONV_RELU_1_N * ENC_1_CONV_RELU_1_OUTPUT_FEATURES);
  float *enc_1_maxpool = (float *)malloc(sizeof(float) * (ENC_1_CONV_RELU_1_N/2) * ENC_1_CONV_RELU_1_OUTPUT_FEATURES);

  float *enc_2_conv_relu_0 = (float *)malloc(sizeof(float) * ENC_2_CONV_RELU_0_N * ENC_2_CONV_RELU_0_OUTPUT_FEATURES);
  float *enc_2_conv_relu_1 = (float *)malloc(sizeof(float) * ENC_2_CONV_RELU_1_N * ENC_2_CONV_RELU_1_OUTPUT_FEATURES);
  float *enc_2_maxpool = (float *)malloc(sizeof(float) * (ENC_2_CONV_RELU_1_N/2) * ENC_2_CONV_RELU_1_OUTPUT_FEATURES);

  float *enc_3_conv_relu_0 = (float *)malloc(sizeof(float) * ENC_3_CONV_RELU_0_N * ENC_3_CONV_RELU_0_OUTPUT_FEATURES);
  float *enc_3_conv_relu_1 = (float *)malloc(sizeof(float) * ENC_3_CONV_RELU_1_N * ENC_3_CONV_RELU_1_OUTPUT_FEATURES);
  float *enc_3_maxpool = (float *)malloc(sizeof(float) * (ENC_3_CONV_RELU_1_N/2) * ENC_3_CONV_RELU_1_OUTPUT_FEATURES);

  float *central_conv_relu_0 = (float *)malloc(sizeof(float) * CENTRAL_CONV_RELU_0_N * CENTRAL_CONV_RELU_0_OUTPUT_FEATURES);
  float *central_conv_relu_1 = (float *)malloc(sizeof(float) * CENTRAL_CONV_RELU_1_N * CENTRAL_CONV_RELU_1_OUTPUT_FEATURES);

  float *dec_0_upsample = (float *)malloc(sizeof(float) * DEC_0_UP_CONV_RELU_N * DEC_0_UP_CONV_RELU_INPUT_FEATURES);
  float *dec_0_up_conv_relu = (float *)malloc(sizeof(float) * DEC_0_UP_CONV_RELU_N * DEC_0_UP_CONV_RELU_OUTPUT_FEATURES);
  float *dec_0_concatenate = (float *)malloc(sizeof(float) * DEC_0_UP_CONV_RELU_N * DEC_0_UP_CONV_RELU_OUTPUT_FEATURES*2);
  float *dec_0_conv_relu_0 = (float *)malloc(sizeof(float) * DEC_0_CONV_RELU_0_N * DEC_0_CONV_RELU_0_OUTPUT_FEATURES);
  float *dec_0_conv_relu_1 = (float *)malloc(sizeof(float) * DEC_0_CONV_RELU_1_N * DEC_0_CONV_RELU_1_OUTPUT_FEATURES);

  float *dec_1_upsample = (float *)malloc(sizeof(float) * DEC_1_UP_CONV_RELU_N * DEC_1_UP_CONV_RELU_INPUT_FEATURES);
  float *dec_1_up_conv_relu = (float *)malloc(sizeof(float) * DEC_1_UP_CONV_RELU_N * DEC_1_UP_CONV_RELU_OUTPUT_FEATURES);
  float *dec_1_concatenate = (float *)malloc(sizeof(float) * DEC_1_UP_CONV_RELU_N * DEC_1_UP_CONV_RELU_OUTPUT_FEATURES*2);
  float *dec_1_conv_relu_0 = (float *)malloc(sizeof(float) * DEC_1_CONV_RELU_0_N * DEC_1_CONV_RELU_0_OUTPUT_FEATURES);
  float *dec_1_conv_relu_1 = (float *)malloc(sizeof(float) * DEC_1_CONV_RELU_1_N * DEC_1_CONV_RELU_1_OUTPUT_FEATURES);

  float *dec_2_upsample = (float *)malloc(sizeof(float) * DEC_2_UP_CONV_RELU_N * DEC_2_UP_CONV_RELU_INPUT_FEATURES);
  float *dec_2_up_conv_relu = (float *)malloc(sizeof(float) * DEC_2_UP_CONV_RELU_N * DEC_2_UP_CONV_RELU_OUTPUT_FEATURES);
  float *dec_2_concatenate = (float *)malloc(sizeof(float) * DEC_2_UP_CONV_RELU_N * DEC_2_UP_CONV_RELU_OUTPUT_FEATURES*2);
  float *dec_2_conv_relu_0 = (float *)malloc(sizeof(float) * DEC_2_CONV_RELU_0_N * DEC_2_CONV_RELU_0_OUTPUT_FEATURES);
  float *dec_2_conv_relu_1 = (float *)malloc(sizeof(float) * DEC_2_CONV_RELU_1_N * DEC_2_CONV_RELU_1_OUTPUT_FEATURES);

  float *dec_3_upsample = (float *)malloc(sizeof(float) * DEC_3_UP_CONV_RELU_N * DEC_3_UP_CONV_RELU_INPUT_FEATURES);
  float *dec_3_up_conv_relu = (float *)malloc(sizeof(float) * DEC_3_UP_CONV_RELU_N * DEC_3_UP_CONV_RELU_OUTPUT_FEATURES);
  float *dec_3_concatenate = (float *)malloc(sizeof(float) * DEC_3_UP_CONV_RELU_N * DEC_3_UP_CONV_RELU_OUTPUT_FEATURES*2);
  float *dec_3_conv_relu_0 = (float *)malloc(sizeof(float) * DEC_3_CONV_RELU_0_N * DEC_3_CONV_RELU_0_OUTPUT_FEATURES);
  float *dec_3_conv_relu_1 = (float *)malloc(sizeof(float) * DEC_3_CONV_RELU_1_N * DEC_3_CONV_RELU_1_OUTPUT_FEATURES);

  float *final_conv = (float *)malloc(sizeof(float) * FINAL_CONV_N * FINAL_CONV_OUTPUT_FEATURES);


  //-----------------------------ENCODER 0--------------------------------------
  //-------------------------enc_0_conv_relu_0----------------------------------
  conv_relu(ENC_0_CONV_RELU_0_OUTPUT_FEATURES,ENC_0_CONV_RELU_0_N,ENC_0_CONV_RELU_0_K,ENC_0_CONV_RELU_0_INPUT_FEATURES,enc_0_conv_relu_0_w,x,enc_0_conv_relu_0);
  //-------------------------enc_0_conv_relu_1----------------------------------
  conv_relu(ENC_0_CONV_RELU_1_OUTPUT_FEATURES,ENC_0_CONV_RELU_1_N,ENC_0_CONV_RELU_1_K,ENC_0_CONV_RELU_1_INPUT_FEATURES,enc_0_conv_relu_1_w,enc_0_conv_relu_0,enc_0_conv_relu_1);
  //-----------------------------enc_0_maxpool----------------------------------
  maxpooling(ENC_0_CONV_RELU_1_OUTPUT_FEATURES, ENC_0_CONV_RELU_1_N, enc_0_maxpool, enc_0_conv_relu_1);
  //----------------------------------------------------------------------------

  //-----------------------------ENCODER 1--------------------------------------
  //-------------------------enc_1_conv_relu_0----------------------------------
  conv_relu(ENC_1_CONV_RELU_0_OUTPUT_FEATURES,ENC_1_CONV_RELU_0_N,ENC_1_CONV_RELU_0_K,ENC_1_CONV_RELU_0_INPUT_FEATURES,enc_1_conv_relu_0_w,enc_0_maxpool,enc_1_conv_relu_0);
  //-------------------------enc_1_conv_relu_1----------------------------------
  conv_relu(ENC_1_CONV_RELU_1_OUTPUT_FEATURES,ENC_1_CONV_RELU_1_N,ENC_1_CONV_RELU_1_K,ENC_1_CONV_RELU_1_INPUT_FEATURES,enc_1_conv_relu_1_w,enc_1_conv_relu_0,enc_1_conv_relu_1);
  //-----------------------------enc_1_maxpool----------------------------------
  maxpooling(ENC_1_CONV_RELU_1_OUTPUT_FEATURES, ENC_1_CONV_RELU_1_N, enc_1_maxpool, enc_1_conv_relu_1);
  //----------------------------------------------------------------------------

  //-----------------------------ENCODER 2--------------------------------------
  //-------------------------enc_2_conv_relu_0----------------------------------
  conv_relu(ENC_2_CONV_RELU_0_OUTPUT_FEATURES,ENC_2_CONV_RELU_0_N,ENC_2_CONV_RELU_0_K,ENC_2_CONV_RELU_0_INPUT_FEATURES,enc_2_conv_relu_0_w,enc_1_maxpool,enc_2_conv_relu_0);
  //-------------------------enc_2_conv_relu_1----------------------------------
  conv_relu(ENC_2_CONV_RELU_1_OUTPUT_FEATURES,ENC_2_CONV_RELU_1_N,ENC_2_CONV_RELU_1_K,ENC_2_CONV_RELU_1_INPUT_FEATURES,enc_2_conv_relu_1_w,enc_2_conv_relu_0,enc_2_conv_relu_1);
  //-----------------------------enc_2_maxpool----------------------------------
  maxpooling(ENC_2_CONV_RELU_1_OUTPUT_FEATURES, ENC_2_CONV_RELU_1_N, enc_2_maxpool, enc_2_conv_relu_1);
  //----------------------------------------------------------------------------

  //-----------------------------ENCODER 3--------------------------------------
  //-------------------------enc_3_conv_relu_0----------------------------------
  conv_relu(ENC_3_CONV_RELU_0_OUTPUT_FEATURES,ENC_3_CONV_RELU_0_N,ENC_3_CONV_RELU_0_K,ENC_3_CONV_RELU_0_INPUT_FEATURES,enc_3_conv_relu_0_w,enc_2_maxpool,enc_3_conv_relu_0);
  //-------------------------enc_3_conv_relu_1----------------------------------
  conv_relu(ENC_3_CONV_RELU_1_OUTPUT_FEATURES,ENC_3_CONV_RELU_1_N,ENC_3_CONV_RELU_1_K,ENC_3_CONV_RELU_1_INPUT_FEATURES,enc_3_conv_relu_1_w,enc_3_conv_relu_0,enc_3_conv_relu_1);
  //-----------------------------enc_3_maxpool----------------------------------
  maxpooling(ENC_3_CONV_RELU_1_OUTPUT_FEATURES, ENC_3_CONV_RELU_1_N, enc_3_maxpool, enc_3_conv_relu_1);
  //----------------------------------------------------------------------------

  //--------------------------CENTRAL PART--------------------------------------
  //-------------------------central_conv_relu_0--------------------------------
  conv_relu(CENTRAL_CONV_RELU_0_OUTPUT_FEATURES,CENTRAL_CONV_RELU_0_N,CENTRAL_CONV_RELU_0_K,CENTRAL_CONV_RELU_0_INPUT_FEATURES,central_conv_relu_0_w,enc_3_maxpool,central_conv_relu_0);
  //-------------------------central_conv_relu_1--------------------------------
  conv_relu(CENTRAL_CONV_RELU_1_OUTPUT_FEATURES,CENTRAL_CONV_RELU_1_N,CENTRAL_CONV_RELU_1_K,CENTRAL_CONV_RELU_1_INPUT_FEATURES,central_conv_relu_1_w,central_conv_relu_0,central_conv_relu_1);
  //----------------------------------------------------------------------------

  //-----------------------------DECODER 0--------------------------------------
  //-----------------------------dec_0_upsample---------------------------------
  upsampling(DEC_0_UP_CONV_RELU_INPUT_FEATURES, DEC_0_UP_CONV_RELU_N, dec_0_upsample, central_conv_relu_1);
  //-------------------------dec_0_up_conv_relu---------------------------------
  conv_relu(DEC_0_UP_CONV_RELU_OUTPUT_FEATURES,DEC_0_UP_CONV_RELU_N,DEC_0_UP_CONV_RELU_K,DEC_0_UP_CONV_RELU_INPUT_FEATURES,dec_0_up_conv_relu_w,dec_0_upsample,dec_0_up_conv_relu);
  //--------------------------dec_0_concatenate---------------------------------
  concatenation(DEC_0_UP_CONV_RELU_OUTPUT_FEATURES,DEC_0_UP_CONV_RELU_N, dec_0_concatenate, enc_3_conv_relu_1,dec_0_up_conv_relu);
  //-------------------------dec_0_conv_relu_0----------------------------------
  conv_relu(DEC_0_CONV_RELU_0_OUTPUT_FEATURES,DEC_0_CONV_RELU_0_N,DEC_0_CONV_RELU_0_K,DEC_0_CONV_RELU_0_INPUT_FEATURES,dec_0_conv_relu_0_w,dec_0_concatenate,dec_0_conv_relu_0);
  //-------------------------dec_0_conv_relu_1----------------------------------
  conv_relu(DEC_0_CONV_RELU_1_OUTPUT_FEATURES,DEC_0_CONV_RELU_1_N,DEC_0_CONV_RELU_1_K,DEC_0_CONV_RELU_1_INPUT_FEATURES,dec_0_conv_relu_1_w,dec_0_conv_relu_0,dec_0_conv_relu_1);
  //----------------------------------------------------------------------------

  //-----------------------------DECODER 1--------------------------------------
  //-----------------------------dec_1_upsample---------------------------------
  upsampling(DEC_1_UP_CONV_RELU_INPUT_FEATURES, DEC_1_UP_CONV_RELU_N, dec_1_upsample, dec_0_conv_relu_1);
  //-------------------------dec_1_up_conv_relu---------------------------------
  conv_relu(DEC_1_UP_CONV_RELU_OUTPUT_FEATURES,DEC_1_UP_CONV_RELU_N,DEC_1_UP_CONV_RELU_K,DEC_1_UP_CONV_RELU_INPUT_FEATURES,dec_1_up_conv_relu_w,dec_1_upsample,dec_1_up_conv_relu);
  //--------------------------dec_1_concatenate---------------------------------
  concatenation(DEC_1_UP_CONV_RELU_OUTPUT_FEATURES,DEC_1_UP_CONV_RELU_N, dec_1_concatenate, enc_2_conv_relu_1,dec_1_up_conv_relu);
  //-------------------------dec_1_conv_relu_0----------------------------------
  conv_relu(DEC_1_CONV_RELU_0_OUTPUT_FEATURES,DEC_1_CONV_RELU_0_N,DEC_1_CONV_RELU_0_K,DEC_1_CONV_RELU_0_INPUT_FEATURES,dec_1_conv_relu_0_w,dec_1_concatenate,dec_1_conv_relu_0);
  //-------------------------dec_1_conv_relu_1----------------------------------
  conv_relu(DEC_1_CONV_RELU_1_OUTPUT_FEATURES,DEC_1_CONV_RELU_1_N,DEC_1_CONV_RELU_1_K,DEC_1_CONV_RELU_1_INPUT_FEATURES,dec_1_conv_relu_1_w,dec_1_concatenate,dec_1_conv_relu_1);
  //----------------------------------------------------------------------------

  //-----------------------------DECODER 2--------------------------------------
  //-----------------------------dec_2_upsample---------------------------------
  upsampling(DEC_2_UP_CONV_RELU_INPUT_FEATURES, DEC_2_UP_CONV_RELU_N, dec_2_upsample, dec_1_conv_relu_1);
  //-------------------------dec_2_up_conv_relu---------------------------------
  conv_relu(DEC_2_UP_CONV_RELU_OUTPUT_FEATURES,DEC_2_UP_CONV_RELU_N,DEC_2_UP_CONV_RELU_K,DEC_2_UP_CONV_RELU_INPUT_FEATURES,dec_2_up_conv_relu_w,dec_2_upsample,dec_2_up_conv_relu);
  //--------------------------dec_2_concatenate---------------------------------
  concatenation(DEC_2_UP_CONV_RELU_OUTPUT_FEATURES,DEC_2_UP_CONV_RELU_N, dec_2_concatenate, enc_1_conv_relu_1,dec_2_up_conv_relu);
  //-------------------------dec_2_conv_relu_0----------------------------------
  conv_relu(DEC_2_CONV_RELU_0_OUTPUT_FEATURES,DEC_2_CONV_RELU_0_N,DEC_2_CONV_RELU_0_K,DEC_2_CONV_RELU_0_INPUT_FEATURES,dec_2_conv_relu_0_w,dec_2_concatenate,dec_2_conv_relu_0);
  //-------------------------dec_2_conv_relu_1----------------------------------
  conv_relu(DEC_2_CONV_RELU_1_OUTPUT_FEATURES,DEC_2_CONV_RELU_1_N,DEC_2_CONV_RELU_1_K,DEC_2_CONV_RELU_1_INPUT_FEATURES,dec_2_conv_relu_1_w,dec_2_conv_relu_0,dec_2_conv_relu_1);
  //----------------------------------------------------------------------------

  //-----------------------------DECODER 3--------------------------------------
  //-----------------------------dec_3_upsample---------------------------------
  upsampling(DEC_3_UP_CONV_RELU_INPUT_FEATURES, DEC_3_UP_CONV_RELU_N, dec_3_upsample, dec_2_conv_relu_1);
  //-------------------------dec_3_up_conv_relu---------------------------------
  conv_relu(DEC_3_UP_CONV_RELU_OUTPUT_FEATURES,DEC_3_UP_CONV_RELU_N,DEC_3_UP_CONV_RELU_K,DEC_3_UP_CONV_RELU_INPUT_FEATURES,dec_3_up_conv_relu_w,dec_3_upsample,dec_3_up_conv_relu);
  //--------------------------dec_3_concatenate---------------------------------
    concatenation(DEC_3_UP_CONV_RELU_OUTPUT_FEATURES,DEC_3_UP_CONV_RELU_N, dec_3_concatenate, enc_0_conv_relu_1,dec_3_up_conv_relu);
  //-------------------------dec_3_conv_relu_0----------------------------------
  conv_relu(DEC_3_CONV_RELU_0_OUTPUT_FEATURES,DEC_3_CONV_RELU_0_N,DEC_3_CONV_RELU_0_K,DEC_3_CONV_RELU_0_INPUT_FEATURES,dec_3_conv_relu_0_w,dec_3_concatenate,dec_3_conv_relu_0);
  //-------------------------dec_3_conv_relu_1----------------------------------
  conv_relu(DEC_3_CONV_RELU_1_OUTPUT_FEATURES,DEC_3_CONV_RELU_1_N,DEC_3_CONV_RELU_1_K,DEC_3_CONV_RELU_1_INPUT_FEATURES,dec_3_conv_relu_1_w,dec_3_conv_relu_0,dec_3_conv_relu_1);
  //----------------------------------------------------------------------------

  //----------------------------FINAL CONV--------------------------------------
  conv_relu(FINAL_CONV_OUTPUT_FEATURES,FINAL_CONV_N,FINAL_CONV_K,FINAL_CONV_INPUT_FEATURES,final_conv_w,dec_3_conv_relu_1,final_conv);

  //----------------------------argmax-----------------------------------------
  // Iterate over the input matrix
  for(int i=0; i<FINAL_CONV_N; i++){
    Argmax(&final_conv[i], &y[i]);
  }
  //----------------------------------------------------------------------------


  free(enc_0_conv_relu_0);
  free(enc_0_conv_relu_1);
  
  free(enc_0_maxpool);

  free(enc_1_conv_relu_0);
  free(enc_1_conv_relu_1);
  free(enc_1_maxpool);

  free(enc_2_conv_relu_0);
  free(enc_2_conv_relu_1);
  free(enc_2_maxpool);

  free(enc_3_conv_relu_0);
  free(enc_3_conv_relu_1);
  free(enc_3_maxpool);

  free(central_conv_relu_0);
  free(central_conv_relu_1);

  free(dec_0_upsample);
  free(dec_0_up_conv_relu);
  free(dec_0_concatenate);
  free(dec_0_conv_relu_0);
  free(dec_0_conv_relu_1);

  free(dec_1_upsample);
  free(dec_1_up_conv_relu);
  free(dec_1_concatenate);
  free(dec_1_conv_relu_0);
  free(dec_1_conv_relu_1);

  free(dec_2_upsample);
  free(dec_2_up_conv_relu);
  free(dec_2_concatenate);
  free(dec_2_conv_relu_0);
  free(dec_2_conv_relu_1);

  free(dec_3_upsample);
  free(dec_3_up_conv_relu);
  free(dec_3_concatenate);
  free(dec_3_conv_relu_0);
  free(dec_3_conv_relu_1);

  free(final_conv);
}