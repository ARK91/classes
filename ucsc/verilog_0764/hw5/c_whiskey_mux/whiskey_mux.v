// File: whiskey_mux.v
// John Hubbard, 24 Oct 2014
// hw5 assignment for Verilog 0764 class: Problem 4.4.3: Liquid dispenser MUX
//

// Structural Verilog version, as required by the problem statement:

module whiskey_mux(select, beer, wine, rum, whiskey, f);
    input [1:0]select, beer, wine, rum, whiskey;
    output f;

    wire x0, x1, x2, x3;
    wire [1:0]not_select;

    not nSel0(not_select[0:0], select[0:0]);
    not nSel1(not_select[1:1], select[1:1] );

    and a0(x0, not_select[0:0], not_select[1:1], beer);
    and a1(x1, select[0:0],     not_select[1:1], wine);
    and a2(x2, not_select[0:0], select[1:1] ,    rum);
    and a3(x3, select[0:0],     select[1:1] ,    whiskey);

    or f0(f, x0, x1, x2, x3);
endmodule

