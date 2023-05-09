#include "functions.cuh"
#include "segmenter.cuh"
#include <time.h>
#include "weights.cuh"

int main(int argc, char *argv[]){
  /*FILE *output;

  if((output = fopen("cuda_res.txt","w"))==NULL){
      printf("Failed opening files\n");
      return 1;
  }*/

  //datatype value;
  FILE* f0;

  if((f0 = fopen("test_data.bin", "rb"))==NULL){
      printf("Failed opening files\n");
      return 1;
  }
    
  datatype *test_data;
  datatype *y;
  cudaMallocHost((void**)&test_data,sizeof(datatype) *N_FEATURES*N);
  cudaMallocHost((void**)&y,sizeof(datatype) *N*N_STATES);

  fread(test_data, sizeof(datatype), N_FEATURES*N, f0);

  //cudaProfilerStart();
  clock_t time1 = clock();

  //Weights
  datatype *d_x, *d_y;
  datatype *d_enc_0_conv_relu_0_w, *d_enc_0_conv_relu_1_w, *d_enc_1_conv_relu_0_w, *d_enc_1_conv_relu_1_w, *d_enc_2_conv_relu_0_w,
          *d_enc_2_conv_relu_1_w, *d_enc_3_conv_relu_0_w, *d_enc_3_conv_relu_1_w, *d_central_conv_relu_0_w, *d_central_conv_relu_1_w,
          *d_dec_0_up_conv_relu_w, *d_dec_0_conv_relu_0_w, *d_dec_0_conv_relu_1_w, *d_dec_1_up_conv_relu_w, *d_dec_1_conv_relu_0_w,
          *d_dec_1_conv_relu_1_w, *d_dec_2_up_conv_relu_w, *d_dec_2_conv_relu_0_w, *d_dec_2_conv_relu_1_w, *d_dec_3_up_conv_relu_w,
          *d_dec_3_conv_relu_0_w, *d_dec_3_conv_relu_1_w, *d_final_conv_w;

  //Feature maps
  datatype *d_enc_0_conv_relu_0, *d_enc_0_conv_relu_1, *d_enc_0_maxpool;
  datatype *d_enc_1_conv_relu_0, *d_enc_1_conv_relu_1, *d_enc_1_maxpool;
  datatype *d_enc_2_conv_relu_0, *d_enc_2_conv_relu_1, *d_enc_2_maxpool;
  datatype *d_enc_3_conv_relu_0, *d_enc_3_conv_relu_1, *d_enc_3_maxpool;
  datatype *d_central_conv_relu_0, *d_central_conv_relu_1;
  datatype *d_dec_0_upsample, *d_dec_0_up_conv_relu, *d_dec_0_concatenate, *d_dec_0_conv_relu_0, *d_dec_0_conv_relu_1; 
  datatype *d_dec_1_upsample, *d_dec_1_up_conv_relu, *d_dec_1_concatenate, *d_dec_1_conv_relu_0, *d_dec_1_conv_relu_1;
  datatype *d_dec_2_upsample, *d_dec_2_up_conv_relu, *d_dec_2_concatenate, *d_dec_2_conv_relu_0, *d_dec_2_conv_relu_1;
  datatype *d_dec_3_upsample, *d_dec_3_up_conv_relu, *d_dec_3_concatenate, *d_dec_3_conv_relu_0, *d_dec_3_conv_relu_1; 
  datatype *d_final_conv;

  //Weights and feature maps allocation/initialization
  cudaMalloc((void**)&d_x, sizeof(datatype) * N*N_FEATURES);
  cudaMemcpyAsync(d_x, test_data, N*N_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);

  cudaMalloc((void**)&d_enc_0_conv_relu_0, sizeof(datatype) * ENC_0_CONV_RELU_0_N * ENC_0_CONV_RELU_0_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_enc_0_conv_relu_0_w, sizeof(datatype) * ENC_0_CONV_RELU_0_K * ENC_0_CONV_RELU_0_INPUT_FEATURES*ENC_0_CONV_RELU_0_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_enc_0_conv_relu_0_w, enc_0_conv_relu_0_w, ENC_0_CONV_RELU_0_K * ENC_0_CONV_RELU_0_INPUT_FEATURES*ENC_0_CONV_RELU_0_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);

  cudaMalloc((void**)&d_enc_0_conv_relu_1, sizeof(datatype) * ENC_0_CONV_RELU_1_N * ENC_0_CONV_RELU_1_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_enc_0_conv_relu_1_w, sizeof(datatype) * ENC_0_CONV_RELU_1_K * ENC_0_CONV_RELU_1_INPUT_FEATURES*ENC_0_CONV_RELU_1_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_enc_0_conv_relu_1_w, enc_0_conv_relu_1_w, ENC_0_CONV_RELU_1_K * ENC_0_CONV_RELU_1_INPUT_FEATURES*ENC_0_CONV_RELU_1_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);
  cudaMalloc((void**)&d_enc_0_maxpool, sizeof(datatype) * (ENC_0_CONV_RELU_1_N/2) * ENC_0_CONV_RELU_1_OUTPUT_FEATURES);

  cudaMalloc((void**)&d_enc_1_conv_relu_0, sizeof(datatype) * ENC_1_CONV_RELU_0_N * ENC_1_CONV_RELU_0_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_enc_1_conv_relu_0_w, sizeof(datatype) * ENC_1_CONV_RELU_0_K*ENC_1_CONV_RELU_0_INPUT_FEATURES*ENC_1_CONV_RELU_0_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_enc_1_conv_relu_0_w, enc_1_conv_relu_0_w, ENC_1_CONV_RELU_0_K * ENC_1_CONV_RELU_0_INPUT_FEATURES*ENC_1_CONV_RELU_0_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);

  cudaMalloc((void**)&d_enc_1_conv_relu_1, sizeof(datatype) * ENC_1_CONV_RELU_1_N * ENC_1_CONV_RELU_1_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_enc_1_conv_relu_1_w, sizeof(datatype) * ENC_1_CONV_RELU_1_K*ENC_1_CONV_RELU_1_INPUT_FEATURES*ENC_1_CONV_RELU_1_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_enc_1_conv_relu_1_w, enc_1_conv_relu_1_w, ENC_1_CONV_RELU_1_K * ENC_1_CONV_RELU_1_INPUT_FEATURES*ENC_1_CONV_RELU_1_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);
  cudaMalloc((void**)&d_enc_1_maxpool, sizeof(datatype) * (ENC_1_CONV_RELU_1_N/2) * ENC_1_CONV_RELU_1_OUTPUT_FEATURES);

  cudaMalloc((void**)&d_enc_2_conv_relu_0, sizeof(datatype) * ENC_2_CONV_RELU_0_N * ENC_2_CONV_RELU_0_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_enc_2_conv_relu_0_w, sizeof(datatype) * ENC_2_CONV_RELU_0_K*ENC_2_CONV_RELU_0_INPUT_FEATURES*ENC_2_CONV_RELU_0_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_enc_2_conv_relu_0_w, enc_2_conv_relu_0_w, ENC_2_CONV_RELU_0_K * ENC_2_CONV_RELU_0_INPUT_FEATURES*ENC_2_CONV_RELU_0_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);

  cudaMalloc((void**)&d_enc_2_conv_relu_1, sizeof(datatype) * ENC_2_CONV_RELU_1_N * ENC_2_CONV_RELU_1_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_enc_2_conv_relu_1_w, sizeof(datatype) * ENC_2_CONV_RELU_1_K*ENC_2_CONV_RELU_1_INPUT_FEATURES*ENC_2_CONV_RELU_1_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_enc_2_conv_relu_1_w, enc_2_conv_relu_1_w, ENC_2_CONV_RELU_1_K * ENC_2_CONV_RELU_1_INPUT_FEATURES*ENC_2_CONV_RELU_1_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);    
  cudaMalloc((void**)&d_enc_2_maxpool, sizeof(datatype) * (ENC_2_CONV_RELU_1_N/2) * ENC_2_CONV_RELU_1_OUTPUT_FEATURES);

  cudaMalloc((void**)&d_enc_3_conv_relu_0, sizeof(datatype) * ENC_3_CONV_RELU_0_N * ENC_3_CONV_RELU_0_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_enc_3_conv_relu_0_w, sizeof(datatype) * ENC_3_CONV_RELU_0_K*ENC_3_CONV_RELU_0_INPUT_FEATURES*ENC_3_CONV_RELU_0_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_enc_3_conv_relu_0_w, enc_3_conv_relu_0_w, ENC_3_CONV_RELU_0_K * ENC_3_CONV_RELU_0_INPUT_FEATURES*ENC_3_CONV_RELU_0_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);

  cudaMalloc((void**)&d_enc_3_conv_relu_1, sizeof(datatype) * ENC_3_CONV_RELU_1_N * ENC_3_CONV_RELU_1_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_enc_3_conv_relu_1_w, sizeof(datatype) * ENC_3_CONV_RELU_1_K*ENC_3_CONV_RELU_1_INPUT_FEATURES*ENC_3_CONV_RELU_1_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_enc_3_conv_relu_1_w, enc_3_conv_relu_1_w, ENC_3_CONV_RELU_1_K * ENC_3_CONV_RELU_1_INPUT_FEATURES*ENC_3_CONV_RELU_1_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);    
  cudaMalloc((void**)&d_enc_3_maxpool, sizeof(datatype) * (ENC_3_CONV_RELU_1_N/2) * ENC_3_CONV_RELU_1_OUTPUT_FEATURES);
  
  cudaMalloc((void**)&d_central_conv_relu_0, sizeof(datatype) * CENTRAL_CONV_RELU_0_N * CENTRAL_CONV_RELU_0_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_central_conv_relu_0_w, sizeof(datatype) * CENTRAL_CONV_RELU_0_K*CENTRAL_CONV_RELU_0_INPUT_FEATURES*CENTRAL_CONV_RELU_0_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_central_conv_relu_0_w, central_conv_relu_0_w, CENTRAL_CONV_RELU_0_K*CENTRAL_CONV_RELU_0_INPUT_FEATURES*CENTRAL_CONV_RELU_0_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);

  cudaMalloc((void**)&d_central_conv_relu_1, sizeof(datatype) * CENTRAL_CONV_RELU_1_N * CENTRAL_CONV_RELU_1_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_central_conv_relu_1_w, sizeof(datatype) * CENTRAL_CONV_RELU_1_K*CENTRAL_CONV_RELU_1_INPUT_FEATURES*CENTRAL_CONV_RELU_1_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_central_conv_relu_1_w, central_conv_relu_1_w, CENTRAL_CONV_RELU_1_K*CENTRAL_CONV_RELU_1_INPUT_FEATURES*CENTRAL_CONV_RELU_1_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);

  cudaMalloc((void**)&d_dec_0_upsample, sizeof(datatype) * DEC_0_UP_CONV_RELU_N * DEC_0_UP_CONV_RELU_INPUT_FEATURES);
  cudaMalloc((void**)&d_dec_0_up_conv_relu, sizeof(datatype) * DEC_0_UP_CONV_RELU_N * DEC_0_UP_CONV_RELU_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_dec_0_up_conv_relu_w, sizeof(datatype) * DEC_0_UP_CONV_RELU_K*DEC_0_UP_CONV_RELU_INPUT_FEATURES*DEC_0_UP_CONV_RELU_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_dec_0_up_conv_relu_w, dec_0_up_conv_relu_w, DEC_0_UP_CONV_RELU_K*DEC_0_UP_CONV_RELU_INPUT_FEATURES*DEC_0_UP_CONV_RELU_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);
  cudaMalloc((void**)&d_dec_0_concatenate, sizeof(datatype) * DEC_0_UP_CONV_RELU_N * DEC_0_UP_CONV_RELU_OUTPUT_FEATURES*2);

  cudaMalloc((void**)&d_dec_0_conv_relu_0, sizeof(datatype) * DEC_0_CONV_RELU_0_N * DEC_0_CONV_RELU_0_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_dec_0_conv_relu_0_w, sizeof(datatype) * DEC_0_CONV_RELU_0_K*DEC_0_CONV_RELU_0_INPUT_FEATURES*DEC_0_CONV_RELU_0_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_dec_0_conv_relu_0_w, dec_0_conv_relu_0_w, DEC_0_CONV_RELU_0_K*DEC_0_CONV_RELU_0_INPUT_FEATURES*DEC_0_CONV_RELU_0_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);

  cudaMalloc((void**)&d_dec_0_conv_relu_1, sizeof(datatype) * DEC_0_CONV_RELU_1_N * DEC_0_CONV_RELU_1_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_dec_0_conv_relu_1_w, sizeof(datatype) * DEC_0_CONV_RELU_1_K*DEC_0_CONV_RELU_1_INPUT_FEATURES*DEC_0_CONV_RELU_1_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_dec_0_conv_relu_1_w, dec_0_conv_relu_1_w, DEC_0_CONV_RELU_1_K*DEC_0_CONV_RELU_1_INPUT_FEATURES*DEC_0_CONV_RELU_1_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);

  cudaMalloc((void**)&d_dec_1_upsample, sizeof(datatype) * DEC_1_UP_CONV_RELU_N * DEC_1_UP_CONV_RELU_INPUT_FEATURES);
  cudaMalloc((void**)&d_dec_1_up_conv_relu, sizeof(datatype) * DEC_1_UP_CONV_RELU_N * DEC_1_UP_CONV_RELU_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_dec_1_up_conv_relu_w, sizeof(datatype) * DEC_1_UP_CONV_RELU_K*DEC_1_UP_CONV_RELU_INPUT_FEATURES*DEC_1_UP_CONV_RELU_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_dec_1_up_conv_relu_w, dec_1_up_conv_relu_w, DEC_1_UP_CONV_RELU_K*DEC_1_UP_CONV_RELU_INPUT_FEATURES*DEC_1_UP_CONV_RELU_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);
  cudaMalloc((void**)&d_dec_1_concatenate, sizeof(datatype) * DEC_1_UP_CONV_RELU_N * DEC_1_UP_CONV_RELU_OUTPUT_FEATURES*2);

  cudaMalloc((void**)&d_dec_1_conv_relu_0, sizeof(datatype) * DEC_1_CONV_RELU_0_N * DEC_1_CONV_RELU_0_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_dec_1_conv_relu_0_w, sizeof(datatype) * DEC_1_CONV_RELU_0_K*DEC_1_CONV_RELU_0_INPUT_FEATURES*DEC_1_CONV_RELU_0_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_dec_1_conv_relu_0_w, dec_1_conv_relu_0_w, DEC_1_CONV_RELU_0_K*DEC_1_CONV_RELU_0_INPUT_FEATURES*DEC_1_CONV_RELU_0_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);

  cudaMalloc((void**)&d_dec_1_conv_relu_1, sizeof(datatype) * DEC_1_CONV_RELU_1_N * DEC_1_CONV_RELU_1_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_dec_1_conv_relu_1_w, sizeof(datatype) * DEC_1_CONV_RELU_1_K*DEC_1_CONV_RELU_1_INPUT_FEATURES*DEC_1_CONV_RELU_1_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_dec_1_conv_relu_1_w, dec_1_conv_relu_1_w, DEC_1_CONV_RELU_1_K*DEC_1_CONV_RELU_1_INPUT_FEATURES*DEC_1_CONV_RELU_1_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);

  cudaMalloc((void**)&d_dec_2_upsample, sizeof(datatype) * DEC_2_UP_CONV_RELU_N * DEC_2_UP_CONV_RELU_INPUT_FEATURES);
  cudaMalloc((void**)&d_dec_2_up_conv_relu, sizeof(datatype) * DEC_2_UP_CONV_RELU_N * DEC_2_UP_CONV_RELU_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_dec_2_up_conv_relu_w, sizeof(datatype) * DEC_2_UP_CONV_RELU_K*DEC_2_UP_CONV_RELU_INPUT_FEATURES*DEC_2_UP_CONV_RELU_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_dec_2_up_conv_relu_w, dec_2_up_conv_relu_w, DEC_2_UP_CONV_RELU_K*DEC_2_UP_CONV_RELU_INPUT_FEATURES*DEC_2_UP_CONV_RELU_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);
  cudaMalloc((void**)&d_dec_2_concatenate, sizeof(datatype) * DEC_2_UP_CONV_RELU_N * DEC_2_UP_CONV_RELU_OUTPUT_FEATURES*2);

  cudaMalloc((void**)&d_dec_2_conv_relu_0, sizeof(datatype) * DEC_2_CONV_RELU_0_N * DEC_2_CONV_RELU_0_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_dec_2_conv_relu_0_w, sizeof(datatype) * DEC_2_CONV_RELU_0_K*DEC_2_CONV_RELU_0_INPUT_FEATURES*DEC_2_CONV_RELU_0_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_dec_2_conv_relu_0_w, dec_2_conv_relu_0_w, DEC_2_CONV_RELU_0_K*DEC_2_CONV_RELU_0_INPUT_FEATURES*DEC_2_CONV_RELU_0_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);

  cudaMalloc((void**)&d_dec_2_conv_relu_1, sizeof(datatype) * DEC_2_CONV_RELU_1_N * DEC_2_CONV_RELU_1_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_dec_2_conv_relu_1_w, sizeof(datatype) * DEC_2_CONV_RELU_1_K*DEC_2_CONV_RELU_1_INPUT_FEATURES*DEC_2_CONV_RELU_1_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_dec_2_conv_relu_1_w, dec_2_conv_relu_1_w, DEC_2_CONV_RELU_1_K*DEC_2_CONV_RELU_1_INPUT_FEATURES*DEC_2_CONV_RELU_1_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);

  cudaMalloc((void**)&d_dec_3_upsample, sizeof(datatype) * DEC_3_UP_CONV_RELU_N * DEC_3_UP_CONV_RELU_INPUT_FEATURES);
  cudaMalloc((void**)&d_dec_3_up_conv_relu, sizeof(datatype) * DEC_3_UP_CONV_RELU_N * DEC_3_UP_CONV_RELU_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_dec_3_up_conv_relu_w, sizeof(datatype) * DEC_3_UP_CONV_RELU_K*DEC_3_UP_CONV_RELU_INPUT_FEATURES*DEC_3_UP_CONV_RELU_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_dec_3_up_conv_relu_w, dec_3_up_conv_relu_w, DEC_3_UP_CONV_RELU_K*DEC_3_UP_CONV_RELU_INPUT_FEATURES*DEC_3_UP_CONV_RELU_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);
  cudaMalloc((void**)&d_dec_3_concatenate, sizeof(datatype) * DEC_3_UP_CONV_RELU_N * DEC_3_UP_CONV_RELU_OUTPUT_FEATURES*2);

  cudaMalloc((void**)&d_dec_3_conv_relu_0, sizeof(datatype) * DEC_3_CONV_RELU_0_N * DEC_3_CONV_RELU_0_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_dec_3_conv_relu_0_w, sizeof(datatype) * DEC_3_CONV_RELU_0_K*DEC_3_CONV_RELU_0_INPUT_FEATURES*DEC_3_CONV_RELU_0_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_dec_3_conv_relu_0_w, dec_3_conv_relu_0_w, DEC_3_CONV_RELU_0_K*DEC_3_CONV_RELU_0_INPUT_FEATURES*DEC_3_CONV_RELU_0_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);

  cudaMalloc((void**)&d_dec_3_conv_relu_1, sizeof(datatype) * DEC_3_CONV_RELU_1_N * DEC_3_CONV_RELU_1_OUTPUT_FEATURES);
  cudaMalloc((void**)&d_dec_3_conv_relu_1_w, sizeof(datatype) * DEC_3_CONV_RELU_1_K*DEC_3_CONV_RELU_1_INPUT_FEATURES*DEC_3_CONV_RELU_1_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_dec_3_conv_relu_1_w, dec_3_conv_relu_1_w, DEC_3_CONV_RELU_1_K*DEC_3_CONV_RELU_1_INPUT_FEATURES*DEC_3_CONV_RELU_1_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);

  cudaMalloc((void**)&d_final_conv_w, sizeof(datatype) * FINAL_CONV_K*FINAL_CONV_INPUT_FEATURES*FINAL_CONV_OUTPUT_FEATURES);
  cudaMemcpyAsync(d_final_conv_w, final_conv_w, FINAL_CONV_K*FINAL_CONV_INPUT_FEATURES*FINAL_CONV_OUTPUT_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);

  cudaMalloc((void**)&d_y, sizeof(datatype) * N*N_STATES);
  cudaMalloc((void**)&d_final_conv, sizeof(datatype) * FINAL_CONV_N * FINAL_CONV_OUTPUT_FEATURES);
  cudaMemsetAsync(d_final_conv, 0, sizeof(datatype)* FINAL_CONV_N * FINAL_CONV_OUTPUT_FEATURES);
  //checkCudaError(__LINE__);

  dim3 dimBlock(THREADS, THREADS); //each block is THREADxTHREAD
	dim3 dimGrid_enc00((ENC_0_CONV_RELU_0_N+dimBlock.x-1)/dimBlock.x, (ENC_0_CONV_RELU_0_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);
	dim3 dimGrid_enc01((ENC_0_CONV_RELU_1_N+dimBlock.x-1)/dimBlock.x, (ENC_0_CONV_RELU_1_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);
  dim3 dimGrid_max01((ENC_0_CONV_RELU_1_OUTPUT_FEATURES+dimBlock.x-1)/dimBlock.x, ((ENC_0_CONV_RELU_1_N/2)+dimBlock.y-1)/dimBlock.y);

  dim3 dimGrid_enc10((ENC_1_CONV_RELU_0_N+dimBlock.x-1)/dimBlock.x, (ENC_1_CONV_RELU_0_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);
	dim3 dimGrid_enc11((ENC_1_CONV_RELU_1_N+dimBlock.x-1)/dimBlock.x, (ENC_1_CONV_RELU_1_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);
  dim3 dimGrid_max11((ENC_1_CONV_RELU_1_OUTPUT_FEATURES+dimBlock.x-1)/dimBlock.x, ((ENC_1_CONV_RELU_1_N/2)+dimBlock.y-1)/dimBlock.y);

  dim3 dimGrid_enc20((ENC_2_CONV_RELU_0_N+dimBlock.x-1)/dimBlock.x, (ENC_2_CONV_RELU_0_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);
	dim3 dimGrid_enc21((ENC_2_CONV_RELU_1_N+dimBlock.x-1)/dimBlock.x, (ENC_2_CONV_RELU_1_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);
  dim3 dimGrid_max21((ENC_2_CONV_RELU_1_OUTPUT_FEATURES+dimBlock.x-1)/dimBlock.x, ((ENC_2_CONV_RELU_1_N/2)+dimBlock.y-1)/dimBlock.y);

  dim3 dimGrid_enc30((ENC_3_CONV_RELU_0_N+dimBlock.x-1)/dimBlock.x, (ENC_3_CONV_RELU_0_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);
	dim3 dimGrid_enc31((ENC_3_CONV_RELU_1_N+dimBlock.x-1)/dimBlock.x, (ENC_3_CONV_RELU_1_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);
  dim3 dimGrid_max31((ENC_3_CONV_RELU_1_OUTPUT_FEATURES+dimBlock.x-1)/dimBlock.x, ((ENC_3_CONV_RELU_1_N/2)+dimBlock.y-1)/dimBlock.y);

  dim3 dimGrid_cent0((CENTRAL_CONV_RELU_0_N+dimBlock.x-1)/dimBlock.x, (CENTRAL_CONV_RELU_0_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);
	dim3 dimGrid_cent1((CENTRAL_CONV_RELU_1_N+dimBlock.x-1)/dimBlock.x, (CENTRAL_CONV_RELU_1_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);

  dim3 dimGrid_dec_0_up((DEC_0_UP_CONV_RELU_INPUT_FEATURES+dimBlock.x-1)/dimBlock.x, ((DEC_0_UP_CONV_RELU_N/2)+dimBlock.y-1)/dimBlock.y);
  dim3 dimGrid_dec_0_up_conv((DEC_0_UP_CONV_RELU_N+dimBlock.x-1)/dimBlock.x, (DEC_0_UP_CONV_RELU_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);
  dim3 dimGrid_dec_0_conc((DEC_0_UP_CONV_RELU_OUTPUT_FEATURES+dimBlock.x-1)/dimBlock.x, (DEC_0_UP_CONV_RELU_N+dimBlock.y-1)/dimBlock.y);
  dim3 dimGrid_dec_00((DEC_0_CONV_RELU_0_N+dimBlock.x-1)/dimBlock.x, (DEC_0_CONV_RELU_0_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);
  dim3 dimGrid_dec_01((DEC_0_CONV_RELU_1_N+dimBlock.x-1)/dimBlock.x, (DEC_0_CONV_RELU_1_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);

  dim3 dimGrid_dec_1_up((DEC_1_UP_CONV_RELU_INPUT_FEATURES+dimBlock.x-1)/dimBlock.x, ((DEC_1_UP_CONV_RELU_N/2)+dimBlock.y-1)/dimBlock.y);
  dim3 dimGrid_dec_1_up_conv((DEC_1_UP_CONV_RELU_N+dimBlock.x-1)/dimBlock.x, (DEC_1_UP_CONV_RELU_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);
  dim3 dimGrid_dec_1_conc((DEC_1_UP_CONV_RELU_OUTPUT_FEATURES+dimBlock.x-1)/dimBlock.x, (DEC_1_UP_CONV_RELU_N+dimBlock.y-1)/dimBlock.y);
  dim3 dimGrid_dec_10((DEC_1_CONV_RELU_0_N+dimBlock.x-1)/dimBlock.x, (DEC_1_CONV_RELU_0_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);
  dim3 dimGrid_dec_11((DEC_1_CONV_RELU_1_N+dimBlock.x-1)/dimBlock.x, (DEC_1_CONV_RELU_1_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);

  dim3 dimGrid_dec_2_up((DEC_2_UP_CONV_RELU_INPUT_FEATURES+dimBlock.x-1)/dimBlock.x, ((DEC_2_UP_CONV_RELU_N/2)+dimBlock.y-1)/dimBlock.y);
  dim3 dimGrid_dec_2_up_conv((DEC_2_UP_CONV_RELU_N+dimBlock.x-1)/dimBlock.x, (DEC_2_UP_CONV_RELU_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);
  dim3 dimGrid_dec_2_conc((DEC_2_UP_CONV_RELU_OUTPUT_FEATURES+dimBlock.x-1)/dimBlock.x, (DEC_2_UP_CONV_RELU_N+dimBlock.y-1)/dimBlock.y);
  dim3 dimGrid_dec_20((DEC_2_CONV_RELU_0_N+dimBlock.x-1)/dimBlock.x, (DEC_2_CONV_RELU_0_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);
  dim3 dimGrid_dec_21((DEC_2_CONV_RELU_1_N+dimBlock.x-1)/dimBlock.x, (DEC_2_CONV_RELU_1_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);

  dim3 dimGrid_dec_3_up((DEC_3_UP_CONV_RELU_INPUT_FEATURES+dimBlock.x-1)/dimBlock.x, ((DEC_3_UP_CONV_RELU_N/2)+dimBlock.y-1)/dimBlock.y);
  dim3 dimGrid_dec_3_up_conv((DEC_3_UP_CONV_RELU_N+dimBlock.x-1)/dimBlock.x, (DEC_3_UP_CONV_RELU_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);
  dim3 dimGrid_dec_3_conc((DEC_3_UP_CONV_RELU_OUTPUT_FEATURES+dimBlock.x-1)/dimBlock.x, (DEC_3_UP_CONV_RELU_N+dimBlock.y-1)/dimBlock.y);
  dim3 dimGrid_dec_30((DEC_3_CONV_RELU_0_N+dimBlock.x-1)/dimBlock.x, (DEC_3_CONV_RELU_0_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);
  dim3 dimGrid_dec_31((DEC_3_CONV_RELU_1_N+dimBlock.x-1)/dimBlock.x, (DEC_3_CONV_RELU_1_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);

  dim3 dimGrid_fin((FINAL_CONV_N+dimBlock.x-1)/dimBlock.x, (FINAL_CONV_OUTPUT_FEATURES+dimBlock.y-1)/dimBlock.y);
  cudaDeviceSynchronize();
  //checkCudaError(__LINE__);

  clock_t time2 = clock();
  
  int byte_read;
  int i=0;
  
  do{  
    //-----------------------------ENCODER 0--------------------------------------
    conv_relu<<<dimGrid_enc00, dimBlock>>>(ENC_0_CONV_RELU_0_OUTPUT_FEATURES,ENC_0_CONV_RELU_0_N,ENC_0_CONV_RELU_0_K,ENC_0_CONV_RELU_0_INPUT_FEATURES,d_enc_0_conv_relu_0_w,d_x,d_enc_0_conv_relu_0);
    conv_relu<<<dimGrid_enc01, dimBlock>>>(ENC_0_CONV_RELU_1_OUTPUT_FEATURES,ENC_0_CONV_RELU_1_N,ENC_0_CONV_RELU_1_K,ENC_0_CONV_RELU_1_INPUT_FEATURES,d_enc_0_conv_relu_1_w,d_enc_0_conv_relu_0,d_enc_0_conv_relu_1);
    maxpooling<<<dimGrid_max01, dimBlock,sizeof(datatype) * 2*ENC_0_CONV_RELU_1_N * ENC_0_CONV_RELU_1_OUTPUT_FEATURES>>>(ENC_0_CONV_RELU_1_OUTPUT_FEATURES, ENC_0_CONV_RELU_1_N, d_enc_0_maxpool, d_enc_0_conv_relu_1);
    //checkCudaError(__LINE__);
    //----------------------------------------------------------------------------
    
    byte_read=fread(test_data, sizeof(datatype), N_FEATURES*N, f0);
    cudaMemcpyAsync(d_x, test_data, N*N_FEATURES * sizeof(datatype), cudaMemcpyHostToDevice);

    //-----------------------------ENCODER 1--------------------------------------
    conv_relu<<<dimGrid_enc10, dimBlock>>>(ENC_1_CONV_RELU_0_OUTPUT_FEATURES,ENC_1_CONV_RELU_0_N,ENC_1_CONV_RELU_0_K,ENC_1_CONV_RELU_0_INPUT_FEATURES,d_enc_1_conv_relu_0_w,d_enc_0_maxpool,d_enc_1_conv_relu_0);
    conv_relu<<<dimGrid_enc11, dimBlock>>>(ENC_1_CONV_RELU_1_OUTPUT_FEATURES,ENC_1_CONV_RELU_1_N,ENC_1_CONV_RELU_1_K,ENC_1_CONV_RELU_1_INPUT_FEATURES,d_enc_1_conv_relu_1_w,d_enc_1_conv_relu_0,d_enc_1_conv_relu_1);
    maxpooling<<<dimGrid_max11, dimBlock,sizeof(datatype) * 2* ENC_1_CONV_RELU_1_N * ENC_1_CONV_RELU_1_OUTPUT_FEATURES>>>(ENC_1_CONV_RELU_1_OUTPUT_FEATURES, ENC_1_CONV_RELU_1_N, d_enc_1_maxpool, d_enc_1_conv_relu_1);
    //checkCudaError(__LINE__);
    //----------------------------------------------------------------------------
    
    if(i>0){
      cudaMemcpyAsync(y, d_y, N*N_STATES * sizeof(datatype), cudaMemcpyDeviceToHost);
    }
    
    //-----------------------------ENCODER 2--------------------------------------
    conv_relu<<<dimGrid_enc20, dimBlock>>>(ENC_2_CONV_RELU_0_OUTPUT_FEATURES,ENC_2_CONV_RELU_0_N,ENC_2_CONV_RELU_0_K,ENC_2_CONV_RELU_0_INPUT_FEATURES,d_enc_2_conv_relu_0_w,d_enc_1_maxpool,d_enc_2_conv_relu_0);
    conv_relu<<<dimGrid_enc21, dimBlock>>>(ENC_2_CONV_RELU_1_OUTPUT_FEATURES,ENC_2_CONV_RELU_1_N,ENC_2_CONV_RELU_1_K,ENC_2_CONV_RELU_1_INPUT_FEATURES,d_enc_2_conv_relu_1_w,d_enc_2_conv_relu_0,d_enc_2_conv_relu_1);
    maxpooling<<<dimGrid_max21, dimBlock,sizeof(datatype) * 2* ENC_2_CONV_RELU_1_N * ENC_2_CONV_RELU_1_OUTPUT_FEATURES>>>(ENC_2_CONV_RELU_1_OUTPUT_FEATURES, ENC_2_CONV_RELU_1_N, d_enc_2_maxpool, d_enc_2_conv_relu_1);
    //checkCudaError(__LINE__);
    //----------------------------------------------------------------------------

    //-----------------------------ENCODER 3--------------------------------------
    conv_relu<<<dimGrid_enc30, dimBlock>>>(ENC_3_CONV_RELU_0_OUTPUT_FEATURES,ENC_3_CONV_RELU_0_N,ENC_3_CONV_RELU_0_K,ENC_3_CONV_RELU_0_INPUT_FEATURES,d_enc_3_conv_relu_0_w,d_enc_2_maxpool,d_enc_3_conv_relu_0);
    conv_relu<<<dimGrid_enc31, dimBlock>>>(ENC_3_CONV_RELU_1_OUTPUT_FEATURES,ENC_3_CONV_RELU_1_N,ENC_3_CONV_RELU_1_K,ENC_3_CONV_RELU_1_INPUT_FEATURES,d_enc_3_conv_relu_1_w,d_enc_3_conv_relu_0,d_enc_3_conv_relu_1);
    maxpooling<<<dimGrid_max31, dimBlock,sizeof(datatype) * 2*ENC_3_CONV_RELU_1_N * ENC_3_CONV_RELU_1_OUTPUT_FEATURES>>>(ENC_3_CONV_RELU_1_OUTPUT_FEATURES, ENC_3_CONV_RELU_1_N, d_enc_3_maxpool, d_enc_3_conv_relu_1);
    //checkCudaError(__LINE__);
    //----------------------------------------------------------------------------

    //--------------------------CENTRAL PART--------------------------------------
    conv_relu<<<dimGrid_cent0, dimBlock>>>(CENTRAL_CONV_RELU_0_OUTPUT_FEATURES,CENTRAL_CONV_RELU_0_N,CENTRAL_CONV_RELU_0_K,CENTRAL_CONV_RELU_0_INPUT_FEATURES,d_central_conv_relu_0_w,d_enc_3_maxpool,d_central_conv_relu_0);
    conv_relu<<<dimGrid_cent1, dimBlock>>>(CENTRAL_CONV_RELU_1_OUTPUT_FEATURES,CENTRAL_CONV_RELU_1_N,CENTRAL_CONV_RELU_1_K,CENTRAL_CONV_RELU_1_INPUT_FEATURES,d_central_conv_relu_1_w,d_central_conv_relu_0,d_central_conv_relu_1); 
    //checkCudaError(__LINE__);
    //----------------------------------------------------------------------------

    //-----------------------------DECODER 0--------------------------------------
    upsampling<<<dimGrid_dec_0_up, dimBlock,sizeof(datatype) * CENTRAL_CONV_RELU_1_N * CENTRAL_CONV_RELU_1_OUTPUT_FEATURES>>>(DEC_0_UP_CONV_RELU_INPUT_FEATURES, DEC_0_UP_CONV_RELU_N,CENTRAL_CONV_RELU_1_OUTPUT_FEATURES, d_dec_0_upsample, d_central_conv_relu_1);
    conv_relu<<<dimGrid_dec_0_up_conv, dimBlock>>>(DEC_0_UP_CONV_RELU_OUTPUT_FEATURES,DEC_0_UP_CONV_RELU_N,DEC_0_UP_CONV_RELU_K,DEC_0_UP_CONV_RELU_INPUT_FEATURES,d_dec_0_up_conv_relu_w,d_dec_0_upsample,d_dec_0_up_conv_relu);
    concatenation<<<dimGrid_dec_0_conc, dimBlock>>>(DEC_0_UP_CONV_RELU_OUTPUT_FEATURES,DEC_0_UP_CONV_RELU_N, d_dec_0_concatenate, d_enc_3_conv_relu_1,d_dec_0_up_conv_relu);
    conv_relu<<<dimGrid_dec_00, dimBlock>>>(DEC_0_CONV_RELU_0_OUTPUT_FEATURES,DEC_0_CONV_RELU_0_N,DEC_0_CONV_RELU_0_K,DEC_0_CONV_RELU_0_INPUT_FEATURES,d_dec_0_conv_relu_0_w,d_dec_0_concatenate,d_dec_0_conv_relu_0);
    conv_relu<<<dimGrid_dec_01, dimBlock>>>(DEC_0_CONV_RELU_1_OUTPUT_FEATURES,DEC_0_CONV_RELU_1_N,DEC_0_CONV_RELU_1_K,DEC_0_CONV_RELU_1_INPUT_FEATURES,d_dec_0_conv_relu_1_w,d_dec_0_conv_relu_0,d_dec_0_conv_relu_1);
    //checkCudaError(__LINE__);
    //----------------------------------------------------------------------------

    //-----------------------------DECODER 1--------------------------------------
    upsampling<<<dimGrid_dec_1_up, dimBlock,sizeof(datatype) * DEC_0_CONV_RELU_1_N * DEC_0_CONV_RELU_1_OUTPUT_FEATURES>>>(DEC_1_UP_CONV_RELU_INPUT_FEATURES, DEC_1_UP_CONV_RELU_N, DEC_0_CONV_RELU_1_OUTPUT_FEATURES, d_dec_1_upsample, d_dec_0_conv_relu_1);
    conv_relu<<<dimGrid_dec_1_up_conv, dimBlock>>>(DEC_1_UP_CONV_RELU_OUTPUT_FEATURES,DEC_1_UP_CONV_RELU_N,DEC_1_UP_CONV_RELU_K,DEC_1_UP_CONV_RELU_INPUT_FEATURES,d_dec_1_up_conv_relu_w,d_dec_1_upsample,d_dec_1_up_conv_relu);
    concatenation<<<dimGrid_dec_1_conc, dimBlock>>>(DEC_1_UP_CONV_RELU_OUTPUT_FEATURES,DEC_1_UP_CONV_RELU_N, d_dec_1_concatenate, d_enc_2_conv_relu_1,d_dec_1_up_conv_relu);
    conv_relu<<<dimGrid_dec_10, dimBlock>>>(DEC_1_CONV_RELU_0_OUTPUT_FEATURES,DEC_1_CONV_RELU_0_N,DEC_1_CONV_RELU_0_K,DEC_1_CONV_RELU_0_INPUT_FEATURES,d_dec_1_conv_relu_0_w,d_dec_1_concatenate,d_dec_1_conv_relu_0);
    conv_relu<<<dimGrid_dec_11, dimBlock>>>(DEC_1_CONV_RELU_1_OUTPUT_FEATURES,DEC_1_CONV_RELU_1_N,DEC_1_CONV_RELU_1_K,DEC_1_CONV_RELU_1_INPUT_FEATURES,d_dec_1_conv_relu_1_w,d_dec_1_conv_relu_0,d_dec_1_conv_relu_1);
    //checkCudaError(__LINE__);
    //----------------------------------------------------------------------------

    //-----------------------------DECODER 2--------------------------------------
    upsampling<<<dimGrid_dec_2_up, dimBlock,sizeof(datatype) * DEC_1_CONV_RELU_1_N * DEC_1_CONV_RELU_1_OUTPUT_FEATURES>>>(DEC_2_UP_CONV_RELU_INPUT_FEATURES, DEC_2_UP_CONV_RELU_N, DEC_1_CONV_RELU_1_OUTPUT_FEATURES, d_dec_2_upsample, d_dec_1_conv_relu_1);
    conv_relu<<<dimGrid_dec_2_up_conv, dimBlock>>>(DEC_2_UP_CONV_RELU_OUTPUT_FEATURES,DEC_2_UP_CONV_RELU_N,DEC_2_UP_CONV_RELU_K,DEC_2_UP_CONV_RELU_INPUT_FEATURES,d_dec_2_up_conv_relu_w,d_dec_2_upsample,d_dec_2_up_conv_relu);
    concatenation<<<dimGrid_dec_2_conc, dimBlock>>>(DEC_2_UP_CONV_RELU_OUTPUT_FEATURES,DEC_2_UP_CONV_RELU_N, d_dec_2_concatenate, d_enc_1_conv_relu_1,d_dec_2_up_conv_relu);
    conv_relu<<<dimGrid_dec_20, dimBlock>>>(DEC_2_CONV_RELU_0_OUTPUT_FEATURES,DEC_2_CONV_RELU_0_N,DEC_2_CONV_RELU_0_K,DEC_2_CONV_RELU_0_INPUT_FEATURES,d_dec_2_conv_relu_0_w,d_dec_2_concatenate,d_dec_2_conv_relu_0);
    conv_relu<<<dimGrid_dec_21, dimBlock>>>(DEC_2_CONV_RELU_1_OUTPUT_FEATURES,DEC_2_CONV_RELU_1_N,DEC_2_CONV_RELU_1_K,DEC_2_CONV_RELU_1_INPUT_FEATURES,d_dec_2_conv_relu_1_w,d_dec_2_conv_relu_0,d_dec_2_conv_relu_1);
    //checkCudaError(__LINE__);
    //----------------------------------------------------------------------------

    //-----------------------------DECODER 3--------------------------------------
    upsampling<<<dimGrid_dec_3_up, dimBlock,sizeof(datatype) * DEC_2_CONV_RELU_1_N * DEC_2_CONV_RELU_1_OUTPUT_FEATURES>>>(DEC_3_UP_CONV_RELU_INPUT_FEATURES, DEC_3_UP_CONV_RELU_N, DEC_2_CONV_RELU_1_OUTPUT_FEATURES, d_dec_3_upsample, d_dec_2_conv_relu_1);
    conv_relu<<<dimGrid_dec_3_up_conv, dimBlock>>>(DEC_3_UP_CONV_RELU_OUTPUT_FEATURES,DEC_3_UP_CONV_RELU_N,DEC_3_UP_CONV_RELU_K,DEC_3_UP_CONV_RELU_INPUT_FEATURES,d_dec_3_up_conv_relu_w,d_dec_3_upsample,d_dec_3_up_conv_relu);
    concatenation<<<dimGrid_dec_3_conc, dimBlock>>>(DEC_3_UP_CONV_RELU_OUTPUT_FEATURES,DEC_3_UP_CONV_RELU_N, d_dec_3_concatenate, d_enc_0_conv_relu_1,d_dec_3_up_conv_relu);
    conv_relu<<<dimGrid_dec_30, dimBlock>>>(DEC_3_CONV_RELU_0_OUTPUT_FEATURES,DEC_3_CONV_RELU_0_N,DEC_3_CONV_RELU_0_K,DEC_3_CONV_RELU_0_INPUT_FEATURES,d_dec_3_conv_relu_0_w,d_dec_3_concatenate,d_dec_3_conv_relu_0);
    conv_relu<<<dimGrid_dec_31, dimBlock>>>(DEC_3_CONV_RELU_1_OUTPUT_FEATURES,DEC_3_CONV_RELU_1_N,DEC_3_CONV_RELU_1_K,DEC_3_CONV_RELU_1_INPUT_FEATURES,d_dec_3_conv_relu_1_w,d_dec_3_conv_relu_0,d_dec_3_conv_relu_1);
    //checkCudaError(__LINE__);
    //----------------------------------------------------------------------------

    //----------------------------FINAL LAYER--------------------------------------
    conv_relu_last_layer<<<dimGrid_fin, dimBlock>>>(FINAL_CONV_OUTPUT_FEATURES,FINAL_CONV_N,FINAL_CONV_K,FINAL_CONV_INPUT_FEATURES,d_final_conv_w,d_dec_3_conv_relu_1,d_final_conv);
    Softmax<<<1,FINAL_CONV_N>>>(d_final_conv, d_y);
    //checkCudaError(__LINE__);
    //----------------------------------------------------------------------------

    if(i%7500==0){ //print elapsed time at each 30 patients
    	cudaDeviceSynchronize();
	    printf("Processed %d samples - time: %.5f seconds\n", (i+1)/250, ((double)clock()-time1) / CLOCKS_PER_SEC);
    }

    
    //VALIDATION
    /*cudaMemcpy(y, d_y, N*N_STATES * sizeof(datatype), cudaMemcpyDeviceToHost);
    cudaDeviceSynchronize();

    for(int j=0; j<N; j++){
      for(int k=0; k<N_STATES; k++){
        fprintf(output,"%.10f ", y[j*N_STATES+k]);
      }
      fprintf(output,"\n");
    }*/
        
    i++;
  }while(byte_read== N_FEATURES*N);
  cudaDeviceSynchronize();
  
  time2 = clock()-time2;

  cudaMemcpy(y, d_y, N*N_STATES * sizeof(datatype), cudaMemcpyDeviceToHost);
  cudaDeviceSynchronize();
  //checkCudaError(__LINE__);

  time1 = clock()-time1;
	printf("Time required for memory and parameters initialization: %.5f seconds\n", ((double)time1-time2) / CLOCKS_PER_SEC);
  printf("Elapsed computation time: %.5f seconds\n", ((double)time2) / CLOCKS_PER_SEC);
  printf("\nTotale elapsed time: %.5f seconds\n\n", ((double)(time1)) / CLOCKS_PER_SEC);


  //fclose(output);
  fclose(f0);

  cudaFree(d_enc_0_conv_relu_0);
  cudaFree(d_enc_0_conv_relu_1);
  cudaFree(d_enc_0_maxpool);

  cudaFree(d_enc_1_conv_relu_0);
  cudaFree(d_enc_1_conv_relu_1);
  cudaFree(d_enc_1_maxpool);

  cudaFree(d_enc_2_conv_relu_0);
  cudaFree(d_enc_2_conv_relu_1);
  cudaFree(d_enc_2_maxpool);

  cudaFree(d_enc_3_conv_relu_0);
  cudaFree(d_enc_3_conv_relu_1);
  cudaFree(d_enc_3_maxpool);

  cudaFree(d_central_conv_relu_0);
  cudaFree(d_central_conv_relu_1);

  cudaFree(d_dec_0_upsample);
  cudaFree(d_dec_0_up_conv_relu);
  cudaFree(d_dec_0_concatenate);
  cudaFree(d_dec_0_conv_relu_0);
  cudaFree(d_dec_0_conv_relu_1);

  cudaFree(d_dec_1_upsample);
  cudaFree(d_dec_1_up_conv_relu);
  cudaFree(d_dec_1_concatenate);
  cudaFree(d_dec_1_conv_relu_0);
  cudaFree(d_dec_1_conv_relu_1);

  cudaFree(d_dec_2_upsample);
  cudaFree(d_dec_2_up_conv_relu);
  cudaFree(d_dec_2_concatenate);
  cudaFree(d_dec_2_conv_relu_0);
  cudaFree(d_dec_2_conv_relu_1);

  cudaFree(d_dec_3_upsample);
  cudaFree(d_dec_3_up_conv_relu);
  cudaFree(d_dec_3_concatenate);
  cudaFree(d_dec_3_conv_relu_0);
  cudaFree(d_dec_3_conv_relu_1);

  cudaFree(d_final_conv);

  cudaFree(d_x);
  cudaFree(d_enc_0_conv_relu_0_w);
  cudaFree(d_enc_0_conv_relu_1_w);

  cudaFree(d_enc_1_conv_relu_0_w);
  cudaFree(d_enc_1_conv_relu_1_w);

  cudaFree(d_enc_2_conv_relu_0_w);
  cudaFree(d_enc_2_conv_relu_1_w);

  cudaFree(d_enc_3_conv_relu_0_w);
  cudaFree(d_enc_3_conv_relu_1_w);

  cudaFree(d_central_conv_relu_0_w);
  cudaFree(d_central_conv_relu_1_w);

  cudaFree(d_dec_0_up_conv_relu_w);
  cudaFree(d_dec_0_conv_relu_0_w);
  cudaFree(d_dec_0_conv_relu_1_w);

  cudaFree(d_dec_1_up_conv_relu_w);
  cudaFree(d_dec_1_conv_relu_0_w);
  cudaFree(d_dec_1_conv_relu_1_w);

  cudaFree(d_dec_2_up_conv_relu_w);
  cudaFree(d_dec_2_conv_relu_0_w);
  cudaFree(d_dec_2_conv_relu_1_w);

  cudaFree(d_dec_3_up_conv_relu_w);
  cudaFree(d_dec_3_conv_relu_0_w);
  cudaFree(d_dec_3_conv_relu_1_w);

  cudaFree(d_final_conv_w);
  cudaFree(d_y);
  //checkCudaError(__LINE__);

  free(y);
  free(test_data);

  return 0;
}