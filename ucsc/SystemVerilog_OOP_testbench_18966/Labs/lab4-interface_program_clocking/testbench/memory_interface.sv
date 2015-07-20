// memory_interface.sv
// For SystemVerilog OOP Testbench class, lab4 (Interface-program-clocking)
// John Hubbard, 19 Jul 2015 (Sunday)

interface memory_interface(input bit clk);
    logic          reset;
    logic          we_sys;
    logic          cmd_valid_sys;
    logic [7:0]    addr_sys;
    logic [7:0]    data_sys;
    logic          ready_sys;

    logic          we_mem;
    logic          ce_mem;
    logic [7:0]    addr_mem;
    logic [7:0]    datai_mem;
    logic [7:0]    datao_mem;

    modport core_port(input reset,
                      input we_mem,
                      input ce_mem,
                      input addr_mem,
                      input datai_mem,

                      output datao_mem);

    modport ctrl_port(input reset,
                      input we_sys,
                      input cmd_valid_sys,
                      input addr_sys,
                      input datao_mem,

                      output we_mem,
                      output ce_mem,
                      output addr_mem,
                      output datai_mem,
                      output ready_sys,
                      inout data_sys);

    modport testcase_port(inout data_sys,
                          input ready_sys,

                          output reset,
                          output we_sys,
                          output cmd_valid_sys,
                          output addr_sys);

    default clocking memcb @(posedge clk);
        default input #1ns
                output #5ns;

            output reset;
            output we_sys;
            output cmd_valid_sys;
            output addr_sys;

            input ready_sys;
            inout data_sys;
    endclocking
endinterface
