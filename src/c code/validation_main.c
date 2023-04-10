#include "functions.h"
#include "segmenter.h"
#include <stdio.h>

//Data for tests
#include "weights.h"

int main(int argc, char *argv[]){
    FILE *pythonOutput, *f0;

    if((pythonOutput = fopen("python_result.txt","r"))==NULL || (f0 = fopen("test_data.bin", "rb"))==NULL){
        printf("Failed opening files\n");
        return 1;
    }

    //If one wants to check the input data used against the one from the Python code should put them in a file and decomment the following lines
    /* FILE *input;
    if((input = fopen("X_0_0.txt","r"))==NULL){
        printf("Failed opening files\n");
        return 1;
    }*/

    datatype test_data[N_FEATURES*N];
    datatype y[N][N_STATES];
    datatype value;

    fread(test_data, sizeof(datatype), N_FEATURES*N, f0); //Patient 0, image 0. Each patient has 250 images (0-249) N_FEATURES*N wide

    //VALIDATION OF THE NETWORK
    
    //Validation of the input data
    /*for(int j=0; j<N; j++){
        for(int k=0; k<N_FEATURES;k++){
            #ifdef FLOAT
            fscanf(input,"%f",&value);
            #endif
            #ifdef DOUBLE
            fscanf(input,"%lf",&value);
            #endif               
            if(test_data[j*N_FEATURES+k]!=value){
                printf("Input data are different!\nROW: %d COL: %d - %.10f %.10f\n",j,k,test_data[j*N_FEATURES+k],value);
            }
        }
    }*/

    Segmenter(test_data,
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
                printf("ROW: %d COL: %d - %.18f %.18f - abs_err:  %.18f \n",j,k,y[j][k],value, fabs(y[j][k]-value)); //remember that the abs error depends on the amount of decimals in the txt files
            }
        }
    }

    fclose(pythonOutput);
    //fclose(input);
    fclose(f0);

    return 0;
}