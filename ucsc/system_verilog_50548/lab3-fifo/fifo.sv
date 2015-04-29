// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// CDANOTE Verilog Synchronous FIFO 
//         4 x 16 bit words
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

module fifo (clk, rstp, src_in, dst_in, data_in, writep, readp, 
    src_out, dst_out, data_out, emptyp, fullp);
input       clk;
input       rstp;
input [7:0] src_in;
input [7:0] dst_in;
input [31:0]    data_in;
input       readp;
input       writep;
output [7:0]    src_out;
output [7:0]    dst_out;
output [31:0]   data_out;
output      emptyp;
output      fullp;

// Defines sizes in terms of bits.
//
parameter   DEPTH = 2,      // 2 bits, e.g. 4 words in the FIFO.
        MAX_COUNT = (1<<DEPTH); // topmost address in FIFO.

logic         emptyp;
logic     fullp;

`begin_keywords "1364-2001"
reg [5:0]int;
`end_keywords

// Registered output.
logic [7:0]   src_out;
logic [7:0]   dst_out;
logic [31:0]  data_out;

// Define the FIFO pointers.  A FIFO is essentially a circular queue.
//
logic [(DEPTH-1):0]   tail;
logic [(DEPTH-1):0]   head;

// Define the FIFO counter.  Counts the number of entries in the FIFO which
// is how we figure out things like Empty and Full.
//
logic [DEPTH:0]   count;

// Define our regsiter bank.  This is actually synthesizable!


logic [47:0] fifomem[0:MAX_COUNT];

// Dout is registered and gets the value that tail points to RIGHT NOW.
//
integer i;
always_ff @(posedge clk or posedge rstp) begin
   if (rstp == 1) begin
      src_out <= 8'b0;
      dst_out <= 8'b0;
      data_out <= 32'b0;
   end
   else begin
      {src_out,dst_out,data_out} <= fifomem[tail];
   end
end 
     
// Update FIFO memory.
always_ff @(posedge clk)
   if (rstp == 1'b0) begin
     if (writep == 1'b1 && fullp == 1'b0)
      fifomem[head] <= {src_in,dst_in,data_in};
   end

// Update the head register.
//
always_ff @(posedge clk) begin
   if (rstp == 1'b1) begin
      head <= 0;
   end
   else begin
      if (writep == 1'b1 && fullp == 1'b0) begin
         // WRITE
         head <= head + 1;
      end
   end
end

// Update the tail register.
//
always_ff @(posedge clk) begin
   if (rstp == 1'b1) begin
      tail <= 0;
   end
   else begin
      if (readp == 1'b1 && emptyp == 1'b0) begin
         // READ               
         tail <= tail + 1;
      end
   end
end

// Update the count regsiter.
//
always_ff @(posedge clk) begin
   if (rstp == 1'b1) begin
      count <= 0;
   end
   else begin
      case ({readp, writep})
         2'b00: count <= count;
         2'b01: 
            // WRITE
            if (!fullp) 
               count <= count + 1;
         2'b10: 
            // READ
            if (!emptyp)
               count <= count - 1;
         2'b11:
            // Concurrent read and write.. no change in count
            count <= count;
      endcase
   end
end

         
// *** Update the flags
//
// First, update the empty flag.
//
always_comb begin
   if (count == 0)
     emptyp = 1'b1;
   else
     emptyp = 1'b0;
end


// Update the full flag
//
always_comb begin
   if (count < MAX_COUNT)
      fullp = 1'b0;
   else
      fullp = 1'b1;
end

endmodule

