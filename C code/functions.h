#include "segmenter.h"

float min(float a, float b);
float max(float a, float b);

void Argmax(float x[N_STATES], float y[N_STATES]);
void Softmax(float x[N_STATES], float y[N_STATES]);
float ReLU(float x);