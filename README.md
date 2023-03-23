# PCG-CNN
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

CNN network (U-net type) to classify PCG envelograms.
It is implemented in Python with Tensorflow, C/C++ and Cuda to compare its performance. There is also the code to run the network on a RISC-V processor (AIRISC Core Complex) with and without accelerators and extension to evaluate its application in an embedded device using such processor.


- [PCG-CNN](#pcg-cnn)
    - [Directories and files](#directories-and-files)
    - [Run and test](#run-and-test)

### Directories and files
* **C code/** - Contains the C code derived from the C++ one
* **C++ code/** - Contains the C++ code that implements the CNN network (derived from the Python one)
* **Cuda/** - Contains the code with Cuda extension to exploit the massive quantity of cores in a GPU.
* **parameters/** - Contains all the npy file with the weights and the npy files with input data
* **Python code/** - Contains the original Python code of the network, making use of Tensorflow, and a Jupyter notebook to test it and extrapolate the data to be used to validate the other codes.
* **Risc-V/** - Contains the code of the network (cnn directory) and the Board Support Package files from the AIRISC Core Complex
* **dynamic_mem.zip** - Contains the code for the implementation of the network using dynamic memory allocation. To be investigated later ([StackOverflow - how bad is it to use dynamic datastuctures on an embedded system?](https://stackoverflow.com/questions/1725923/how-bad-is-it-to-use-dynamic-datastuctures-on-an-embedded-system))

### Run and test
Each directory,apart the python one, contains a Makefile to compile the code using the command below, after that run the executable in output.
```console
$ make
```

To execute the python code, just run the cells in the notebooks.