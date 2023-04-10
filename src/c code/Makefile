default: no-opt-prof opt-prof

no-opt-prof:
	gcc -Wall functions.c segmenter.c profiling_main.c -lm -o main

opt-prof:
	gcc -Wall -O3 functions.c segmenter.c profiling_main.c -lm -o mainO3

validation:
	gcc -Wall functions.c segmenter.c validation_main.c -lm -o validator

help:
	@echo "=== Targets ==="
	@echo " help		- Show this text"
	@echo " no-opt-prof	- Compile the code for profiling without optimization"
	@echo " opt-prof	- Compile the code for profiling with optimization"
	@echo " validation	- Compile the code for validation"
	@echo " default	- Compile the code for profiling with and without optimization (mainO3 and main respectively)"
	@echo "==============="
	@echo "See README.md for more information"
	@echo ""
