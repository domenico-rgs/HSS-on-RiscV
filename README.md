# PCG-CNN
CNN network (U-net type) to classify PCG envelograms. To be implemented on a RISC-V processor.

### Directories and files
* **C code/** - Contains the C code derived from the C++ one and the data + weights for its testing/validation
* **C++ code/** - Contains the C++ code that implements the CNN network (derived from the Python one)
* **test + Python code/** -   Contains the Python code from which the network was derived and a Jupyter notebook to extrapolate the data that should be used for validating and testing the network
* **dynamic_mem.zip** - Contains the code for the implementation of the network using dynamic memory allocation. To be investigated later ([StackOverflow - how bad is it to use dynamic datastuctures on an embedded system?](https://stackoverflow.com/questions/1725923/how-bad-is-it-to-use-dynamic-datastuctures-on-an-embedded-system))