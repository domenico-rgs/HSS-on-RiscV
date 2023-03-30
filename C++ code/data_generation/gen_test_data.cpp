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
// You should have received a copy of the GNU General Public LicenseFLOAT
// along with PCG Segmentation Model Implementation.  If not, see <http://www.gnu.org/licenses/>.

//#include <iostream>
#include <stdio.h>
#include "segmenter.h"
#include "npy_reading.h"
#include <iomanip>      // std::setprecision
// #ifdef FLOAT
//     #include "segmenter.cpp"
// #endif

     
//-----------------------READING THE INPUT----------------------------------

int main() {

    // Initialize the array to read the input
    datatype test_data_tmp[TEST_SAMPLES_BATCH*N*N_FEATURES];
    int test_data_shape[4];
    datatype test_data[TEST_SAMPLES_BATCH][N][N_FEATURES];

    //Root path of the model
    // string model_path = "C:/Users/aralmeida/OneDrive - Universidad de Las Palmas de Gran Canaria/Doctorado/codigo/PCG-Segmentation-Implementation/";
    string model_path = "/home/domenico/Desktop/Unipv/Magistrale/Thesis/PCG-CNN/parameters/";
    char subdirectory[256];

    FILE *myfile; 
    myfile = fopen("test_data.bin", "wb");

      
    // Iterate over the test files
    for(int l=0; l<TEST_FILES; l++){
    //for(int l=0; l<1; l++){

        //-----------------------READING THE INPUT----------------------------------

        // Reading an input element
        sprintf(subdirectory,"inputs/X_%d.npy", l);
        GetFlatArrFromNpy(model_path+subdirectory, test_data_tmp, test_data_shape);
    
        printf("Loading new input data (%d/%d)\n", l+1, TEST_FILES);

        // C header file declaration and filling 
        //ofstream myfile;
        //myfile.open("test_data.h");
        //myfile << "//#include <iostream>\n\n#include \"segmenter.h\"\n\ndatatype test_data[N_FEATURES*N*1]  = {";

        // Reshape it and fill C header file with the test data
        for(int k=0; k<TEST_SAMPLES_BATCH; k++){
            for(int j=0; j<N; j++){
                for(int i=0; i<N_FEATURES; i++){
                    test_data[k][j][i] = test_data_tmp[i+j*N_FEATURES+k*N*N_FEATURES];
                // Skip the last comma when filling the C header file
                /*if (i == N_FEATURES-1 && j == N-1 && k == TEST_SAMPLES_BATCH-1) {
                    myfile << std::fixed << std::setprecision(PRECISION) << test_data[k][j][i]<< "};\n\n";

                } else {
                    myfile << std::fixed << std::setprecision(PRECISION) << test_data[k][j][i] << ", ";
                    }
                }*/
            }
        }
        // Close C header file
        //myfile.close();
        }
    fwrite(test_data , sizeof(datatype), TEST_SAMPLES_BATCH*N*N_FEATURES, myfile);
    }
    fclose(myfile);
    return 0;
}




