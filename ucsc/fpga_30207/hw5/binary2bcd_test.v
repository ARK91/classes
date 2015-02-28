//  File: binary2bcd_test.v
// John Hubbard

// YOU CANNOT CHANGE ANYTHING BELOW
module binary2bcdTest(clk, btnU, seg, an,led) ;
    parameter N = 7 ;
    parameter W = 4 ;

    input clk, btnU ;
    output [0:N-1] seg ;
    output [W-1:0] an ;
    output[15:0] led ;

    wire done ;
    reg[15:0] number ;
    wire[15:0] text1,text2,text3,text ;

    always @(posedge clk or posedge btnU)
    begin
    if (btnU)
        number = 0;
    else if (done)
        number = number + 1 ;
    end

    binary2bcdBehavioral U1(number,text1) ;
    binary2bcdStructral U2(number,text2) ;
    binary2bcdDivision U3(number,text3) ;

    assign equal = ((text1 == text2) && (text1 == text3) && (text2 == text3))?1'b1:1'b0 ;
    assign text = {15'b0,equal} ;

    display_at_n_second #(0.5) D (clk, btnU, seg, an, text,done) ;

    assign led = text1 ;
endmodule


