default: gen-data gen-weights run clean

gen-data:
	g++ -Wall gen_test_data.cpp -o gen_data

gen-weights:
	g++ -Wall gen_all_weights_switch.cpp -o gen_weights

run:
	./gen_data && ./gen_weights

clean:
	@rm -f gen_data gen_weights


