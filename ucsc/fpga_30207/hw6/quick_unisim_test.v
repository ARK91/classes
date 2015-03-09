// File: quick_unisim_test.v
// John Hubbard, 08 Mar 2015
//
// To make all this work:
//
// 1. Compile the simulation libraries, from within Vivado
// (Tools-->Compile Simulation Libraries). Be sure to specify an output
// directory, in order to find where Vivado put it.
//
// 2. Within Modelsim: File-->Import-->Library, and point to the unisim_ver
// subdirectory of step (1), above.
//
// 3. When linking (running vsim), pass in the library as follows:
//
//     vsim work.quick_test -L unisims_ver
//
// References:
// [1] Vivado Simulation Guide: ug900-vivado-logic-simulation.pdf
//------------------------------------------------------------------------------
// EXAMPLE:
//
//  vlog ../quick_unisim_test.v
//  # Model Technology ModelSim ALTERA vlog 10.1e Compiler 2013.06 Jun 12 2013
//  # -- Compiling module quick_unisim
//  # -- Compiling module quick_test
//  #
//  # Top level modules:
//  #   quick_test
//  vsim work.quick_test -L unisims_ver
//  # vsim -L unisims_ver work.quick_test
//  # Loading work.quick_test
//  # Loading work.quick_unisim
//  # Loading unisims_ver.LUT2
//  # Loading unisims_ver.x_lut2_mux4
//  run 10 ns
//  # a, b, f: 0, 0 | 0
//  # a, b, f: 0, 1 | 0
//  # a, b, f: 1, 0 | 0
//  # a, b, f: 1, 1 | 1
//------------------------------------------------------------------------------

`timescale 1ns/1ns

module quick_unisim(a, b, f);
    input a, b;
    output f;

    // A LUT mask of 0x8 creates an AND gate:
    LUT2 #(16'h8) theLUT(f, a, b);
endmodule

module quick_test();
    reg a, b;
    reg [4:0] vec;
    wire f;
    parameter max_vec = 4;

    quick_unisim DUT(a, b, f);

    initial
    begin
        for( vec = 0; vec < max_vec; vec = vec +  1 )
        begin
            {a,b} = vec;
            #1;
            $display("a, b, f: %b, %b | %b", a, b, f);
        end
    end
endmodule
