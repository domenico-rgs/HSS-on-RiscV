default: gen-data gen-weights run clean

gen-data:
	g++ -Wall gen_test_data.cpp -o gen_data

gen-weights:
	g++ -Wall gen_all_weights_switch.cpp -o gen_weights

run:
	./gen_data && ./gen_weights

clean:
	@rm -f gen_data gen_weights

help:
	@echo "=== Targets ==="
	@echo " help		- Show this text"
	@echo " gen-data	- Compile the code data binary file generator"
	@echo " gen-weights	- Compile the code weights generator"
	@echo " run		- Generate the data and weights"
	@echo " clean		- Remove executables"
	@echo " default	- Compile the code for data and weights generation, run them and at the and remove the executables"
	@echo "==============="
	@echo "See README.md for more information"
	@echo ""



