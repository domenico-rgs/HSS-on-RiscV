#include "segmenter.h"
#include "functions.h"

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
               int16_t y[N]){

  // Arrays for feature maps
  int16_t array_1[1024];
  int16_t array_2[1024];

  //32-bit registers
  uint32_t a;
  uint32_t b;
  
  //Skip connections
  int16_t enc_0_conv_relu_1[ENC_0_CONV_RELU_1_N][ENC_0_CONV_RELU_1_OUTPUT_FEATURES];
  int16_t enc_1_conv_relu_1[ENC_1_CONV_RELU_1_N][ENC_1_CONV_RELU_1_OUTPUT_FEATURES];
  int16_t enc_2_conv_relu_1[ENC_2_CONV_RELU_1_N][ENC_2_CONV_RELU_1_OUTPUT_FEATURES];
  int16_t enc_3_conv_relu_1[ENC_3_CONV_RELU_1_N][ENC_3_CONV_RELU_1_OUTPUT_FEATURES];

  uint64_t var64;
  int32_t approx = 1<<((FXP-1)); //to be changed and adapted for each convolution layer in case of a different quantization format for each layer (pay attention when concatenating)

  // The accumulator
  int32_t acc;

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
        for(int j=0; j<ENC_0_CONV_RELU_0_INPUT_FEATURES/2; j++){
          // Load data in the lower 16 bits and data+1 in the upper 16 bits
          a= ((uint32_t)x[l*ENC_0_CONV_RELU_0_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)x[l*ENC_0_CONV_RELU_0_INPUT_FEATURES+2*j] & 0xFFFF);
          b= ((uint32_t)enc_0_conv_relu_0_w[(k*ENC_0_CONV_RELU_0_K+(l-i+ENC_0_CONV_RELU_0_K/2))*ENC_0_CONV_RELU_0_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)enc_0_conv_relu_0_w[(k*ENC_0_CONV_RELU_0_K+(l-i+ENC_0_CONV_RELU_0_K/2))*ENC_0_CONV_RELU_0_INPUT_FEATURES+2*j] & 0xFFFF);
          // Signed SIMD multiplication
          var64 = __smul16(a,b);
          // Extract the results, apply approximation and scaling for quantization and then accumulate
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP; 
        }
      }
      
      //check_over(acc,0);
      acc = SATURATE_INT16(acc);
      array_1[i*ENC_0_CONV_RELU_0_OUTPUT_FEATURES+k] = (int16_t)ReLU(acc); // Save the accumulator value
    }  
  }

  //-------------------------enc_0_conv_relu_1----------------------------------
  for(int k=0; k<ENC_0_CONV_RELU_1_OUTPUT_FEATURES; k++){
    for(int i=0; i<ENC_0_CONV_RELU_1_N; i++){  
      acc = 0; 

      l_min = max(0, i - ENC_0_CONV_RELU_1_K/2);
      l_max = min(ENC_0_CONV_RELU_1_N, i + ENC_0_CONV_RELU_1_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_0_CONV_RELU_1_INPUT_FEATURES/2; j++){
          a= ((uint32_t)array_1[l*ENC_0_CONV_RELU_0_OUTPUT_FEATURES+2*j+1] << 16) | ((uint32_t)array_1[l*ENC_0_CONV_RELU_0_OUTPUT_FEATURES+2*j]& 0xFFFF);
          b= ((uint32_t)enc_0_conv_relu_1_w[(k*ENC_0_CONV_RELU_1_K+(l-i+ENC_0_CONV_RELU_1_K/2))*ENC_0_CONV_RELU_1_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)enc_0_conv_relu_1_w[(k*ENC_0_CONV_RELU_1_K+(l-i+ENC_0_CONV_RELU_1_K/2))*ENC_0_CONV_RELU_1_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,1);
      acc = SATURATE_INT16(acc);
      enc_0_conv_relu_1[i][k] = (int16_t)ReLU(acc);
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
  for(int k=0; k<ENC_1_CONV_RELU_0_OUTPUT_FEATURES; k++){
    for(int i=0; i<ENC_1_CONV_RELU_0_N; i++){
      acc = 0;

      l_min = max(0, i - ENC_1_CONV_RELU_0_K/2);
      l_max = min(ENC_1_CONV_RELU_0_N, i + ENC_1_CONV_RELU_0_K/2 + 1);
      
      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_1_CONV_RELU_0_INPUT_FEATURES/2; j++){
          a= ((uint32_t)array_1[l*ENC_0_CONV_RELU_1_OUTPUT_FEATURES+2*j+1] << 16) | ((uint32_t)array_1[l*ENC_0_CONV_RELU_1_OUTPUT_FEATURES+2*j] & 0xFFFF);
          b= ((uint32_t)enc_1_conv_relu_0_w[(k*ENC_1_CONV_RELU_0_K+(l-i+ENC_1_CONV_RELU_0_K/2))*ENC_1_CONV_RELU_0_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)enc_1_conv_relu_0_w[(k*ENC_1_CONV_RELU_0_K+(l-i+ENC_1_CONV_RELU_0_K/2))*ENC_1_CONV_RELU_0_INPUT_FEATURES+2*j] & 0xFFFF); 
          var64 = __smul16(a,b);
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,2);
      acc = SATURATE_INT16(acc);
      array_2[i*ENC_1_CONV_RELU_0_OUTPUT_FEATURES+k] = (int16_t)ReLU(acc);
    }  
  }

  //-------------------------enc_1_conv_relu_1----------------------------------
  for(int k=0; k<ENC_1_CONV_RELU_1_OUTPUT_FEATURES; k++){ 
    for(int i=0; i<ENC_1_CONV_RELU_1_N; i++){
      acc = 0;

      l_min = max(0, i - ENC_1_CONV_RELU_1_K/2);
      l_max = min(ENC_1_CONV_RELU_1_N, i + ENC_1_CONV_RELU_1_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_1_CONV_RELU_1_INPUT_FEATURES/2; j++){
          a = ((uint32_t)array_2[l*ENC_1_CONV_RELU_0_OUTPUT_FEATURES+2*j+1] << 16) | ((uint32_t)array_2[l*ENC_1_CONV_RELU_0_OUTPUT_FEATURES+2*j] & 0xFFFF);
          b = ((uint32_t)enc_1_conv_relu_1_w[(k*ENC_1_CONV_RELU_1_K+(l-i+ENC_1_CONV_RELU_1_K/2))*ENC_1_CONV_RELU_1_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)enc_1_conv_relu_1_w[(k*ENC_1_CONV_RELU_1_K+(l-i+ENC_1_CONV_RELU_1_K/2))*ENC_1_CONV_RELU_1_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,3);
      acc = SATURATE_INT16(acc);
      enc_1_conv_relu_1[i][k] = (int16_t)ReLU(acc);
    }  
  }

  //-----------------------------enc_1_maxpool----------------------------------
  for(int i=0; i<ENC_1_CONV_RELU_1_N/2; i++){
    for(int k=0; k<ENC_1_CONV_RELU_1_OUTPUT_FEATURES; k++){
      array_2[i*ENC_1_CONV_RELU_1_OUTPUT_FEATURES+k] = max(enc_1_conv_relu_1[2*i][k], enc_1_conv_relu_1[2*i+1][k]);
    }
  }
  //----------------------------------------------------------------------------

  //-----------------------------ENCODER 2--------------------------------------
  //-------------------------enc_2_conv_relu_0----------------------------------
  for(int k=0; k<ENC_2_CONV_RELU_0_OUTPUT_FEATURES; k++){
    for(int i=0; i<ENC_2_CONV_RELU_0_N; i++){
      acc = 0;

      l_min = max(0, i - ENC_2_CONV_RELU_0_K/2);
      l_max = min(ENC_2_CONV_RELU_0_N, i + ENC_2_CONV_RELU_0_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_2_CONV_RELU_0_INPUT_FEATURES/2; j++){
          a = ((uint32_t)array_2[l*ENC_1_CONV_RELU_1_OUTPUT_FEATURES+2*j+1] << 16) | ((uint32_t)array_2[l*ENC_1_CONV_RELU_1_OUTPUT_FEATURES+2*j] & 0xFFFF);
          b = ((uint32_t)enc_2_conv_relu_0_w[(k*ENC_2_CONV_RELU_0_K+(l-i+ENC_2_CONV_RELU_0_K/2))*ENC_2_CONV_RELU_0_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)enc_2_conv_relu_0_w[(k*ENC_2_CONV_RELU_0_K+(l-i+ENC_2_CONV_RELU_0_K/2))*ENC_2_CONV_RELU_0_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,4);
      acc = SATURATE_INT16(acc);
      array_1[i*ENC_2_CONV_RELU_0_OUTPUT_FEATURES+k] = (int16_t)ReLU(acc);
    }  
  }

  //-------------------------enc_2_conv_relu_1----------------------------------
  for(int k=0; k<ENC_2_CONV_RELU_1_OUTPUT_FEATURES; k++){
    for(int i=0; i<ENC_2_CONV_RELU_1_N; i++){
      acc = 0;

      l_min = max(0, i - ENC_2_CONV_RELU_1_K/2);
      l_max = min(ENC_2_CONV_RELU_1_N, i + ENC_2_CONV_RELU_1_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_2_CONV_RELU_1_INPUT_FEATURES/2; j++){
          a = ((uint32_t)array_1[l*ENC_2_CONV_RELU_0_OUTPUT_FEATURES+2*j+1] << 16) | ((uint32_t)array_1[l*ENC_2_CONV_RELU_0_OUTPUT_FEATURES+2*j] & 0xFFFF);
          b = ((uint32_t)enc_2_conv_relu_1_w[(k*ENC_2_CONV_RELU_1_K+(l-i+ENC_2_CONV_RELU_1_K/2))*ENC_2_CONV_RELU_1_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)enc_2_conv_relu_1_w[(k*ENC_2_CONV_RELU_1_K+(l-i+ENC_2_CONV_RELU_1_K/2))*ENC_2_CONV_RELU_1_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,5);
      acc = SATURATE_INT16(acc);
      enc_2_conv_relu_1[i][k] = (int16_t)ReLU(acc);
    }  
  }

  //-----------------------------enc_2_maxpool----------------------------------
  for(int i=0; i<ENC_2_CONV_RELU_1_N/2; i++){
    for(int k=0; k<ENC_2_CONV_RELU_1_OUTPUT_FEATURES; k++){
      array_1[i*ENC_2_CONV_RELU_1_OUTPUT_FEATURES+k] = max(enc_2_conv_relu_1[2*i][k], enc_2_conv_relu_1[2*i+1][k]);
    }
  }
  //----------------------------------------------------------------------------

  //-----------------------------ENCODER 3--------------------------------------
  //-------------------------enc_3_conv_relu_0----------------------------------
  for(int k=0; k<ENC_3_CONV_RELU_0_OUTPUT_FEATURES; k++){
    for(int i=0; i<ENC_3_CONV_RELU_0_N; i++){
      acc = 0;

      l_min = max(0, i - ENC_3_CONV_RELU_0_K/2);
      l_max = min(ENC_3_CONV_RELU_0_N, i + ENC_3_CONV_RELU_0_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_3_CONV_RELU_0_INPUT_FEATURES/2; j++){
          a = ((uint32_t)array_1[l*ENC_2_CONV_RELU_1_OUTPUT_FEATURES+2*j+1] << 16) | ((uint32_t)array_1[l*ENC_2_CONV_RELU_1_OUTPUT_FEATURES+2*j] & 0xFFFF);
          b = ((uint32_t)enc_3_conv_relu_0_w[(k*ENC_3_CONV_RELU_0_K+(l-i+ENC_3_CONV_RELU_0_K/2))*ENC_3_CONV_RELU_0_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)enc_3_conv_relu_0_w[(k*ENC_3_CONV_RELU_0_K+(l-i+ENC_3_CONV_RELU_0_K/2))*ENC_3_CONV_RELU_0_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);        
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,6);
      acc = SATURATE_INT16(acc);
      array_2[i*ENC_3_CONV_RELU_0_OUTPUT_FEATURES+k] = (int16_t)ReLU(acc);
    }  
  }

  //-------------------------enc_3_conv_relu_1----------------------------------
  for(int k=0; k<ENC_3_CONV_RELU_1_OUTPUT_FEATURES; k++){
    for(int i=0; i<ENC_3_CONV_RELU_1_N; i++){
      acc = 0;

      l_min = max(0, i - ENC_3_CONV_RELU_1_K/2);
      l_max = min(ENC_3_CONV_RELU_1_N, i + ENC_3_CONV_RELU_1_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<ENC_3_CONV_RELU_1_INPUT_FEATURES/2; j++){
          a = ((uint32_t)array_2[l*ENC_3_CONV_RELU_0_OUTPUT_FEATURES+2*j+1] << 16) | ((uint32_t)array_2[l*ENC_3_CONV_RELU_0_OUTPUT_FEATURES+2*j] & 0xFFFF);
          b = ((uint32_t)enc_3_conv_relu_1_w[(k*ENC_3_CONV_RELU_1_K+(l-i+ENC_3_CONV_RELU_1_K/2))*ENC_3_CONV_RELU_1_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)enc_3_conv_relu_1_w[(k*ENC_3_CONV_RELU_1_K+(l-i+ENC_3_CONV_RELU_1_K/2))*ENC_3_CONV_RELU_1_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,7);
      acc = SATURATE_INT16(acc);
      enc_3_conv_relu_1[i][k] = (int16_t)ReLU(acc);
    }  
  }

  //-----------------------------enc_3_maxpool----------------------------------
  for(int i=0; i<ENC_3_CONV_RELU_1_N/2; i++){
    for(int k=0; k<ENC_3_CONV_RELU_1_OUTPUT_FEATURES; k++){
      array_2[i*ENC_3_CONV_RELU_1_OUTPUT_FEATURES+k] = max(enc_3_conv_relu_1[2*i][k], enc_3_conv_relu_1[2*i+1][k]);
    }
  }
  //----------------------------------------------------------------------------

  //--------------------------CENTRAL PART--------------------------------------
  //-------------------------central_conv_relu_0----------------------------------
  for(int k=0; k<CENTRAL_CONV_RELU_0_OUTPUT_FEATURES; k++){
    for(int i=0; i<CENTRAL_CONV_RELU_0_N; i++){
      acc = 0;

      l_min = max(0, i - CENTRAL_CONV_RELU_0_K/2);
      l_max = min(CENTRAL_CONV_RELU_0_N, i + CENTRAL_CONV_RELU_0_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<CENTRAL_CONV_RELU_0_INPUT_FEATURES/2; j++){
          a = ((uint32_t)array_2[l*ENC_3_CONV_RELU_1_OUTPUT_FEATURES+2*j+1] << 16) | ((uint32_t)array_2[l*ENC_3_CONV_RELU_1_OUTPUT_FEATURES+2*j] & 0xFFFF);
          b = ((uint32_t)central_conv_relu_0_w[(k*CENTRAL_CONV_RELU_0_K+(l-i+CENTRAL_CONV_RELU_0_K/2))*CENTRAL_CONV_RELU_0_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)central_conv_relu_0_w[(k*CENTRAL_CONV_RELU_0_K+(l-i+CENTRAL_CONV_RELU_0_K/2))*CENTRAL_CONV_RELU_0_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,8);
      acc = SATURATE_INT16(acc);
      array_1[i*CENTRAL_CONV_RELU_0_OUTPUT_FEATURES+k] = (int16_t)ReLU(acc);
    }  
  }

  //-------------------------central_conv_relu_1----------------------------------
  for(int k=0; k<CENTRAL_CONV_RELU_1_OUTPUT_FEATURES; k++){
    for(int i=0; i<CENTRAL_CONV_RELU_1_N; i++){
      acc = 0;

      l_min = max(0, i - CENTRAL_CONV_RELU_1_K/2);
      l_max = min(CENTRAL_CONV_RELU_1_N, i + CENTRAL_CONV_RELU_1_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<CENTRAL_CONV_RELU_1_INPUT_FEATURES/2; j++){
          a = ((uint32_t)array_1[l*CENTRAL_CONV_RELU_0_OUTPUT_FEATURES+2*j+1] << 16) | ((uint32_t)array_1[l*CENTRAL_CONV_RELU_0_OUTPUT_FEATURES+2*j] & 0xFFFF);
          b = ((uint32_t)central_conv_relu_1_w[(k*CENTRAL_CONV_RELU_1_K+(l-i+CENTRAL_CONV_RELU_1_K/2))*CENTRAL_CONV_RELU_1_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)central_conv_relu_1_w[(k*CENTRAL_CONV_RELU_1_K+(l-i+CENTRAL_CONV_RELU_1_K/2))*CENTRAL_CONV_RELU_1_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,9);
      acc = SATURATE_INT16(acc);
      array_2[i*CENTRAL_CONV_RELU_1_OUTPUT_FEATURES+k] = (int16_t)ReLU(acc);
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
  for(int k=0; k<DEC_0_UP_CONV_RELU_OUTPUT_FEATURES; k++){
    for(int i=0; i<DEC_0_UP_CONV_RELU_N; i++){
      acc = 0;

      l_min = max(0, i - DEC_0_UP_CONV_RELU_K/2);
      l_max = min(DEC_0_UP_CONV_RELU_N, i + DEC_0_UP_CONV_RELU_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_0_UP_CONV_RELU_INPUT_FEATURES/2; j++){
          a = ((uint32_t)array_1[l*DEC_0_UP_CONV_RELU_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)array_1[l*DEC_0_UP_CONV_RELU_INPUT_FEATURES+2*j] & 0xFFFF);
          b = ((uint32_t)dec_0_up_conv_relu_w[(k*DEC_0_UP_CONV_RELU_K+(l-i+DEC_0_UP_CONV_RELU_K/2))*DEC_0_UP_CONV_RELU_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)dec_0_up_conv_relu_w[(k*DEC_0_UP_CONV_RELU_K+(l-i+DEC_0_UP_CONV_RELU_K/2))*DEC_0_UP_CONV_RELU_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,10);
      acc = SATURATE_INT16(acc);
      array_2[i*DEC_0_UP_CONV_RELU_OUTPUT_FEATURES+k] = (int16_t)ReLU(acc);
    }  
  }

//--------------------------dec_0_concatenate---------------------------------
  for(int i=0; i<DEC_0_UP_CONV_RELU_N; i++){  // Iterate over the input matrix
    for(int k=0; k<DEC_0_UP_CONV_RELU_OUTPUT_FEATURES; k++){  // Iterate over the number of filters
      array_1[i*(DEC_0_UP_CONV_RELU_OUTPUT_FEATURES*2)+k] = enc_3_conv_relu_1[i][k];
      array_1[i*(DEC_0_UP_CONV_RELU_OUTPUT_FEATURES*2)+(k+DEC_0_UP_CONV_RELU_OUTPUT_FEATURES)] = array_2[i*DEC_0_UP_CONV_RELU_OUTPUT_FEATURES+k];
    }
  }

  //-------------------------dec_0_conv_relu_0----------------------------------
  for(int k=0; k<DEC_0_CONV_RELU_0_OUTPUT_FEATURES; k++){
    for(int i=0; i<DEC_0_CONV_RELU_0_N; i++){
      acc = 0;

      l_min = max(0, i - DEC_0_CONV_RELU_0_K/2);
      l_max = min(DEC_0_CONV_RELU_0_N, i + DEC_0_CONV_RELU_0_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_0_CONV_RELU_0_INPUT_FEATURES/2; j++){
          a = ((uint32_t)array_1[l*(DEC_0_UP_CONV_RELU_OUTPUT_FEATURES*2)+2*j+1] << 16) | ((uint32_t)array_1[l*(DEC_0_UP_CONV_RELU_OUTPUT_FEATURES*2)+2*j] & 0xFFFF);
          b = ((uint32_t)dec_0_conv_relu_0_w[(k*DEC_0_CONV_RELU_0_K+(l-i+DEC_0_CONV_RELU_0_K/2))*DEC_0_CONV_RELU_0_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)dec_0_conv_relu_0_w[(k*DEC_0_CONV_RELU_0_K+(l-i+DEC_0_CONV_RELU_0_K/2))*DEC_0_CONV_RELU_0_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,11);
      acc = SATURATE_INT16(acc);
      array_2[i*DEC_0_CONV_RELU_0_OUTPUT_FEATURES+k] = (int16_t)ReLU(acc);
    }  
  }

  //-------------------------dec_0_conv_relu_1----------------------------------
  for(int k=0; k<DEC_0_CONV_RELU_1_OUTPUT_FEATURES; k++){
    for(int i=0; i<DEC_0_CONV_RELU_1_N; i++){
      acc = 0;

      l_min = max(0, i - DEC_0_CONV_RELU_1_K/2);
      l_max = min(DEC_0_CONV_RELU_1_N, i + DEC_0_CONV_RELU_1_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_0_CONV_RELU_1_INPUT_FEATURES/2; j++){
          a = ((uint32_t)array_2[l*DEC_0_CONV_RELU_0_OUTPUT_FEATURES+2*j+1] << 16) | ((uint32_t)array_2[l*DEC_0_CONV_RELU_0_OUTPUT_FEATURES+2*j] & 0xFFFF);
          b = ((uint32_t)dec_0_conv_relu_1_w[(k*DEC_0_CONV_RELU_1_K+(l-i+DEC_0_CONV_RELU_1_K/2))*DEC_0_CONV_RELU_1_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)dec_0_conv_relu_1_w[(k*DEC_0_CONV_RELU_1_K+(l-i+DEC_0_CONV_RELU_1_K/2))*DEC_0_CONV_RELU_1_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,12);
      acc = SATURATE_INT16(acc);
      array_1[i*DEC_0_CONV_RELU_1_OUTPUT_FEATURES+k] = (int16_t)ReLU(acc);
    }  
  }
  //----------------------------------------------------------------------------

  //-----------------------------DECODER 1--------------------------------------
  //-----------------------------dec_1_upsample---------------------------------
  for(int i=0; i<DEC_1_UP_CONV_RELU_N/2; i++){ 
    for(int k=0; k<DEC_1_UP_CONV_RELU_INPUT_FEATURES; k++){
      array_2[(2*i)*DEC_1_UP_CONV_RELU_INPUT_FEATURES+k] = array_1[i*DEC_0_CONV_RELU_0_OUTPUT_FEATURES+k];
      array_2[(2*i+1)*DEC_1_UP_CONV_RELU_INPUT_FEATURES+k] = array_1[i*DEC_0_CONV_RELU_0_OUTPUT_FEATURES+k];
    }
  }

  //-------------------------dec_1_up_conv_relu----------------------------------
  for(int k=0; k<DEC_1_UP_CONV_RELU_OUTPUT_FEATURES; k++){
    for(int i=0; i<DEC_1_UP_CONV_RELU_N; i++){
      acc = 0;

      l_min = max(0, i - DEC_1_UP_CONV_RELU_K/2);
      l_max = min(DEC_1_UP_CONV_RELU_N, i + DEC_1_UP_CONV_RELU_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_1_UP_CONV_RELU_INPUT_FEATURES/2; j++){
          a = ((uint32_t)array_2[l*DEC_1_UP_CONV_RELU_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)array_2[l*DEC_1_UP_CONV_RELU_INPUT_FEATURES+2*j] & 0xFFFF);
          b = ((uint32_t)dec_1_up_conv_relu_w[(k*DEC_1_UP_CONV_RELU_K+(l-i+DEC_1_UP_CONV_RELU_K/2))*DEC_1_UP_CONV_RELU_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)dec_1_up_conv_relu_w[(k*DEC_1_UP_CONV_RELU_K+(l-i+DEC_1_UP_CONV_RELU_K/2))*DEC_1_UP_CONV_RELU_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,13);
      acc = SATURATE_INT16(acc);
      array_1[i*DEC_1_UP_CONV_RELU_OUTPUT_FEATURES+k] = (int16_t)ReLU(acc);
    }  
  }

  //--------------------------dec_1_concatenate---------------------------------
  for(int i=0; i<DEC_1_UP_CONV_RELU_N; i++){
    for(int k=0; k<DEC_1_UP_CONV_RELU_OUTPUT_FEATURES; k++){
      array_2[i*(DEC_1_UP_CONV_RELU_OUTPUT_FEATURES*2)+k] = enc_2_conv_relu_1[i][k];
      array_2[i*(DEC_1_UP_CONV_RELU_OUTPUT_FEATURES*2)+(k+DEC_1_UP_CONV_RELU_OUTPUT_FEATURES)] = array_1[i*DEC_1_UP_CONV_RELU_OUTPUT_FEATURES+k];
    }
  }

  //-------------------------dec_1_conv_relu_0----------------------------------
  for(int k=0; k<DEC_1_CONV_RELU_0_OUTPUT_FEATURES; k++){
    for(int i=0; i<DEC_1_CONV_RELU_0_N; i++){
      acc = 0;

      l_min = max(0, i - DEC_1_CONV_RELU_0_K/2);
      l_max = min(DEC_1_CONV_RELU_0_N, i + DEC_1_CONV_RELU_0_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_1_CONV_RELU_0_INPUT_FEATURES/2; j++){
          a = ((uint32_t)array_2[l*(DEC_1_UP_CONV_RELU_OUTPUT_FEATURES*2)+2*j+1] << 16) | ((uint32_t)array_2[l*(DEC_1_UP_CONV_RELU_OUTPUT_FEATURES*2)+2*j] & 0xFFFF);
          b = ((uint32_t)dec_1_conv_relu_0_w[(k*DEC_1_CONV_RELU_0_K+(l-i+DEC_1_CONV_RELU_0_K/2))*DEC_1_CONV_RELU_0_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)dec_1_conv_relu_0_w[(k*DEC_1_CONV_RELU_0_K+(l-i+DEC_1_CONV_RELU_0_K/2))*DEC_1_CONV_RELU_0_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,14);
      acc = SATURATE_INT16(acc);
      array_1[i*DEC_1_CONV_RELU_0_OUTPUT_FEATURES+k] = (int16_t)ReLU(acc);
    }  
  }

  //-------------------------dec_1_conv_relu_1----------------------------------
  for(int k=0; k<DEC_1_CONV_RELU_1_OUTPUT_FEATURES; k++){
    for(int i=0; i<DEC_1_CONV_RELU_1_N; i++){
      acc = 0;

      l_min = max(0, i - DEC_1_CONV_RELU_1_K/2);
      l_max = min(DEC_1_CONV_RELU_1_N, i + DEC_1_CONV_RELU_1_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_1_CONV_RELU_1_INPUT_FEATURES/2; j++){
          a = ((uint32_t)array_1[l*DEC_1_CONV_RELU_0_OUTPUT_FEATURES+2*j+1] << 16) | ((uint32_t)array_1[l*DEC_1_CONV_RELU_0_OUTPUT_FEATURES+2*j] & 0xFFFF);
          b = ((uint32_t)dec_1_conv_relu_1_w[(k*DEC_1_CONV_RELU_1_K+(l-i+DEC_1_CONV_RELU_1_K/2))*DEC_1_CONV_RELU_1_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)dec_1_conv_relu_1_w[(k*DEC_1_CONV_RELU_1_K+(l-i+DEC_1_CONV_RELU_1_K/2))*DEC_1_CONV_RELU_1_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,15);
      acc = SATURATE_INT16(acc);
      array_2[i*DEC_1_CONV_RELU_1_OUTPUT_FEATURES+k] = (int16_t)ReLU(acc);
    }  
  }
  //----------------------------------------------------------------------------

  //-----------------------------DECODER 2--------------------------------------
  //-----------------------------dec_2_upsample---------------------------------
  for(int i=0; i<DEC_2_UP_CONV_RELU_N/2; i++){
    for(int k=0; k<DEC_2_UP_CONV_RELU_INPUT_FEATURES; k++){
      array_1[(2*i)*DEC_2_UP_CONV_RELU_INPUT_FEATURES+k] = array_2[i*DEC_1_CONV_RELU_1_OUTPUT_FEATURES+k];
      array_1[(2*i+1)*DEC_2_UP_CONV_RELU_INPUT_FEATURES+k] = array_2[i*DEC_1_CONV_RELU_1_OUTPUT_FEATURES+k];
    }
  }

  //-------------------------dec_2_up_conv_relu----------------------------------
  for(int k=0; k<DEC_2_UP_CONV_RELU_OUTPUT_FEATURES; k++){
    for(int i=0; i<DEC_2_UP_CONV_RELU_N; i++){
      acc = 0;

      l_min = max(0, i - DEC_2_UP_CONV_RELU_K/2);
      l_max = min(DEC_2_UP_CONV_RELU_N, i + DEC_2_UP_CONV_RELU_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_2_UP_CONV_RELU_INPUT_FEATURES/2; j++){
          a = ((uint32_t)array_1[l*DEC_2_UP_CONV_RELU_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)array_1[l*DEC_2_UP_CONV_RELU_INPUT_FEATURES+2*j] & 0xFFFF);
          b = ((uint32_t)dec_2_up_conv_relu_w[(k*DEC_2_UP_CONV_RELU_K+(l-i+DEC_2_UP_CONV_RELU_K/2))*DEC_2_UP_CONV_RELU_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)dec_2_up_conv_relu_w[(k*DEC_2_UP_CONV_RELU_K+(l-i+DEC_2_UP_CONV_RELU_K/2))*DEC_2_UP_CONV_RELU_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,16);
      acc = SATURATE_INT16(acc);
      array_2[i*DEC_2_UP_CONV_RELU_OUTPUT_FEATURES+k] = (int16_t)ReLU(acc);
    }  
  }

  //--------------------------dec_2_concatenate---------------------------------
  for(int i=0; i<DEC_2_UP_CONV_RELU_N; i++){
    for(int k=0; k<DEC_2_UP_CONV_RELU_OUTPUT_FEATURES; k++){
      array_1[i*(DEC_2_UP_CONV_RELU_OUTPUT_FEATURES*2)+k] = enc_1_conv_relu_1[i][k];
      array_1[i*(DEC_2_UP_CONV_RELU_OUTPUT_FEATURES*2)+(k+DEC_2_UP_CONV_RELU_OUTPUT_FEATURES)] = array_2[i*DEC_2_UP_CONV_RELU_OUTPUT_FEATURES+k];
    }
  }


  //-------------------------dec_2_conv_relu_0----------------------------------
  for(int k=0; k<DEC_2_CONV_RELU_0_OUTPUT_FEATURES; k++){
    for(int i=0; i<DEC_2_CONV_RELU_0_N; i++){
      acc = 0;

      l_min = max(0, i - DEC_2_CONV_RELU_0_K/2);
      l_max = min(DEC_2_CONV_RELU_0_N, i + DEC_2_CONV_RELU_0_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_2_CONV_RELU_0_INPUT_FEATURES/2; j++){
          a = ((uint32_t)array_1[l*(DEC_2_UP_CONV_RELU_OUTPUT_FEATURES*2)+2*j+1] << 16) | ((uint32_t)array_1[l*(DEC_2_UP_CONV_RELU_OUTPUT_FEATURES*2)+2*j] & 0xFFFF);
          b = ((uint32_t)dec_2_conv_relu_0_w[(k*DEC_2_CONV_RELU_0_K+(l-i+DEC_2_CONV_RELU_0_K/2))*DEC_2_CONV_RELU_0_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)dec_2_conv_relu_0_w[(k*DEC_2_CONV_RELU_0_K+(l-i+DEC_2_CONV_RELU_0_K/2))*DEC_2_CONV_RELU_0_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,17);
      acc = SATURATE_INT16(acc);
      array_2[i*DEC_2_CONV_RELU_0_OUTPUT_FEATURES+k] = (int16_t)ReLU(acc);
    }  
  }

  //-------------------------dec_2_conv_relu_1----------------------------------
  for(int k=0; k<DEC_2_CONV_RELU_1_OUTPUT_FEATURES; k++){
    for(int i=0; i<DEC_2_CONV_RELU_1_N; i++){
      acc = 0;

      l_min = max(0, i - DEC_2_CONV_RELU_1_K/2);
      l_max = min(DEC_2_CONV_RELU_1_N, i + DEC_2_CONV_RELU_1_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_2_CONV_RELU_1_INPUT_FEATURES/2; j++){
          a = ((uint32_t)array_2[l*DEC_2_CONV_RELU_0_OUTPUT_FEATURES+2*j+1] << 16) | ((uint32_t)array_2[l*DEC_2_CONV_RELU_0_OUTPUT_FEATURES+2*j] & 0xFFFF);
          b = ((uint32_t)dec_2_conv_relu_1_w[(k*DEC_2_CONV_RELU_1_K+(l-i+DEC_2_CONV_RELU_1_K/2))*DEC_2_CONV_RELU_1_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)dec_2_conv_relu_1_w[(k*DEC_2_CONV_RELU_1_K+(l-i+DEC_2_CONV_RELU_1_K/2))*DEC_2_CONV_RELU_1_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);       
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,18);
      acc = SATURATE_INT16(acc);
      array_1[i*DEC_2_CONV_RELU_1_OUTPUT_FEATURES+k] = (int16_t)ReLU(acc);
    }  
  }
  //----------------------------------------------------------------------------

  //-----------------------------DECODER 3--------------------------------------
  //-----------------------------dec_3_upsample---------------------------------
  for(int i=0; i<DEC_3_UP_CONV_RELU_N/2; i++){
    for(int k=0; k<DEC_3_UP_CONV_RELU_INPUT_FEATURES; k++){
      array_2[(2*i)*DEC_3_UP_CONV_RELU_INPUT_FEATURES+k] = array_1[i*DEC_2_CONV_RELU_1_OUTPUT_FEATURES+k];
      array_2[(2*i+1)*DEC_3_UP_CONV_RELU_INPUT_FEATURES+k] = array_1[i*DEC_2_CONV_RELU_1_OUTPUT_FEATURES+k];
    }
  }

  //-------------------------dec_3_up_conv_relu----------------------------------
  for(int k=0; k<DEC_3_UP_CONV_RELU_OUTPUT_FEATURES; k++){
    for(int i=0; i<DEC_3_UP_CONV_RELU_N; i++){
      acc = 0;

      l_min = max(0, i - DEC_3_UP_CONV_RELU_K/2);
      l_max = min(DEC_3_UP_CONV_RELU_N, i + DEC_3_UP_CONV_RELU_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_3_UP_CONV_RELU_INPUT_FEATURES/2; j++){
          a = ((uint32_t)array_2[l*DEC_3_UP_CONV_RELU_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)array_2[l*DEC_3_UP_CONV_RELU_INPUT_FEATURES+2*j] & 0xFFFF);
          b = ((uint32_t)dec_3_up_conv_relu_w[(k*DEC_3_UP_CONV_RELU_K+(l-i+DEC_3_UP_CONV_RELU_K/2))*DEC_3_UP_CONV_RELU_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)dec_3_up_conv_relu_w[(k*DEC_3_UP_CONV_RELU_K+(l-i+DEC_3_UP_CONV_RELU_K/2))*DEC_3_UP_CONV_RELU_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,19);
      acc = SATURATE_INT16(acc);
      array_1[i*DEC_3_UP_CONV_RELU_OUTPUT_FEATURES+k] = (int16_t)ReLU(acc);
    }  
  }

  //--------------------------dec_3_concatenate---------------------------------
  for(int i=0; i<DEC_3_UP_CONV_RELU_N; i++){
    for(int k=0; k<DEC_3_UP_CONV_RELU_OUTPUT_FEATURES; k++){
      array_2[i*(DEC_3_UP_CONV_RELU_OUTPUT_FEATURES*2)+k] = enc_0_conv_relu_1[i][k];
      array_2[i*(DEC_3_UP_CONV_RELU_OUTPUT_FEATURES*2)+(k+DEC_3_UP_CONV_RELU_OUTPUT_FEATURES)] = array_1[i*DEC_3_UP_CONV_RELU_OUTPUT_FEATURES+k];
    }
  }

  //-------------------------dec_3_conv_relu_0----------------------------------
  for(int k=0; k<DEC_3_CONV_RELU_0_OUTPUT_FEATURES; k++){
    for(int i=0; i<DEC_3_CONV_RELU_0_N; i++){
      acc = 0;

      l_min = max(0, i - DEC_3_CONV_RELU_0_K/2);
      l_max = min(DEC_3_CONV_RELU_0_N, i + DEC_3_CONV_RELU_0_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_3_CONV_RELU_0_INPUT_FEATURES/2; j++){
          a = ((uint32_t)array_2[l*(DEC_3_UP_CONV_RELU_OUTPUT_FEATURES*2)+2*j+1] << 16) | ((uint32_t)array_2[l*(DEC_3_UP_CONV_RELU_OUTPUT_FEATURES*2)+2*j] & 0xFFFF);
          b = ((uint32_t)dec_3_conv_relu_0_w[(k*DEC_3_CONV_RELU_0_K+(l-i+DEC_3_CONV_RELU_0_K/2))*DEC_3_CONV_RELU_0_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)dec_3_conv_relu_0_w[(k*DEC_3_CONV_RELU_0_K+(l-i+DEC_3_CONV_RELU_0_K/2))*DEC_3_CONV_RELU_0_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);       
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,20);
      acc = SATURATE_INT16(acc);
      array_1[i*DEC_3_CONV_RELU_0_OUTPUT_FEATURES+k] = (int16_t)ReLU(acc);
    }  
  }

  //-------------------------dec_3_conv_relu_1----------------------------------
  for(int k=0; k<DEC_3_CONV_RELU_1_OUTPUT_FEATURES; k++){
    for(int i=0; i<DEC_3_CONV_RELU_1_N; i++){
      acc = 0;

      l_min = max(0, i - DEC_3_CONV_RELU_1_K/2);
      l_max = min(DEC_3_CONV_RELU_1_N, i + DEC_3_CONV_RELU_1_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<DEC_3_CONV_RELU_1_INPUT_FEATURES/2; j++){
          a = ((uint32_t)array_1[l*DEC_3_CONV_RELU_0_OUTPUT_FEATURES+2*j+1] << 16) | ((uint32_t)array_1[l*DEC_3_CONV_RELU_0_OUTPUT_FEATURES+2*j] & 0xFFFF);
          b = ((uint32_t)dec_3_conv_relu_1_w[(k*DEC_3_CONV_RELU_1_K+(l-i+DEC_3_CONV_RELU_1_K/2))*DEC_3_CONV_RELU_1_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)dec_3_conv_relu_1_w[(k*DEC_3_CONV_RELU_1_K+(l-i+DEC_3_CONV_RELU_1_K/2))*DEC_3_CONV_RELU_1_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,21);
      acc = SATURATE_INT16(acc);
      array_2[i*DEC_3_CONV_RELU_1_OUTPUT_FEATURES+k] = (int16_t)ReLU(acc);
    }  
  }
  //----------------------------------------------------------------------------

  //----------------------------FINAL CONV--------------------------------------
  for(int k=0; k<FINAL_CONV_OUTPUT_FEATURES; k++){
    for(int i=0; i<FINAL_CONV_N; i++){
      acc = 0;

      l_min = max(0, i - FINAL_CONV_K/2);
      l_max = min(FINAL_CONV_N, i + FINAL_CONV_K/2 + 1);

      for(int l=l_min; l<l_max; l++){
        for(int j=0; j<FINAL_CONV_INPUT_FEATURES/2; j++){
          a = ((uint32_t)array_2[l*DEC_3_CONV_RELU_1_OUTPUT_FEATURES+2*j+1] << 16) | ((uint32_t)array_2[l*DEC_3_CONV_RELU_1_OUTPUT_FEATURES+2*j] & 0xFFFF);
          b = ((uint32_t)final_conv_w[(k*FINAL_CONV_K+(l-i+FINAL_CONV_K/2))*FINAL_CONV_INPUT_FEATURES+2*j+1] << 16) | ((uint32_t)final_conv_w[(k*FINAL_CONV_K+(l-i+FINAL_CONV_K/2))*FINAL_CONV_INPUT_FEATURES+2*j] & 0xFFFF);
          var64 = __smul16(a,b);
          acc += ((int32_t)(var64 & 0xFFFFFFFF) + approx)>>FXP;
          acc += ((int32_t)((var64 >> 32) & 0xFFFFFFFF) + approx)>>FXP;
        }
      }

      //check_over(acc,22);
      acc = SATURATE_INT16(acc);
      array_1[i*FINAL_CONV_OUTPUT_FEATURES+k] = (int16_t)acc;
    } 
  }

  //----------------------------Argmax + SMTM-----------------------------------------
  for(int i=0; i<FINAL_CONV_N; i++){
    int16_t maxvalue = INT16_MIN;
    int maxindex = 0;

    for (int j = 0; j < N_STATES; j++) {
      if (array_1[i*N_STATES+j] > maxvalue) {
        maxvalue = array_1[i*N_STATES+j];
        maxindex = j;
      }
    }

    for (int j = 0; j < N_STATES; j++) {
      if (j == maxindex) {
        y[i] = j;
      }
    }

    //Sequential Max Temporal Modelling
    if(i>0 && y[i]!=(y[i-1]+1)%4){
			y[i]=y[i-1];
		}
  }
  //----------------------------------------------------------------------------
}