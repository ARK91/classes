// File: coconuts.v
// John Hubbard, 26 Oct 2014
// hw6 assignment for Verilog 0764 class: Problem 6.8.7. Coconut and Monkey Puzzle
//

// Structural Verilog version, as required by the problem statement:

module coconut_allocator(coconuts, m1, m2, m3, m4, m5, s, monkey, valid);
    input integer coconuts;
    output integer m1, m2, m3, m4, m5, s, monkey;
    output wire valid;

    wire [5:0]preValid;

    assign m1 = coconuts / 5;
    assign preValid[0] = ((m1 % 5) == 1);

    assign m2 = (coconuts * 4/25);
    assign preValid[1] = ((m2 % 5) == 1);

    assign m3 = (coconuts * 4/125);
    assign preValid[2] = ((m3 % 5) == 1);

    assign m4 = (coconuts * 4/625);
    assign preValid[3] = ((m4 % 5) == 1);

    assign m5 = (coconuts * 4/3125);
    assign preValid[4] = ((m5 % 5) == 1);

    assign s = (coconuts * 4/15625);
    assign preValid[5] = ((s % 5) == 1);

    assign valid = &preValid[5:0];

endmodule

