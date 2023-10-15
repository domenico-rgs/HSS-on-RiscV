#include "segmenter.h"

//Returns the largest of a and b. If both are equivalent, a is returned.
#define max(a,b)             \
({                           \
    __typeof__ (a) _a = (a); \
    __typeof__ (b) _b = (b); \
    _a > _b ? _a : _b;       \
})

//Returns the smallest of a and b. If both are equivalent, a is returned.
#define min(a,b)             \
({                           \
    __typeof__ (a) _a = (a); \
    __typeof__ (b) _b = (b); \
    _a < _b ? _a : _b;       \
})

/*
Rectified Linear Unit implementation.
  Args:
    x - Input value
  Returns:
    The ReLU output of x
*/
#define ReLU(x)             \
({                           \
    __typeof__ (x) _x = (x); \
    _x < 0 ? 0 : _x;       \
})

void Argmax(datatype x[N_STATES], datatype y[N_STATES]);
void Argmax_2(datatype x[N_STATES], int *y);
void Softmax(datatype x[N_STATES], datatype y[N_STATES]);
void sequentialMaxTM (int *s);