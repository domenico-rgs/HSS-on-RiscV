#include "segmenter.h"

int min(int a, int b);
int max(int a, int b);

void Argmax(float x[N_STATES], float y[N_STATES]);
void Softmax(float x[N_STATES], float y[N_STATES]);
float ReLU(float x);