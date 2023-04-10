default: compile

compile:
	nvcc functions.c main_test.cu

run:
	./a.out

clean:
	@rm -f a.out

help:
	@echo "=== Targets ==="
	@echo " help		- Show this text"
	@echo " compile	- Compile the code"
	@echo " run		- Execute the code"
	@echo " clean		- Remove executables"
	@echo " default	- Compile the code"
	@echo "==============="
	@echo "See README.md for more information"
	@echo ""