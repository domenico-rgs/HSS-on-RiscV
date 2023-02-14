#include "functions.h"
#include "segmenter.h"
#include <time.h>

//Data for tests
#include "test_data.h"
#include "weights.h"

int main(int argc, char *argv[]){
    float y[N][N_STATES];

    clock_t time = clock();

    for(int i=0; i<TEST_SAMPLES_BATCH;i++){
         Segmenter((test_data+i*TEST_SAMPLES_BATCH),
               enc_0_conv_relu_0_w,enc_0_conv_relu_1_w,enc_1_conv_relu_0_w,
               enc_1_conv_relu_1_w,enc_2_conv_relu_0_w,enc_2_conv_relu_1_w,
               enc_3_conv_relu_0_w,enc_3_conv_relu_1_w,central_conv_relu_0_w,
               central_conv_relu_1_w,dec_0_up_conv_relu_w,dec_0_conv_relu_0_w,
               dec_0_conv_relu_1_w,dec_1_up_conv_relu_w,dec_1_conv_relu_0_w,
               dec_1_conv_relu_1_w,dec_2_up_conv_relu_w,dec_2_conv_relu_0_w,
               dec_2_conv_relu_1_w,dec_3_up_conv_relu_w,dec_3_conv_relu_0_w,
               dec_3_conv_relu_1_w,final_conv_w,y);
    }

    time = clock()-time;
	printf("Elapsed computation time: %.5f seconds\n", ((double)time) / CLOCKS_PER_SEC);
}