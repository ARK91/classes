module memory(input  wire        clk,
              input  wire        reset, 
              input  wire        we,
              input  wire        ce,
              input  wire  [7:0] datai,
              output logic [7:0] datao,
              input  wire  [7:0] addr                 
             );


// Memory array
logic [7:0] mem [0:255];


//=================================================
// Read logic
//=================================================
always @ (posedge clk)
 if (reset) datao <= 0;
 else if (ce && !we) begin
   datao <= mem[addr];
 end

//=================================================
// Write Logic
//=================================================
always @ (posedge clk)
 if (ce && we) begin
   mem[addr] <= datai;
 end

endmodule
