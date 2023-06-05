# Heart Sound Segmentation on RISC-V
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![GitHub issues](https://img.shields.io/github/issues/domenico-rgs/HSS-on-RiscV)](https://github.com/domenico-rgs/HSS-on-RiscV/issues)
[![GitHub stars](https://img.shields.io/github/stars/domenico-rgs/HSS-on-RiscV)](https://github.com/domenico-rgs/HSS-on-RiscV/stargazers)

Convolutional Neural Network (U-net type) to classify PCG envelograms.
It is implemented in TensorFlow, C/C++ and Cuda. The code to run the network on a RISC-V processor ([AIRISC Core Complex](https://github.com/Fraunhofer-IMS/airisc_core_complex)) is also present with and without AI accelerators and extensions to evaluate its potential application in an embedded device.

:bulb: The goal of the CNN as well as its architecture are introduced in this article: [Deep Convolutional Neural Networks for Heart Sound Segmentation - IEEE Journal of Biomedical and Health Informatics](https://ieeexplore.ieee.org/abstract/document/8620278)

:bulb: The preface to this work and the initial Python code are instead introduced in this other article:


- [Heart Sound Segmentation on RISC-V](#heart-sound-segmentation-on-risc-v)
  - [Directories and files](#directories-and-files)
  - [Data generation](#data-generation)
  - [Run and test](#run-and-test)
  - [Results](#results)
  - [Notes](#notes)

## Directories and files
* **data/** - It is the directory that contains the weights for each network layer and also the data used for tests as .npy files
* **profiling/** - Contains the results from Valgrind/Cachegrind (C codes) and NVIDIA Nsight Systems (Cuda)
* **src/** - Contains the code of the CNN in various languages (C/C++, Python (TensorFlow), Cuda) and also the one for the AIRISC as well as the notebooks for data analysis

## Data generation
To run the network and make inference, layer weights and also data are needed.
The weights are already present within the code in the `weights.h` file for each implementation while the data must be generated.

It is possible to generate both via the code in the directories `src/utils/data_generation/`.

There is only the need to edit the #define directive in the `segmenter.h` file to choose the data type (*FP16INT* for the quantized network (int16_t), *FLOAT* or *DOUBLE*), choose the precision with which to write the data to the .h file (in the latter case, default: 18 decimal places) and how many subjects to include in the test data (default 169, all).

To generate the data for the quantized model, within the .cpp files there is the possibility to choose the format for quantization (default Q5.10 for data and Q1.14 for weights). If so, modify the network to account for this (see [Notes](#notes)).

## Run and test
Each directory in `src/`, apart the python one, contains a Makefile to compile the code. Use ```$ make``` for the default actions otherwise use ```$ make help``` to see all the possible targets.

To execute the python code, just run the cells in the notebooks (`src/utils/data_analysis/profile_net.ipynb`, `src/utils/data_analysis/test_net.ipynb`).

## Results
:dart: All the results obtained from the tests are explained in the following article:

## Notes
1. The network for the RISC-V processor makes use of quantization. It is possible to choose the format to use (uniform quantization) in each layer via `#define FXP` in the `segmenter.h` file. Adapting accordingly the data and weigths format when they are generated through the `src/utils/data_generation/` files.
2. The AIRISC core is implemented on a Nexys4 DDR using the files in the [AIRISC Core Complex](https://github.com/domenico-rgs/airisc_core_complex) forked repository
3. The AIRISC AI extension and accelerators used were provided under a less permissive license by the Fraunhofer IMS.

:warning: WARNING: code using the DOUBLE data type has not been used/tested.



