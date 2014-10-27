// File: coconuts.v
// John Hubbard, 26 Oct 2014
// hw6 assignment for Verilog 0764 class: Problem 6.8.7. Coconut and Monkey Puzzle
//

`timescale 1ns/1ns
module coconut_allocator(coconuts,
                         man1, man2, man3, man4, man5,
                         big_pile1, big_pile2, big_pile3, big_pile4, big_pile5,
                         monkey, valid);
    input wire  [31:0]coconuts;
    output wire [31:0] man1, man2, man3, man4, man5;
    output wire [31:0] big_pile1, big_pile2, big_pile3, big_pile4, big_pile5;
    output wire [2:0]monkey;
    output wire valid;

    wire [5:0]preValid;

    assign man1      = (coconuts - 1) / 5;
    assign big_pile1 = (coconuts - 1) * 4/5;
    assign preValid[0] = ((coconuts % 5) == 1);

    assign man2      = (big_pile1 - 1) / 5;
    assign big_pile2= (big_pile1 - 1) * 4/5;
    assign preValid[1] = ((big_pile1 % 5) == 1);

    assign man3      = (big_pile2- 1) / 5;
    assign big_pile3= (big_pile2- 1) * 4/5;
    assign preValid[2] = ((big_pile2% 5) == 1);

    assign man4      = (big_pile3- 1) / 5;
    assign big_pile4= (big_pile3- 1) * 4/5;
    assign preValid[3] = ((big_pile3% 5) == 1);

    assign man5      = (big_pile4- 1) / 5;
    assign big_pile5= (big_pile4- 1) * 4/5;
    assign preValid[4] = ((big_pile4% 5) == 1);

    assign preValid[5] = ((big_pile5% 5) == 1);

    assign valid = &(preValid[5:0]) && (big_pile5> 5);

    assign monkey = 6;

endmodule

