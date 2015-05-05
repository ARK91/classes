`timescale 1ns/1ns

interface memory_interface(input bit clk);

    logic read;
    logic write;
    logic [4:0] addr;
    logic [7:0] data_in;
    logic [7:0] data_out;

    modport mem_port(input read, input write, input addr,
                     input data_in, output data_out);

    modport tb_port(import write_mem, import read_mem,
                    output read, output write, output addr,
                    output data_in, input data_out);

    task write_mem(input logic [4:0] addr_arg, input logic [7:0] data,
                   input debug);
        //implement write logic here
        write = 1'b0;
        read  = 1'b0;
        addr = addr_arg;
        data_in = data;
        #10;
        write = 1'b1;
        #10;
    endtask

    task read_mem(input logic [4:0] addr_arg, output logic [7:0] data,
                  input debug);
        //implement read logic here
        write = 1'b0;
        read  = 1'b1;
        addr = addr_arg;
        #10;
        data = data_out;
    endtask

endinterface
