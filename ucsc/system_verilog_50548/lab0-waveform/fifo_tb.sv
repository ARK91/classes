module fifo_tb;

reg		clk;
reg		rstp;
reg [7:0]	src_in;
reg [7:0]	dst_in;
reg [31:0]	data_in;
reg		readp;
reg		writep;
wire [7:0]	src_out;
wire [7:0]	dst_out;
wire [31:0]	data_out;
wire		emptyp;
wire		fullp;


parameter    depth = 2;

fifo #(depth+1) U1 (
   .clk		(clk),
   .rstp	(rstp),
   .src_in	(src_in),
   .dst_in	(dst_in),
   .data_in	(data_in),
   .readp	(readp),
   .writep	(writep),
   .src_out	(src_out),
   .dst_out	(dst_out),
   .data_out	(data_out),
   .emptyp	(emptyp),
   .fullp	(fullp)
);

// Write and Read to/from FIFO 
task read_word;
begin
   @(negedge clk);
   readp = 1;
   @(posedge clk) #5;
   $display ("Read %0h from FIFO", data_out);
   readp = 0;
end
endtask
   
task automatic write_word;
input [7:0]	src;
input [7:0]	dst;
input [31:0]	data;
begin
   @(negedge clk);
   src_in = src;
   dst_in = dst;
   data_in = data;
   writep = 1;
   @(posedge clk);
   $display ("Write %0h to FIFO", data_in);
   #5;
   src_in = 8'bz;
   dst_in = 8'bz;
   data_in = 32'bz;
   writep = 0;
end
endtask

initial begin
   clk = 0;
   forever begin
      #10 clk = 1;
      #10 clk = 0;
   end
end

initial begin
   test1();
   
@(posedge clk) ;
   $finish;
end


// Directed Test
task test1();
begin
   src_in = 8'bz;
   dst_in = 8'bz;
   data_in = 32'bz;
   writep = 0;
   readp = 0;

   // Reset
   rstp = 1;
   #50;
   rstp = 0;
   #50;
   
  // ** Write 3 values.
   write_word (0,1,16'h1111);
   write_word (1,2,16'h2222);
   write_word (3,4,16'h3333);
   
   // ** Read 2 values
   read_word;
   read_word;
   
   // ** Write one more
   write_word (5,6,16'h4444);
   
   // ** Read a bunch of values
   repeat (6) begin
      read_word;
   end
   
   // *** Write a bunch more values
   write_word (0,1,16'h0001);
   write_word (0,1,16'h0002);
   write_word (0,1,16'h0003);
   write_word (0,1,16'h0004);
   write_word (0,1,16'h0005);
   write_word (0,1,16'h0006);
   write_word (0,1,16'h0007);
   write_word (0,1,16'h0008);

   // ** Read a bunch of values
   repeat (8) begin
      read_word;
   end
   
   $display ("Done TEST1.");
end
endtask

initial begin
   `ifdef ENABLE_DUMP
      $vcdpluson();
   `endif
end

endmodule
