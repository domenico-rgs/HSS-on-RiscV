default: no-opt-prof opt-prof

no-opt-prof:
	gcc -Wall functions.c segmenter.c profiling_main.c -lm -o main

opt-prof:
	gcc -Wall -O3 functions.c segmenter.c profiling_main.c -lm -o mainO3

no-opt-validation:
	gcc -Wall functions.c segmenter.c validation_main.c -lm -o validator


