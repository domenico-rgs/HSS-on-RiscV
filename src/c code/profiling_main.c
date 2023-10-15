#include "segmenter.h"
#include <time.h>

//Data for tests
#include "weights.h"

int main(int argc, char *argv[]){
    FILE* f0;

    if((f0 = fopen("test_data.bin", "rb"))==NULL){
        printf("Failed opening files\n");
        return 1;
    }

    datatype y[N][N_STATES];
    datatype test_data[N_FEATURES*N];
    int i=0;
    
    clock_t time = clock();

    while(fread(test_data, sizeof(datatype), N_FEATURES*N, f0) == N_FEATURES*N){
        Segmenter(test_data,
            enc_0_conv_relu_0_w,enc_0_conv_relu_1_w,enc_1_conv_relu_0_w,
            enc_1_conv_relu_1_w,enc_2_conv_relu_0_w,enc_2_conv_relu_1_w,
            enc_3_conv_relu_0_w,enc_3_conv_relu_1_w,central_conv_relu_0_w,
            central_conv_relu_1_w,dec_0_up_conv_relu_w,dec_0_conv_relu_0_w,
            dec_0_conv_relu_1_w,dec_1_up_conv_relu_w,dec_1_conv_relu_0_w,
            dec_1_conv_relu_1_w,dec_2_up_conv_relu_w,dec_2_conv_relu_0_w,
            dec_2_conv_relu_1_w,dec_3_up_conv_relu_w,dec_3_conv_relu_0_w,
            dec_3_conv_relu_1_w,final_conv_w,y);
        
        //sequentialMaxTM(y);

        if(i%7500==0){ //print elapsed time at each 30 patients
            printf("Processed %d samples - time: %.5f seconds\n", (i+1)/250, ((double)clock()-time) / CLOCKS_PER_SEC);
        }
        
        i++;
    }

	printf("\nTotal elapsed computation time (%d samples): %.5f seconds\n",(i+1)/250, ((double)clock()-time) / CLOCKS_PER_SEC);

    fclose(f0);
    return 0;
}