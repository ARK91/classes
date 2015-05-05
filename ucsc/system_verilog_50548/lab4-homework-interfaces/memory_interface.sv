`timescale 1ns/1ns

interface memory_interface(input bit clk);

    logic read;
    logic write;
    logic [4:0] addr;
    logic [7:0] data_in;
    logic [7:0] data_out;

    modport mem_port(input read, input write, input addr,
                     input data_in, output data_out);

    modport tb_port(output read, output write, output addr,
                    output data_in, input data_out);

endinterface
