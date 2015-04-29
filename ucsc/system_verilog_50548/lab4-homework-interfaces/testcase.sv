`timescale 1ns/1ns

module testcase(output clk, 
                output read,
                output write,
                output [4:0] addr,
                output [7:0] data_in,
                input  [7:0] data_out
               );


bit         clk;
logic       read;
logic       write;
logic [4:0] addr;

wire  [7:0] data_out;  
logic [7:0] data_in;   

//bit         debug = 1;
logic [7:0] rdata;

  initial begin
      #4000ns $display ( "MEMORY TEST TIMEOUT" );
      $finish;
    end

always #5 clk = ~clk;

initial
  begin
    int error_status;
    $display("Clearing the memory");

    for (int i = 0; i< 32; i++)
       begin
         write_mem (i, 0);
         $display("waddr=%h, wdata=%h", i, 0);
       end

    for (int i = 0; i<32; i++)
      begin 
       read_mem (i, rdata);
       $display("raddr=%h, rdata=%h", i, rdata);
       if (rdata != 0)
          error_status++;
      end

    printstatus(error_status);

    $display("Data = Address Test");
    error_status = 0;

    for (int i = 0; i< 32; i++)
       begin
         write_mem (i, i);
         $display("waddr=%h, wdata=%h", i, i);
       end

    for (int i = 0; i<32; i++)
      begin
       read_mem (i, rdata);
       $display("raddr=%h, rdata=%h", i, rdata);
       if (rdata != i)

         error_status++; 
      end

    printstatus(error_status);
    $finish;
  end


function void printstatus (input int status);
  begin
    if (status != 0)
       $display ("Test Failed with %d Errors", status);
    else
       $display ("Test Passed");
  end
endfunction

task write_mem(...);
//implement write logic here
endtask

task read_mem(...);
//implement read logic here
endtask

endmodule
