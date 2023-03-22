#include "functions.h"
#include "segmenter.h"
#include <airisc.h>
#include <ee_printf.h>

//Data for tests
#include "test_data.h"
#include "weights.h"

int main(int argc, char *argv[]){
    datatype y[N][N_STATES];
    
    uint64_t time;
    timer_set_time(timer0, 0);

    for(int i=0; i<TEST_SAMPLES_BATCH;i++){
         Segmenter((test_data+i*N_FEATURES*N),
               enc_0_conv_relu_0_w,enc_0_conv_relu_1_w,enc_1_conv_relu_0_w,
               enc_1_conv_relu_1_w,enc_2_conv_relu_0_w,enc_2_conv_relu_1_w,
               enc_3_conv_relu_0_w,enc_3_conv_relu_1_w,central_conv_relu_0_w,
               central_conv_relu_1_w,dec_0_up_conv_relu_w,dec_0_conv_relu_0_w,
               dec_0_conv_relu_1_w,dec_1_up_conv_relu_w,dec_1_conv_relu_0_w,
               dec_1_conv_relu_1_w,dec_2_up_conv_relu_w,dec_2_conv_relu_0_w,
               dec_2_conv_relu_1_w,dec_3_up_conv_relu_w,dec_3_conv_relu_0_w,
               dec_3_conv_relu_1_w,final_conv_w,y);
    }
    
    time = timer_get_time(timer0);
	ee_printf("Elapsed computation time: %.5f seconds\n", ((float)time) / 32);
}