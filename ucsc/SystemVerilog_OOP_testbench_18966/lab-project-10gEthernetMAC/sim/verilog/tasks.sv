// John Hubbard
// UCSC 18966: SystemVerilog OOP Testbench
// 17 Aug 2015

task WaitPS;
  input [31:0] delay;
    begin
        #(delay);
    end
endtask

task WaitNS;
  input [31:0] delay;
    begin
        #(1000*delay);
    end
endtask

function bit should_get_valid_received_packet(logic [7:0] debug_flags);
    return (debug_flags == `DEBUG_FLAGS_SIMPLE_LOOPBACK);
endfunction

