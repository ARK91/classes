VERILOG_CODE := verilog_code_generated.v

all: $(VERILOG_CODE)

verilog_code_generator: verilog_code_generator.c 
	gcc $+ -o $@ 

$(VERILOG_CODE): verilog_code_generator
	./verilog_code_generator > $@
