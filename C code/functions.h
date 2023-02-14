#include "segmenter.h"

apfixed min(apfixed a, apfixed b);
apfixed max(apfixed a, apfixed b);

void Argmax(apfixed x[N_STATES], apfixed y[N_STATES]);
void Softmax(apfixed x[N_STATES], apfixed y[N_STATES]);
apfixed ReLU(apfixed x);