`timescale 1ns/1ns

interface counter_interface(input clk);
    logic reset;
    logic enable;
    logic [3:0] count;

    modport counter_port(input reset, input enable, output count);
    modport tb_port(output reset, output enable, input count);
endinterface

