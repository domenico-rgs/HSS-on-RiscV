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

#define SATURATE_INT16(x) ((x > INT16_MAX) ? INT16_MAX : ((x < INT16_MIN) ? INT16_MIN : x))


void Argmax(int16_t x[N_STATES], int16_t y[N_STATES]);
//void Softmax(float x[N_STATES], float y[N_STATES]);
void check_over(int32_t val, int layer);