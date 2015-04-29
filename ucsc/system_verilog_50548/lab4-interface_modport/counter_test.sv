module counter_test(input clk,
                    input logic reset,
                    input logic enable,
                    input logic [3:0] count
                   );

  int count_delay;  

  //=================================================
  // Generate the test vector
  //=================================================
  initial begin
    // Fork of the monitor
    fork
      monitor();
    join_none

    reset = 1;
    enable = 0;
    #10 reset = 0;
    #1 enable = 1;

    //Disable counter
    count_delay = $urandom_range(150, 250);
    #count_delay enable = 0;

    #5 $finish;
  end


  task monitor();
     while(1) begin
        @(posedge top_tb.clk);
          if(enable) begin
             $display("%0dns: reset %b enable %b count %b", $time, reset, enable, count);
          end
     end
  endtask

endmodule
