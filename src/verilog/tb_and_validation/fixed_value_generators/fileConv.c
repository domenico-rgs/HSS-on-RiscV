#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include <stdlib.h>

#define FXP 32 //fixed point precision 16 -> 32

int32_t quantize(float a, int fxp){
	int64_t maxVal = ((1 << (FXP-1)) - 1);
	int64_t value = roundf(a * (1 << fxp)); //mapping + rounding
	//int32_t value = a * (1 << fxp); //mapping without rounding

	//clipping
	if(value > maxVal){
		return (int32_t)maxVal;
	}else if(value < -maxVal-1){
		return (int32_t)(-maxVal-1);
	}else{
		return (int32_t)value;
	}
}

/*float dequantize(int32_t val, int fxp){
	return val/((float)(1<<fxp));
}*/

int main(int argc, char** argv){
	FILE *f_lettura, *f_scrittura;
	char buffer[100];

	f_lettura = fopen(argv[1], "r");
    if (f_lettura == NULL) {
        perror("Errore nell'apertura del file di lettura");
        return 1;
    }

    f_scrittura = fopen("output.txt", "w");
    if (f_scrittura == NULL) {
        perror("Errore nell'apertura del file di scrittura");
        fclose(f_scrittura);
        return 1;
    }

    while (fgets(buffer, sizeof(buffer), f_lettura) != NULL) {
        float valore = atof(buffer);
        int32_t nuovoValore = quantize(valore, 26);

        fprintf(f_scrittura, "%x\n", nuovoValore);
    }

    fclose(f_lettura);
    fclose(f_scrittura);

    return 0;
}