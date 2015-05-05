`timescale 1ns/1ns

interface counter_interface(input clk);
    logic reset;
    logic enable;
    logic [3:0] count;

    task monitor();
        while(1) begin
            @(posedge top_tb.clk);
            if(cif.enable) begin
                $display("%0dns: reset %b enable %b count %b",
                         $time, cif.reset, cif.enable, cif.count);
            end
        end
    endtask

    modport counter_port(input reset, input enable, output count);
    modport tb_port(import monitor,
                    output reset, output enable, input count);
endinterface

