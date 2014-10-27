// File: coconuts.v
// John Hubbard, 26 Oct 2014
// hw6 assignment for Verilog 0764 class: Problem 6.8.7. Coconut and Monkey Puzzle
//

module coconut_allocator(coconuts, man, big_pile, monkey, valid);
    input integer coconuts;
    output integer man[5];
    output integer big_pile[5];
    output wire [2:0]monkey;
    output wire valid;

    wire [5:0]preValid;

    assign man[0]      = (coconuts - 1) / 5;
    assign big_pile[0] = (coconuts - 1) * 4/5;
    assign preValid[0] = ((coconuts % 5) == 1);

    assign man[1]      = (big_pile[0] - 1) / 5;
    assign big_pile[1] = (big_pile[0] - 1) * 4/5;
    assign preValid[1] = ((big_pile[0] % 5) == 1);

    assign man[2]      = (big_pile[1] - 1) / 5;
    assign big_pile[2] = (big_pile[1] - 1) * 4/5;
    assign preValid[2] = ((big_pile[1] % 5) == 1);

    assign man[3]      = (big_pile[2] - 1) / 5;
    assign big_pile[3] = (big_pile[2] - 1) * 4/5;
    assign preValid[3] = ((big_pile[2] % 5) == 1);

    assign man[4]      = (big_pile[3] - 1) / 5;
    assign big_pile[4] = (big_pile[3] - 1) * 4/5;
    assign preValid[4] = ((big_pile[3] % 5) == 1);

    assign preValid[5] = ((big_pile[4] % 5) == 1);

    assign valid = &(preValid[5:0]) && (big_pile[4] > 5);

    assign monkey = 6;

endmodule

