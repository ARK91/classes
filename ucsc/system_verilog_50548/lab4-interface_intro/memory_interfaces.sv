`timescale 1ns/1ns

interface mem_if();
    logic         reset;
    logic         we;
    logic         ce;
    logic   [7:0] datai;
    logic  [7:0] datao;
    logic   [7:0] addr;
endinterface

