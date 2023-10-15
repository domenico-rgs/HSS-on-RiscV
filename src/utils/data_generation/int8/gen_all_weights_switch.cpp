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

// #include <iostream>
#include <stdio.h>
#include <fstream>
#include <iomanip>      // std::setprecision

#include "segmenter.h"
#include "npy_reading.h"

#ifdef FPXINT
    #define FXP_VALUE 6
#endif

using namespace std;

int main(int argc, char *argv[]) {
    setvbuf(stdout, NULL, _IONBF, 0);

    printf("Program started\n");

    // Root path of the model
    string model_path = "../../../../data/weights/";
    char subdirectory[256];

    //------------------------INITIALIZE ARRAYS---------------------------------

    // Initialize model parameters variables
    arraytype enc_0_conv_relu_0_tmp[ENC_0_CONV_RELU_0_K * ENC_0_CONV_RELU_0_INPUT_FEATURES * ENC_0_CONV_RELU_0_OUTPUT_FEATURES];
    int enc_0_conv_relu_0_shape[4];
    arraytype enc_0_conv_relu_0_w[ENC_0_CONV_RELU_0_OUTPUT_FEATURES][ENC_0_CONV_RELU_0_K][ENC_0_CONV_RELU_0_INPUT_FEATURES];

    arraytype enc_0_conv_relu_1_tmp[ENC_0_CONV_RELU_1_K * ENC_0_CONV_RELU_1_INPUT_FEATURES * ENC_0_CONV_RELU_1_OUTPUT_FEATURES];
    int enc_0_conv_relu_1_shape[4];
    arraytype enc_0_conv_relu_1_w[ENC_0_CONV_RELU_1_OUTPUT_FEATURES][ENC_0_CONV_RELU_1_K][ENC_0_CONV_RELU_1_INPUT_FEATURES];

    arraytype enc_1_conv_relu_0_tmp[ENC_1_CONV_RELU_0_K * ENC_1_CONV_RELU_0_INPUT_FEATURES * ENC_1_CONV_RELU_0_OUTPUT_FEATURES];
    int enc_1_conv_relu_0_shape[4];
    arraytype enc_1_conv_relu_0_w[ENC_1_CONV_RELU_0_OUTPUT_FEATURES][ENC_1_CONV_RELU_0_K][ENC_1_CONV_RELU_0_INPUT_FEATURES];

    arraytype enc_1_conv_relu_1_tmp[ENC_1_CONV_RELU_1_K * ENC_1_CONV_RELU_1_INPUT_FEATURES * ENC_1_CONV_RELU_1_OUTPUT_FEATURES];
    int enc_1_conv_relu_1_shape[4];
    arraytype enc_1_conv_relu_1_w[ENC_1_CONV_RELU_1_OUTPUT_FEATURES][ENC_1_CONV_RELU_1_K][ENC_1_CONV_RELU_1_INPUT_FEATURES];

    arraytype enc_2_conv_relu_0_tmp[ENC_2_CONV_RELU_0_K * ENC_2_CONV_RELU_0_INPUT_FEATURES * ENC_2_CONV_RELU_0_OUTPUT_FEATURES];
    int enc_2_conv_relu_0_shape[4];
    arraytype enc_2_conv_relu_0_w[ENC_2_CONV_RELU_0_OUTPUT_FEATURES][ENC_2_CONV_RELU_0_K][ENC_2_CONV_RELU_0_INPUT_FEATURES];

    arraytype enc_2_conv_relu_1_tmp[ENC_2_CONV_RELU_1_K * ENC_2_CONV_RELU_1_INPUT_FEATURES * ENC_2_CONV_RELU_1_OUTPUT_FEATURES];
    int enc_2_conv_relu_1_shape[4];
    arraytype enc_2_conv_relu_1_w[ENC_2_CONV_RELU_1_OUTPUT_FEATURES][ENC_2_CONV_RELU_1_K][ENC_2_CONV_RELU_1_INPUT_FEATURES];

    arraytype enc_3_conv_relu_0_tmp[ENC_3_CONV_RELU_0_K * ENC_3_CONV_RELU_0_INPUT_FEATURES * ENC_3_CONV_RELU_0_OUTPUT_FEATURES];
    int enc_3_conv_relu_0_shape[4];
    arraytype enc_3_conv_relu_0_w[ENC_3_CONV_RELU_0_OUTPUT_FEATURES][ENC_3_CONV_RELU_0_K][ENC_3_CONV_RELU_0_INPUT_FEATURES];

    arraytype enc_3_conv_relu_1_tmp[ENC_3_CONV_RELU_1_K * ENC_3_CONV_RELU_1_INPUT_FEATURES * ENC_3_CONV_RELU_1_OUTPUT_FEATURES];
    int enc_3_conv_relu_1_shape[4];
    arraytype enc_3_conv_relu_1_w[ENC_3_CONV_RELU_1_OUTPUT_FEATURES][ENC_3_CONV_RELU_1_K][ENC_3_CONV_RELU_1_INPUT_FEATURES];

    arraytype central_conv_relu_0_tmp[CENTRAL_CONV_RELU_0_K * CENTRAL_CONV_RELU_0_INPUT_FEATURES * CENTRAL_CONV_RELU_0_OUTPUT_FEATURES];
    int central_conv_relu_0_shape[4];
    arraytype central_conv_relu_0_w[CENTRAL_CONV_RELU_0_OUTPUT_FEATURES][CENTRAL_CONV_RELU_0_K][CENTRAL_CONV_RELU_0_INPUT_FEATURES];

    arraytype central_conv_relu_1_tmp[CENTRAL_CONV_RELU_1_K * CENTRAL_CONV_RELU_1_INPUT_FEATURES * CENTRAL_CONV_RELU_1_OUTPUT_FEATURES];
    int central_conv_relu_1_shape[4];
    arraytype central_conv_relu_1_w[CENTRAL_CONV_RELU_1_OUTPUT_FEATURES][CENTRAL_CONV_RELU_1_K][CENTRAL_CONV_RELU_1_INPUT_FEATURES];

    arraytype dec_0_up_conv_relu_tmp[DEC_0_UP_CONV_RELU_K * DEC_0_UP_CONV_RELU_INPUT_FEATURES * DEC_0_UP_CONV_RELU_OUTPUT_FEATURES];
    int dec_0_up_conv_relu_shape[4];
    arraytype dec_0_up_conv_relu_w[DEC_0_UP_CONV_RELU_OUTPUT_FEATURES][DEC_0_UP_CONV_RELU_K][DEC_0_UP_CONV_RELU_INPUT_FEATURES];

    arraytype dec_0_conv_relu_0_tmp[DEC_0_CONV_RELU_0_K * DEC_0_CONV_RELU_0_INPUT_FEATURES * DEC_0_CONV_RELU_0_OUTPUT_FEATURES];
    int dec_0_conv_relu_0_shape[4];
    arraytype dec_0_conv_relu_0_w[DEC_0_CONV_RELU_0_OUTPUT_FEATURES][DEC_0_CONV_RELU_0_K][DEC_0_CONV_RELU_0_INPUT_FEATURES];

    arraytype dec_0_conv_relu_1_tmp[DEC_0_CONV_RELU_1_K * DEC_0_CONV_RELU_1_INPUT_FEATURES * DEC_0_CONV_RELU_1_OUTPUT_FEATURES];
    int dec_0_conv_relu_1_shape[4];
    arraytype dec_0_conv_relu_1_w[DEC_0_CONV_RELU_1_OUTPUT_FEATURES][DEC_0_CONV_RELU_1_K][DEC_0_CONV_RELU_1_INPUT_FEATURES];

    arraytype dec_1_up_conv_relu_tmp[DEC_1_UP_CONV_RELU_K * DEC_1_UP_CONV_RELU_INPUT_FEATURES * DEC_1_UP_CONV_RELU_OUTPUT_FEATURES];
    int dec_1_up_conv_relu_shape[4];
    arraytype dec_1_up_conv_relu_w[DEC_1_UP_CONV_RELU_OUTPUT_FEATURES][DEC_1_UP_CONV_RELU_K][DEC_1_UP_CONV_RELU_INPUT_FEATURES];

    arraytype dec_1_conv_relu_0_tmp[DEC_1_CONV_RELU_0_K * DEC_1_CONV_RELU_0_INPUT_FEATURES * DEC_1_CONV_RELU_0_OUTPUT_FEATURES];
    int dec_1_conv_relu_0_shape[4];
    arraytype dec_1_conv_relu_0_w[DEC_1_CONV_RELU_0_OUTPUT_FEATURES][DEC_1_CONV_RELU_0_K][DEC_1_CONV_RELU_0_INPUT_FEATURES];

    arraytype dec_1_conv_relu_1_tmp[DEC_1_CONV_RELU_1_K * DEC_1_CONV_RELU_1_INPUT_FEATURES * DEC_1_CONV_RELU_1_OUTPUT_FEATURES];
    int dec_1_conv_relu_1_shape[4];
    arraytype dec_1_conv_relu_1_w[DEC_1_CONV_RELU_1_OUTPUT_FEATURES][DEC_1_CONV_RELU_1_K][DEC_1_CONV_RELU_1_INPUT_FEATURES];

    arraytype dec_2_up_conv_relu_tmp[DEC_2_UP_CONV_RELU_K * DEC_2_UP_CONV_RELU_INPUT_FEATURES * DEC_2_UP_CONV_RELU_OUTPUT_FEATURES];
    int dec_2_up_conv_relu_shape[4];
    arraytype dec_2_up_conv_relu_w[DEC_2_UP_CONV_RELU_OUTPUT_FEATURES][DEC_2_UP_CONV_RELU_K][DEC_2_UP_CONV_RELU_INPUT_FEATURES];

    arraytype dec_2_conv_relu_0_tmp[DEC_2_CONV_RELU_0_K * DEC_2_CONV_RELU_0_INPUT_FEATURES * DEC_2_CONV_RELU_0_OUTPUT_FEATURES];
    int dec_2_conv_relu_0_shape[4];
    arraytype dec_2_conv_relu_0_w[DEC_2_CONV_RELU_0_OUTPUT_FEATURES][DEC_2_CONV_RELU_0_K][DEC_2_CONV_RELU_0_INPUT_FEATURES];

    arraytype dec_2_conv_relu_1_tmp[DEC_2_CONV_RELU_1_K * DEC_2_CONV_RELU_1_INPUT_FEATURES * DEC_2_CONV_RELU_1_OUTPUT_FEATURES];
    int dec_2_conv_relu_1_shape[4];
    arraytype dec_2_conv_relu_1_w[DEC_2_CONV_RELU_1_OUTPUT_FEATURES][DEC_2_CONV_RELU_1_K][DEC_2_CONV_RELU_1_INPUT_FEATURES];

    arraytype dec_3_up_conv_relu_tmp[DEC_3_UP_CONV_RELU_K * DEC_3_UP_CONV_RELU_INPUT_FEATURES * DEC_3_UP_CONV_RELU_OUTPUT_FEATURES];
    int dec_3_up_conv_relu_shape[4];
    arraytype dec_3_up_conv_relu_w[DEC_3_UP_CONV_RELU_OUTPUT_FEATURES][DEC_3_UP_CONV_RELU_K][DEC_3_UP_CONV_RELU_INPUT_FEATURES];

    arraytype dec_3_conv_relu_0_tmp[DEC_3_CONV_RELU_0_K * DEC_3_CONV_RELU_0_INPUT_FEATURES * DEC_3_CONV_RELU_0_OUTPUT_FEATURES];
    int dec_3_conv_relu_0_shape[4];
    arraytype dec_3_conv_relu_0_w[DEC_3_CONV_RELU_0_OUTPUT_FEATURES][DEC_3_CONV_RELU_0_K][DEC_3_CONV_RELU_0_INPUT_FEATURES];

    arraytype dec_3_conv_relu_1_tmp[DEC_3_CONV_RELU_1_K * DEC_3_CONV_RELU_1_INPUT_FEATURES * DEC_3_CONV_RELU_1_OUTPUT_FEATURES];
    int dec_3_conv_relu_1_shape[4];
    arraytype dec_3_conv_relu_1_w[DEC_3_CONV_RELU_1_OUTPUT_FEATURES][DEC_3_CONV_RELU_1_K][DEC_3_CONV_RELU_1_INPUT_FEATURES];

    arraytype final_conv_tmp[FINAL_CONV_K * FINAL_CONV_INPUT_FEATURES * FINAL_CONV_OUTPUT_FEATURES];
    int final_conv_shape[4];
    arraytype final_conv_w[FINAL_CONV_OUTPUT_FEATURES][FINAL_CONV_K][FINAL_CONV_INPUT_FEATURES];

    //------------------READING THE MODEL PARAMETERS----------------------------

    sprintf(subdirectory, "enc_0_conv_relu_0.npy");
    GetFlatArrFromNpy(model_path + subdirectory, enc_0_conv_relu_0_tmp, enc_0_conv_relu_0_shape);

    // Open  C header file to be filled by CNN weights
    ofstream myfile;
    myfile.open("weights.h");
    myfile << "#include \"segmenter.h\"\n\ndatatype enc_0_conv_relu_0_w[ENC_0_CONV_RELU_0_K*ENC_0_CONV_RELU_0_INPUT_FEATURES*ENC_0_CONV_RELU_0_OUTPUT_FEATURES]  = {";

    // Reshape array and fill the C header file
    for (int i = 0; i < ENC_0_CONV_RELU_0_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < ENC_0_CONV_RELU_0_K; k++)
        {
            for (int j = 0; j < ENC_0_CONV_RELU_0_INPUT_FEATURES; j++)
            {
                enc_0_conv_relu_0_w[i][k][j] = enc_0_conv_relu_0_tmp[i+ENC_0_CONV_RELU_0_OUTPUT_FEATURES*j+ENC_0_CONV_RELU_0_OUTPUT_FEATURES*ENC_0_CONV_RELU_0_INPUT_FEATURES*k];

                printf("%f, ", enc_0_conv_relu_0_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == ENC_0_CONV_RELU_0_OUTPUT_FEATURES - 1 && j == ENC_0_CONV_RELU_0_INPUT_FEATURES - 1 && k == ENC_0_CONV_RELU_0_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(enc_0_conv_relu_0_w[i][k][j],FXP_VALUE) << "};\n\n";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << enc_0_conv_relu_0_w[i][k][j] << "};\n\n";
                    #endif

                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(enc_0_conv_relu_0_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << enc_0_conv_relu_0_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------enc_0_conv_relu_0----------------\n");

    sprintf(subdirectory, "enc_0_conv_relu_1.npy");
    GetFlatArrFromNpy(model_path + subdirectory, enc_0_conv_relu_1_tmp, enc_0_conv_relu_1_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype enc_0_conv_relu_1_w[ENC_0_CONV_RELU_1_K*ENC_0_CONV_RELU_1_INPUT_FEATURES*ENC_0_CONV_RELU_1_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < ENC_0_CONV_RELU_1_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < ENC_0_CONV_RELU_1_K; k++)
        {
            for (int j = 0; j < ENC_0_CONV_RELU_1_INPUT_FEATURES; j++)
            {
                enc_0_conv_relu_1_w[i][k][j] = enc_0_conv_relu_1_tmp[i+ENC_0_CONV_RELU_1_OUTPUT_FEATURES*j+ENC_0_CONV_RELU_1_OUTPUT_FEATURES*ENC_0_CONV_RELU_1_INPUT_FEATURES*k];

                printf("%f, ", enc_0_conv_relu_1_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == ENC_0_CONV_RELU_1_OUTPUT_FEATURES - 1 && j == ENC_0_CONV_RELU_1_INPUT_FEATURES - 1 && k == ENC_0_CONV_RELU_1_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(enc_0_conv_relu_1_w[i][k][j],FXP_VALUE) << "};\n\n"; 
                    #else 
                    myfile << std::fixed << std::setprecision(PRECISION) << enc_0_conv_relu_1_w[i][k][j] << "};\n\n";
                    #endif
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(enc_0_conv_relu_1_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << enc_0_conv_relu_1_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------enc_0_conv_relu_1----------------\n");

    sprintf(subdirectory, "enc_1_conv_relu_0.npy");
    GetFlatArrFromNpy(model_path + subdirectory, enc_1_conv_relu_0_tmp, enc_1_conv_relu_0_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype enc_1_conv_relu_0_w[ENC_1_CONV_RELU_0_K*ENC_1_CONV_RELU_0_INPUT_FEATURES*ENC_1_CONV_RELU_0_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < ENC_1_CONV_RELU_0_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < ENC_1_CONV_RELU_0_K; k++)
        {
            for (int j = 0; j < ENC_1_CONV_RELU_0_INPUT_FEATURES; j++)
            {
                enc_1_conv_relu_0_w[i][k][j] = enc_1_conv_relu_0_tmp[i+ENC_1_CONV_RELU_0_OUTPUT_FEATURES*j+ENC_1_CONV_RELU_0_OUTPUT_FEATURES*ENC_1_CONV_RELU_0_INPUT_FEATURES*k];

                printf("%f, ", enc_1_conv_relu_0_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == ENC_1_CONV_RELU_0_OUTPUT_FEATURES - 1 && j == ENC_1_CONV_RELU_0_INPUT_FEATURES - 1 && k == ENC_1_CONV_RELU_0_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(enc_1_conv_relu_0_w[i][k][j],FXP_VALUE) << "};\n\n"; 
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << enc_1_conv_relu_0_w[i][k][j] << "};\n\n";
                    #endif
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(enc_1_conv_relu_0_w[i][k][j],FXP_VALUE) << ", ";   
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << enc_1_conv_relu_0_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------enc_1_conv_relu_0----------------\n");

    sprintf(subdirectory, "enc_1_conv_relu_1.npy");
    GetFlatArrFromNpy(model_path + subdirectory, enc_1_conv_relu_1_tmp, enc_1_conv_relu_1_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype enc_1_conv_relu_1_w[ENC_1_CONV_RELU_1_K*ENC_1_CONV_RELU_1_INPUT_FEATURES*ENC_1_CONV_RELU_1_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < ENC_1_CONV_RELU_1_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < ENC_1_CONV_RELU_1_K; k++)
        {
            for (int j = 0; j < ENC_1_CONV_RELU_1_INPUT_FEATURES; j++)
            {
                enc_1_conv_relu_1_w[i][k][j] = enc_1_conv_relu_1_tmp[i+ENC_1_CONV_RELU_1_OUTPUT_FEATURES*j+ENC_1_CONV_RELU_1_OUTPUT_FEATURES*ENC_1_CONV_RELU_1_INPUT_FEATURES*k];

                printf("%f, ", enc_1_conv_relu_1_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == ENC_1_CONV_RELU_1_OUTPUT_FEATURES - 1 && j == ENC_1_CONV_RELU_1_INPUT_FEATURES - 1 && k == ENC_1_CONV_RELU_1_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(enc_1_conv_relu_1_w[i][k][j],FXP_VALUE) << "};\n\n"; 
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << enc_1_conv_relu_1_w[i][k][j] << "};\n\n";
                    #endif
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(enc_1_conv_relu_1_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << enc_1_conv_relu_1_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------enc_1_conv_relu_1----------------\n");

    sprintf(subdirectory, "enc_2_conv_relu_0.npy");
    GetFlatArrFromNpy(model_path + subdirectory, enc_2_conv_relu_0_tmp, enc_2_conv_relu_0_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype enc_2_conv_relu_0_w[ENC_2_CONV_RELU_0_K*ENC_2_CONV_RELU_0_INPUT_FEATURES*ENC_2_CONV_RELU_0_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < ENC_2_CONV_RELU_0_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < ENC_2_CONV_RELU_0_K; k++)
        {
            for (int j = 0; j < ENC_2_CONV_RELU_0_INPUT_FEATURES; j++)
            {
                enc_2_conv_relu_0_w[i][k][j] = enc_2_conv_relu_0_tmp[i+ENC_2_CONV_RELU_0_OUTPUT_FEATURES*j+ENC_2_CONV_RELU_0_OUTPUT_FEATURES*ENC_2_CONV_RELU_0_INPUT_FEATURES*k];

                printf("%f, ", enc_2_conv_relu_0_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == ENC_2_CONV_RELU_0_OUTPUT_FEATURES - 1 && j == ENC_2_CONV_RELU_0_INPUT_FEATURES - 1 && k == ENC_2_CONV_RELU_0_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(enc_2_conv_relu_0_w[i][k][j],FXP_VALUE) << "};\n\n";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << enc_2_conv_relu_0_w[i][k][j] << "};\n\n";
                    #endif
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(enc_2_conv_relu_0_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << enc_2_conv_relu_0_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------enc_2_conv_relu_0----------------\n");

    sprintf(subdirectory, "enc_2_conv_relu_1.npy");
    GetFlatArrFromNpy(model_path + subdirectory, enc_2_conv_relu_1_tmp, enc_2_conv_relu_1_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype enc_2_conv_relu_1_w[ENC_2_CONV_RELU_1_K*ENC_2_CONV_RELU_1_INPUT_FEATURES*ENC_2_CONV_RELU_1_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < ENC_2_CONV_RELU_1_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < ENC_2_CONV_RELU_1_K; k++)
        {
            for (int j = 0; j < ENC_2_CONV_RELU_1_INPUT_FEATURES; j++)
            {
                enc_2_conv_relu_1_w[i][k][j] = enc_2_conv_relu_1_tmp[i+ENC_2_CONV_RELU_1_OUTPUT_FEATURES*j+ENC_2_CONV_RELU_1_OUTPUT_FEATURES*ENC_2_CONV_RELU_1_INPUT_FEATURES*k];

                printf("%f, ", enc_2_conv_relu_1_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == ENC_2_CONV_RELU_1_OUTPUT_FEATURES - 1 && j == ENC_2_CONV_RELU_1_INPUT_FEATURES - 1 && k == ENC_2_CONV_RELU_1_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(enc_2_conv_relu_1_w[i][k][j],FXP_VALUE) << "};\n\n";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << enc_2_conv_relu_1_w[i][k][j] << "};\n\n";
                    #endif
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(enc_2_conv_relu_1_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << enc_2_conv_relu_1_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------enc_2_conv_relu_1----------------\n");

    sprintf(subdirectory, "enc_3_conv_relu_0.npy");
    GetFlatArrFromNpy(model_path + subdirectory, enc_3_conv_relu_0_tmp, enc_3_conv_relu_0_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype enc_3_conv_relu_0_w[ENC_3_CONV_RELU_0_K*ENC_3_CONV_RELU_0_INPUT_FEATURES*ENC_3_CONV_RELU_0_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < ENC_3_CONV_RELU_0_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < ENC_3_CONV_RELU_0_K; k++)
        {
            for (int j = 0; j < ENC_3_CONV_RELU_0_INPUT_FEATURES; j++)
            {
                enc_3_conv_relu_0_w[i][k][j] = enc_3_conv_relu_0_tmp[i+ENC_3_CONV_RELU_0_OUTPUT_FEATURES*j+ENC_3_CONV_RELU_0_OUTPUT_FEATURES*ENC_3_CONV_RELU_0_INPUT_FEATURES*k];

                printf("%f, ", enc_3_conv_relu_0_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == ENC_3_CONV_RELU_0_OUTPUT_FEATURES - 1 && j == ENC_3_CONV_RELU_0_INPUT_FEATURES - 1 && k == ENC_3_CONV_RELU_0_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(enc_3_conv_relu_0_w[i][k][j],FXP_VALUE) << "};\n\n";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << enc_3_conv_relu_0_w[i][k][j] << "};\n\n";
                    #endif 
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(enc_3_conv_relu_0_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << enc_3_conv_relu_0_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------enc_3_conv_relu_0----------------\n");

    sprintf(subdirectory, "enc_3_conv_relu_1.npy");
    GetFlatArrFromNpy(model_path + subdirectory, enc_3_conv_relu_1_tmp, enc_3_conv_relu_1_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype enc_3_conv_relu_1_w[ENC_3_CONV_RELU_1_K*ENC_3_CONV_RELU_1_INPUT_FEATURES*ENC_3_CONV_RELU_1_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < ENC_3_CONV_RELU_1_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < ENC_3_CONV_RELU_1_K; k++)
        {
            for (int j = 0; j < ENC_3_CONV_RELU_1_INPUT_FEATURES; j++)
            {
                enc_3_conv_relu_1_w[i][k][j] = enc_3_conv_relu_1_tmp[i+ENC_3_CONV_RELU_1_OUTPUT_FEATURES*j+ENC_3_CONV_RELU_1_OUTPUT_FEATURES*ENC_3_CONV_RELU_1_INPUT_FEATURES*k];

                printf("%f, ", enc_3_conv_relu_1_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == ENC_3_CONV_RELU_1_OUTPUT_FEATURES - 1 && j == ENC_3_CONV_RELU_1_INPUT_FEATURES - 1 && k == ENC_3_CONV_RELU_1_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(enc_3_conv_relu_1_w[i][k][j],FXP_VALUE) << "};\n\n"; 
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << enc_3_conv_relu_1_w[i][k][j] << "};\n\n";
                    #endif
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(enc_3_conv_relu_1_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << enc_3_conv_relu_1_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------enc_3_conv_relu_1----------------\n");

    sprintf(subdirectory, "central_conv_relu_0.npy");
    GetFlatArrFromNpy(model_path + subdirectory, central_conv_relu_0_tmp, central_conv_relu_0_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype central_conv_relu_0_w[CENTRAL_CONV_RELU_0_K*CENTRAL_CONV_RELU_0_INPUT_FEATURES*CENTRAL_CONV_RELU_0_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < CENTRAL_CONV_RELU_0_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < CENTRAL_CONV_RELU_0_K; k++)
        {
            for (int j = 0; j < CENTRAL_CONV_RELU_0_INPUT_FEATURES; j++)
            {
                central_conv_relu_0_w[i][k][j] = central_conv_relu_0_tmp[i+CENTRAL_CONV_RELU_0_OUTPUT_FEATURES*j+CENTRAL_CONV_RELU_0_OUTPUT_FEATURES*CENTRAL_CONV_RELU_0_INPUT_FEATURES*k];

                printf("%f, ", central_conv_relu_0_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == CENTRAL_CONV_RELU_0_OUTPUT_FEATURES - 1 && j == CENTRAL_CONV_RELU_0_INPUT_FEATURES - 1 && k == CENTRAL_CONV_RELU_0_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(central_conv_relu_0_w[i][k][j],FXP_VALUE) << "};\n\n";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << central_conv_relu_0_w[i][k][j] << "};\n\n";
                    #endif
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(central_conv_relu_0_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << central_conv_relu_0_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------central_conv_relu_0----------------\n");

    sprintf(subdirectory, "central_conv_relu_1.npy");
    GetFlatArrFromNpy(model_path + subdirectory, central_conv_relu_1_tmp, central_conv_relu_1_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype central_conv_relu_1_w[CENTRAL_CONV_RELU_1_K*CENTRAL_CONV_RELU_1_INPUT_FEATURES*CENTRAL_CONV_RELU_1_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < CENTRAL_CONV_RELU_1_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < CENTRAL_CONV_RELU_1_K; k++)
        {
            for (int j = 0; j < CENTRAL_CONV_RELU_1_INPUT_FEATURES; j++)
            {
                central_conv_relu_1_w[i][k][j] = central_conv_relu_1_tmp[i+CENTRAL_CONV_RELU_1_OUTPUT_FEATURES*j+CENTRAL_CONV_RELU_1_OUTPUT_FEATURES*CENTRAL_CONV_RELU_1_INPUT_FEATURES*k];

                printf("%f, ", central_conv_relu_1_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == CENTRAL_CONV_RELU_1_OUTPUT_FEATURES - 1 && j == CENTRAL_CONV_RELU_1_INPUT_FEATURES - 1 && k == CENTRAL_CONV_RELU_1_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(central_conv_relu_1_w[i][k][j],FXP_VALUE) << "};\n\n";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << central_conv_relu_1_w[i][k][j] << "};\n\n";
                    #endif 
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(central_conv_relu_1_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << central_conv_relu_1_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------central_conv_relu_1----------------\n");

    sprintf(subdirectory, "dec_0_up_conv_relu.npy");
    GetFlatArrFromNpy(model_path + subdirectory, dec_0_up_conv_relu_tmp, dec_0_up_conv_relu_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype dec_0_up_conv_relu_w[DEC_0_UP_CONV_RELU_K*DEC_0_UP_CONV_RELU_INPUT_FEATURES*DEC_0_UP_CONV_RELU_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < DEC_0_UP_CONV_RELU_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < DEC_0_UP_CONV_RELU_K; k++)
        {
            for (int j = 0; j < DEC_0_UP_CONV_RELU_INPUT_FEATURES; j++)
            {
                dec_0_up_conv_relu_w[i][k][j] = dec_0_up_conv_relu_tmp[i+DEC_0_UP_CONV_RELU_OUTPUT_FEATURES*j+DEC_0_UP_CONV_RELU_OUTPUT_FEATURES*DEC_0_UP_CONV_RELU_INPUT_FEATURES*k];

                printf("%f, ", dec_0_up_conv_relu_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == DEC_0_UP_CONV_RELU_OUTPUT_FEATURES - 1 && j == DEC_0_UP_CONV_RELU_INPUT_FEATURES - 1 && k == DEC_0_UP_CONV_RELU_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_0_up_conv_relu_w[i][k][j],FXP_VALUE) << "};\n\n";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_0_up_conv_relu_w[i][k][j] << "};\n\n";
                    #endif
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_0_up_conv_relu_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_0_up_conv_relu_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------dec_0_up_conv_relu----------------\n");

    sprintf(subdirectory, "dec_0_conv_relu_0.npy");
    GetFlatArrFromNpy(model_path + subdirectory, dec_0_conv_relu_0_tmp, dec_0_conv_relu_0_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype dec_0_conv_relu_0_w[DEC_0_CONV_RELU_0_K*DEC_0_CONV_RELU_0_INPUT_FEATURES*DEC_0_CONV_RELU_0_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < DEC_0_CONV_RELU_0_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < DEC_0_CONV_RELU_0_K; k++)
        {
            for (int j = 0; j < DEC_0_CONV_RELU_0_INPUT_FEATURES; j++)
            {
                dec_0_conv_relu_0_w[i][k][j] = dec_0_conv_relu_0_tmp[i+DEC_0_CONV_RELU_0_OUTPUT_FEATURES*j+DEC_0_CONV_RELU_0_OUTPUT_FEATURES*DEC_0_CONV_RELU_0_INPUT_FEATURES*k];

                printf("%f, ", dec_0_conv_relu_0_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == DEC_0_CONV_RELU_0_OUTPUT_FEATURES - 1 && j == DEC_0_CONV_RELU_0_INPUT_FEATURES - 1 && k == DEC_0_CONV_RELU_0_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_0_conv_relu_0_w[i][k][j],FXP_VALUE) << "};\n\n";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_0_conv_relu_0_w[i][k][j] << "};\n\n";
                    #endif
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_0_conv_relu_0_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_0_conv_relu_0_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------dec_0_conv_relu_0----------------\n");

    sprintf(subdirectory, "dec_0_conv_relu_1.npy");
    GetFlatArrFromNpy(model_path + subdirectory, dec_0_conv_relu_1_tmp, dec_0_conv_relu_1_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype dec_0_conv_relu_1_w[DEC_0_CONV_RELU_1_K*DEC_0_CONV_RELU_1_INPUT_FEATURES*DEC_0_CONV_RELU_1_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < DEC_0_CONV_RELU_1_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < DEC_0_CONV_RELU_1_K; k++)
        {
            for (int j = 0; j < DEC_0_CONV_RELU_1_INPUT_FEATURES; j++)
            {
                dec_0_conv_relu_1_w[i][k][j] = dec_0_conv_relu_1_tmp[i+DEC_0_CONV_RELU_1_OUTPUT_FEATURES*j+DEC_0_CONV_RELU_1_OUTPUT_FEATURES*DEC_0_CONV_RELU_1_INPUT_FEATURES*k];

                printf("%f, ", dec_0_conv_relu_1_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == DEC_0_CONV_RELU_1_OUTPUT_FEATURES - 1 && j == DEC_0_CONV_RELU_1_INPUT_FEATURES - 1 && k == DEC_0_CONV_RELU_1_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_0_conv_relu_1_w[i][k][j],FXP_VALUE) << "};\n\n";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_0_conv_relu_1_w[i][k][j] << "};\n\n";
                    #endif
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_0_conv_relu_1_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_0_conv_relu_1_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------dec_0_conv_relu_1----------------\n");

    sprintf(subdirectory, "dec_1_up_conv_relu.npy");
    GetFlatArrFromNpy(model_path + subdirectory, dec_1_up_conv_relu_tmp, dec_1_up_conv_relu_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype dec_1_up_conv_relu_w[DEC_1_UP_CONV_RELU_K*DEC_1_UP_CONV_RELU_INPUT_FEATURES*DEC_1_UP_CONV_RELU_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < DEC_1_UP_CONV_RELU_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < DEC_1_UP_CONV_RELU_K; k++)
        {
            for (int j = 0; j < DEC_1_UP_CONV_RELU_INPUT_FEATURES; j++)
            {
                dec_1_up_conv_relu_w[i][k][j] = dec_1_up_conv_relu_tmp[i+DEC_1_UP_CONV_RELU_OUTPUT_FEATURES*j+DEC_1_UP_CONV_RELU_OUTPUT_FEATURES*DEC_1_UP_CONV_RELU_INPUT_FEATURES*k];

                printf("%f, ", dec_1_up_conv_relu_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == DEC_1_UP_CONV_RELU_OUTPUT_FEATURES - 1 && j == DEC_1_UP_CONV_RELU_INPUT_FEATURES - 1 && k == DEC_1_UP_CONV_RELU_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_1_up_conv_relu_w[i][k][j],FXP_VALUE) << "};\n\n";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_1_up_conv_relu_w[i][k][j] << "};\n\n";
                    #endif
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_1_up_conv_relu_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_1_up_conv_relu_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------dec_1_up_conv_relu----------------\n");

    sprintf(subdirectory, "dec_1_conv_relu_0.npy");
    GetFlatArrFromNpy(model_path + subdirectory, dec_1_conv_relu_0_tmp, dec_1_conv_relu_0_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype dec_1_conv_relu_0_w[DEC_1_CONV_RELU_0_K*DEC_1_CONV_RELU_0_INPUT_FEATURES*DEC_1_CONV_RELU_0_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < DEC_1_CONV_RELU_0_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < DEC_1_CONV_RELU_0_K; k++)
        {
            for (int j = 0; j < DEC_1_CONV_RELU_0_INPUT_FEATURES; j++)
            {
                dec_1_conv_relu_0_w[i][k][j] = dec_1_conv_relu_0_tmp[i+DEC_1_CONV_RELU_0_OUTPUT_FEATURES*j+DEC_1_CONV_RELU_0_OUTPUT_FEATURES*DEC_1_CONV_RELU_0_INPUT_FEATURES*k];

                printf("%f, ", dec_1_conv_relu_0_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == DEC_1_CONV_RELU_0_OUTPUT_FEATURES - 1 && j == DEC_1_CONV_RELU_0_INPUT_FEATURES - 1 && k == DEC_1_CONV_RELU_0_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_1_conv_relu_0_w[i][k][j],FXP_VALUE) << "};\n\n";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_1_conv_relu_0_w[i][k][j] << "};\n\n";
                    #endif
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_1_conv_relu_0_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_1_conv_relu_0_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------dec_1_conv_relu_0----------------\n");

    sprintf(subdirectory, "dec_1_conv_relu_1.npy");
    GetFlatArrFromNpy(model_path + subdirectory, dec_1_conv_relu_1_tmp, dec_1_conv_relu_1_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype dec_1_conv_relu_1_w[DEC_1_CONV_RELU_1_K*DEC_1_CONV_RELU_1_INPUT_FEATURES*DEC_1_CONV_RELU_1_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < DEC_1_CONV_RELU_1_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < DEC_1_CONV_RELU_1_K; k++)
        {
            for (int j = 0; j < DEC_1_CONV_RELU_1_INPUT_FEATURES; j++)
            {
                dec_1_conv_relu_1_w[i][k][j] = dec_1_conv_relu_1_tmp[i+DEC_1_CONV_RELU_1_OUTPUT_FEATURES*j+DEC_1_CONV_RELU_1_OUTPUT_FEATURES*DEC_1_CONV_RELU_1_INPUT_FEATURES*k];

                printf("%f, ", dec_1_conv_relu_1_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == DEC_1_CONV_RELU_1_OUTPUT_FEATURES - 1 && j == DEC_1_CONV_RELU_1_INPUT_FEATURES - 1 && k == DEC_1_CONV_RELU_1_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_1_conv_relu_1_w[i][k][j],FXP_VALUE) << "};\n\n";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_1_conv_relu_1_w[i][k][j] << "};\n\n";
                    #endif
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_1_conv_relu_1_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_1_conv_relu_1_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------dec_1_conv_relu_1----------------\n");

    sprintf(subdirectory, "dec_2_up_conv_relu.npy");
    GetFlatArrFromNpy(model_path + subdirectory, dec_2_up_conv_relu_tmp, dec_2_up_conv_relu_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype dec_2_up_conv_relu_w[DEC_2_UP_CONV_RELU_K*DEC_2_UP_CONV_RELU_INPUT_FEATURES*DEC_2_UP_CONV_RELU_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < DEC_2_UP_CONV_RELU_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < DEC_2_UP_CONV_RELU_K; k++)
        {
            for (int j = 0; j < DEC_2_UP_CONV_RELU_INPUT_FEATURES; j++)
            {
                dec_2_up_conv_relu_w[i][k][j] = dec_2_up_conv_relu_tmp[i+DEC_2_UP_CONV_RELU_OUTPUT_FEATURES*j+DEC_2_UP_CONV_RELU_OUTPUT_FEATURES*DEC_2_UP_CONV_RELU_INPUT_FEATURES*k];

                printf("%f, ", dec_2_up_conv_relu_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == DEC_2_UP_CONV_RELU_OUTPUT_FEATURES - 1 && j == DEC_2_UP_CONV_RELU_INPUT_FEATURES - 1 && k == DEC_2_UP_CONV_RELU_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_2_up_conv_relu_w[i][k][j],FXP_VALUE) << "};\n\n";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_2_up_conv_relu_w[i][k][j] << "};\n\n";
                    #endif
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_2_up_conv_relu_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_2_up_conv_relu_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------dec_2_conv_relu_0----------------\n");

    sprintf(subdirectory, "dec_2_conv_relu_0.npy");
    GetFlatArrFromNpy(model_path + subdirectory, dec_2_conv_relu_0_tmp, dec_2_conv_relu_0_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype dec_2_conv_relu_0_w[DEC_2_CONV_RELU_0_K*DEC_2_CONV_RELU_0_INPUT_FEATURES*DEC_2_CONV_RELU_0_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < DEC_2_CONV_RELU_0_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < DEC_2_CONV_RELU_0_K; k++)
        {
            for (int j = 0; j < DEC_2_CONV_RELU_0_INPUT_FEATURES; j++)
            {
                dec_2_conv_relu_0_w[i][k][j] = dec_2_conv_relu_0_tmp[i+DEC_2_CONV_RELU_0_OUTPUT_FEATURES*j+DEC_2_CONV_RELU_0_OUTPUT_FEATURES*DEC_2_CONV_RELU_0_INPUT_FEATURES*k];

                printf("%f, ", dec_2_conv_relu_0_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == DEC_2_CONV_RELU_0_OUTPUT_FEATURES - 1 && j == DEC_2_CONV_RELU_0_INPUT_FEATURES - 1 && k == DEC_2_CONV_RELU_0_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_2_conv_relu_0_w[i][k][j],FXP_VALUE) << "};\n\n";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_2_conv_relu_0_w[i][k][j] << "};\n\n";
                    #endif
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_2_conv_relu_0_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_2_conv_relu_0_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------dec_2_conv_relu_0----------------\n");

    sprintf(subdirectory, "dec_2_conv_relu_1.npy");
    GetFlatArrFromNpy(model_path + subdirectory, dec_2_conv_relu_1_tmp, dec_2_conv_relu_1_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype dec_2_conv_relu_1_w[DEC_2_CONV_RELU_1_K*DEC_2_CONV_RELU_1_INPUT_FEATURES*DEC_2_CONV_RELU_1_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < DEC_2_CONV_RELU_1_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < DEC_2_CONV_RELU_1_K; k++)
        {
            for (int j = 0; j < DEC_2_CONV_RELU_1_INPUT_FEATURES; j++)
            {
                dec_2_conv_relu_1_w[i][k][j] = dec_2_conv_relu_1_tmp[i+DEC_2_CONV_RELU_1_OUTPUT_FEATURES*j+DEC_2_CONV_RELU_1_OUTPUT_FEATURES*DEC_2_CONV_RELU_1_INPUT_FEATURES*k];

                printf("%f, ", dec_2_conv_relu_1_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == DEC_2_CONV_RELU_1_OUTPUT_FEATURES - 1 && j == DEC_2_CONV_RELU_1_INPUT_FEATURES - 1 && k == DEC_2_CONV_RELU_1_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_2_conv_relu_1_w[i][k][j],FXP_VALUE) << "};\n\n";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_2_conv_relu_1_w[i][k][j] << "};\n\n";
                    #endif
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_2_conv_relu_1_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_2_conv_relu_1_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------dec_2_conv_relu_1----------------\n");

    sprintf(subdirectory, "dec_3_up_conv_relu.npy");
    GetFlatArrFromNpy(model_path + subdirectory, dec_3_up_conv_relu_tmp, dec_3_up_conv_relu_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype dec_3_up_conv_relu_w[DEC_3_UP_CONV_RELU_K*DEC_3_UP_CONV_RELU_INPUT_FEATURES*DEC_3_UP_CONV_RELU_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < DEC_3_UP_CONV_RELU_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < DEC_3_UP_CONV_RELU_K; k++)
        {
            for (int j = 0; j < DEC_3_UP_CONV_RELU_INPUT_FEATURES; j++)
            {
                dec_3_up_conv_relu_w[i][k][j] = dec_3_up_conv_relu_tmp[i+DEC_3_UP_CONV_RELU_OUTPUT_FEATURES*j+DEC_3_UP_CONV_RELU_OUTPUT_FEATURES*DEC_3_UP_CONV_RELU_INPUT_FEATURES*k];

                printf("%f, ", dec_3_up_conv_relu_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == DEC_3_UP_CONV_RELU_OUTPUT_FEATURES - 1 && j == DEC_3_UP_CONV_RELU_INPUT_FEATURES - 1 && k == DEC_3_UP_CONV_RELU_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_3_up_conv_relu_w[i][k][j],FXP_VALUE) << "};\n\n";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_3_up_conv_relu_w[i][k][j] << "};\n\n";
                    #endif
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_3_up_conv_relu_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_3_up_conv_relu_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------dec_3_up_conv_relu----------------\n");

    sprintf(subdirectory, "dec_3_conv_relu_0.npy");
    GetFlatArrFromNpy(model_path + subdirectory, dec_3_conv_relu_0_tmp, dec_3_conv_relu_0_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype dec_3_conv_relu_0_w[DEC_3_CONV_RELU_0_K*DEC_3_CONV_RELU_0_INPUT_FEATURES*DEC_3_CONV_RELU_0_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < DEC_3_CONV_RELU_0_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < DEC_3_CONV_RELU_0_K; k++)
        {
            for (int j = 0; j < DEC_3_CONV_RELU_0_INPUT_FEATURES; j++)
            {
                dec_3_conv_relu_0_w[i][k][j] = dec_3_conv_relu_0_tmp[i+DEC_3_CONV_RELU_0_OUTPUT_FEATURES*j+DEC_3_CONV_RELU_0_OUTPUT_FEATURES*DEC_3_CONV_RELU_0_INPUT_FEATURES*k];

                printf("%f, ", dec_3_conv_relu_0_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == DEC_3_CONV_RELU_0_OUTPUT_FEATURES - 1 && j == DEC_3_CONV_RELU_0_INPUT_FEATURES - 1 && k == DEC_3_CONV_RELU_0_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_3_conv_relu_0_w[i][k][j],FXP_VALUE) << "};\n\n";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_3_conv_relu_0_w[i][k][j] << "};\n\n";
                    #endif
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_3_conv_relu_0_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_3_conv_relu_0_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------dec_3_conv_relu_0----------------\n");

    sprintf(subdirectory, "dec_3_conv_relu_1.npy");
    GetFlatArrFromNpy(model_path + subdirectory, dec_3_conv_relu_1_tmp, dec_3_conv_relu_1_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype dec_3_conv_relu_1_w[DEC_3_CONV_RELU_1_K*DEC_3_CONV_RELU_1_INPUT_FEATURES*DEC_3_CONV_RELU_1_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < DEC_3_CONV_RELU_1_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < DEC_3_CONV_RELU_1_K; k++)
        {
            for (int j = 0; j < DEC_3_CONV_RELU_1_INPUT_FEATURES; j++)
            {
                dec_3_conv_relu_1_w[i][k][j] = dec_3_conv_relu_1_tmp[i+DEC_3_CONV_RELU_1_OUTPUT_FEATURES*j+DEC_3_CONV_RELU_1_OUTPUT_FEATURES*DEC_3_CONV_RELU_1_INPUT_FEATURES*k];

                printf("%f, ", dec_3_conv_relu_1_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == DEC_3_CONV_RELU_1_OUTPUT_FEATURES - 1 && j == DEC_3_CONV_RELU_1_INPUT_FEATURES - 1 && k == DEC_3_CONV_RELU_1_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_3_conv_relu_1_w[i][k][j],FXP_VALUE) << "};\n\n";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_3_conv_relu_1_w[i][k][j] << "};\n\n";
                    #endif
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(dec_3_conv_relu_1_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << dec_3_conv_relu_1_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------dec_3_conv_relu_1----------------\n");

    sprintf(subdirectory, "final_conv.npy");
    GetFlatArrFromNpy(model_path + subdirectory, final_conv_tmp, final_conv_shape);

    // Write datatype array declaration to C header file
    myfile << "datatype final_conv_w[FINAL_CONV_K*FINAL_CONV_INPUT_FEATURES*FINAL_CONV_OUTPUT_FEATURES]  = {";

    // Reshape it
    for (int i = 0; i < FINAL_CONV_OUTPUT_FEATURES; i++)
    {
        for (int k = 0; k < FINAL_CONV_K; k++)
        {
            for (int j = 0; j < FINAL_CONV_INPUT_FEATURES; j++)
            {
                final_conv_w[i][k][j] = final_conv_tmp[i+FINAL_CONV_OUTPUT_FEATURES*j+FINAL_CONV_OUTPUT_FEATURES*FINAL_CONV_INPUT_FEATURES*k];

                printf("%f, ", final_conv_w[i][k][j]);

                // Skip the last comma when filling the C header file
                if (i == FINAL_CONV_OUTPUT_FEATURES - 1 && j == FINAL_CONV_INPUT_FEATURES - 1 && k == FINAL_CONV_K - 1)
                {
                    #ifdef FPXINT
                    myfile << +quantize(final_conv_w[i][k][j],FXP_VALUE) << "};\n\n";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << final_conv_w[i][k][j] << "};\n\n";
                    #endif
                }
                else
                {
                    #ifdef FPXINT
                    myfile << +quantize(final_conv_w[i][k][j],FXP_VALUE) << ", ";
                    #else
                    myfile << std::fixed << std::setprecision(PRECISION) << final_conv_w[i][k][j] << ", ";
                    #endif
                }
            }
        }
    }
    printf("\n-----------final_conv----------------\n");

    // Close C header file
    myfile.close();

    return 0;
}