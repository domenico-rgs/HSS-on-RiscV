#include "functions.h"
#include "segmenter.h"
#include <stdio.h>

//Data for tests
#include "test_data.h"
#include "weights.h"

int main(int argc, char *argv[]){
    FILE* input,*pythonOutput;

    if((input = fopen("X_0_0.txt","r"))==NULL || (pythonOutput = fopen("python_result.txt","r"))==NULL){
        printf("Failed opening files\n");
        return 1;
    }

    datatype y[N][N_STATES];
    datatype value;

    //VALIDATION OF THE NETWORK
    for(int i=0; i<1;i++){ //i<TEST_SAMPLES_BATCH

        //Validation of the input data
        for(int j=0; j<N; j++){
            for(int k=0; k<N_FEATURES;k++){
                #ifdef FLOAT
                fscanf(input,"%f",&value);
                #endif
                #ifdef DOUBLE
                fscanf(input,"%lf",&value);
                #endif               
                if(test_data[i*TEST_SAMPLES_BATCH+j*N_FEATURES+k]!=value){
                    printf("Input data are different!\nROW: %d COL: %d - %.10f %.10f\n",j,k,test_data[i*TEST_SAMPLES_BATCH+j*N_FEATURES+k],value);
                }
            }
        }

         Segmenter((test_data+i*TEST_SAMPLES_BATCH),
               enc_0_conv_relu_0_w,enc_0_conv_relu_1_w,enc_1_conv_relu_0_w,
               enc_1_conv_relu_1_w,enc_2_conv_relu_0_w,enc_2_conv_relu_1_w,
               enc_3_conv_relu_0_w,enc_3_conv_relu_1_w,central_conv_relu_0_w,
               central_conv_relu_1_w,dec_0_up_conv_relu_w,dec_0_conv_relu_0_w,
               dec_0_conv_relu_1_w,dec_1_up_conv_relu_w,dec_1_conv_relu_0_w,
               dec_1_conv_relu_1_w,dec_2_up_conv_relu_w,dec_2_conv_relu_0_w,
               dec_2_conv_relu_1_w,dec_3_up_conv_relu_w,dec_3_conv_relu_0_w,
               dec_3_conv_relu_1_w,final_conv_w,y);
    
        //Checking whether results from the network and the one from Python code are the same or not
        for(int j=0; j<N; j++){
            for(int k=0; k<N_STATES; k++){
                #ifdef FLOAT
                fscanf(pythonOutput,"%f",&value);
                #endif
                #ifdef DOUBLE
                fscanf(pythonOutput,"%lf",&value);
                #endif  
                if(y[j][k]!=value){
                    printf("Results are different\nROW: %d COL: %d - %.10f %.10f\n",j,k,y[j][k],value);
                }
            }
        }
    }

    fclose(pythonOutput);
    fclose(input);
}