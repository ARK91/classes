// For SystemVerilog OOP Testbench class, lab4 (Interface-program-clocking)
// John Hubbard, 19 Jul 2015 (Sunday)

`timescale 1ns/1ns

module memory_tb();

    bit         clk;
    logic       reset;

    // Signals for Memory Core
    logic       we_mem;
    logic       ce_mem;
    logic [7:0] addr_mem;
    logic [7:0] datai_mem;
    logic [7:0] datao_mem;

    // Signals for Memory Controller
    logic       we_sys;
    logic       cmd_valid_sys;
    logic [7:0] addr_sys;
    logic       ready_sys;
    logic [7:0] data_sys;

    // Free running clock
    always #5 clk = !clk;

    memory_interface miff(clk);

    memory_core memcore   (miff.core_port);
    memory_ctrl memctrl   (miff.ctrl_port);
    testcase    itestcase (miff.testcase_port);

    initial begin
        // Ensure that we can always view waves, with DVE:
        $vcdpluson();
    end
endmodule
