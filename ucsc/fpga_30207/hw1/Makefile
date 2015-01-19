all: run

truth_table_generator: truth_table_generator.c 
	gcc $+ -o $@ 

run: truth_table_generator
	./truth_table_generator | tee truth_table.txt
