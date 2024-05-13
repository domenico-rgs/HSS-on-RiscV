# Heart Sound Segmentation on RISC-V
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![GitHub issues](https://img.shields.io/github/issues/domenico-rgs/HSS-on-RiscV)](https://github.com/domenico-rgs/HSS-on-RiscV/issues)
[![GitHub stars](https://img.shields.io/github/stars/domenico-rgs/HSS-on-RiscV)](https://github.com/domenico-rgs/HSS-on-RiscV/stargazers)

Convolutional Neural Network (U-net type) to classify PCG envelograms.
It is implemented in TensorFlow, C/C++ and Cuda. To evaluate the potential application of a RISC-V processor ([AIRISC Core Complex](https://github.com/Fraunhofer-IMS/airisc_core_complex)) as an embedded device, the code with/without AI accelerators is also present.

:bulb: The goal of the CNN as well as its architecture are introduced in this article: [Deep Convolutional Neural Networks for Heart Sound Segmentation - IEEE Journal of Biomedical and Health Informatics](https://ieeexplore.ieee.org/abstract/document/8620278)

:bulb: The preface to this work and the initial Python code are instead introduced in this other article: [to-be-defined]


- [Heart Sound Segmentation on RISC-V](#heart-sound-segmentation-on-risc-v)
  - [Directories and files](#directories-and-files)
  - [Data generation](#data-generation)
  - [Run and test](#run-and-test)
  - [Results](#results)
  - [Notes](#notes)

## Requirements
* Vivado 2023.3
* Cuda 12.3
* Python 3.11
* RISC-V GNU Compiler Toolchain

## Directories and files
* **data/** - It is the directory that contains, as .npy files, the weights for each network layer and also the data used for tests.
* **profiling/** - Contains the results from Valgrind/Cachegrind (C codes) and NVIDIA Nsight Systems (Cuda)
* **src/** - Contains the CNN code in C/C++ and Python (TensorFlow). It is also adapted to run on GPU through CUDA extension and on the AIRISC through their proprietery extensions. Moreover, in the directory there are also the notebooks used for data analysis.
* **src/HDL** - In this directory there is the HDL models from Vitis Model Composer to implement in-hardware the phonocardiogram signal pre-processing.

## Data generation
To run the network and make inference, layer weights and also data are needed to be extracted from the .npy files.
The weights are already present within the code in the `weights.h` file, for each implementation, while the data must be generated.

It is possible to generate both via the codes in the directory `src/utils/data_generation/`.

Then, there is only the need to edit the #define directive in the `segmenter.h` file to choose the data type (*FP16INT* for the quantized network (int16_t), *FLOAT* or *DOUBLE* otherwise), choose the precision with which to write the data in the weights.h file, if quantization is not in use, (default: 18 decimal places) and how many subjects to include in the test data (default 169, all).

To generate the data for the quantized model, within the .cpp files there is the possibility to choose the format for quantization (default Q5.10 for data and Q1.14 for weights). If so, modify the network to account for this (see [Notes](#notes)).

## Run and test
Each directory in `src/`, apart the python one, contains a Makefile to compile the code. Use ```$ make``` for the default actions otherwise use ```$ make help``` to see all the possible targets.

To execute the python code, just run the cells in the notebooks.

## Results
:dart: All the results obtained from the tests are explained in the following article: [Acceleration of a CNN-based Heart Sound Segmenter: Implementation on Different Platforms Targeting a Wearable Device](https://doi.org/10.1109/DSD60849.2023.00049)

## Notes
1. The network for the RISC-V processor makes use of quantization. It is possible to choose the format to use (uniform quantization) in each layer via `#define FXP` in the `segmenter.h` file. Adapting accordingly the data and weigths format when they are generated through the `src/utils/data_generation/` files.
2. The AIRISC core was implemented on a Nexys4 DDR and on a Nexys Video using the files in the [AIRISC Core Complex](https://github.com/domenico-rgs/airisc_core_complex) forked repository
3. The AIRISC AI extension and accelerators used were provided under a less permissive license by the Fraunhofer IMS.

:warning: WARNING: code using the DOUBLE data type has not been tested.



