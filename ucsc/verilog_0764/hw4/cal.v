// File: cal.v
// John Hubbard, 17 Oct 2014
// hw4 assignment for Verilog 0764 class
//

module cal(year, month, day, dayOfWeek, errorFlag);
    input year, month, day;
    output dayOfWeek, errorFlag;
    integer year, month, day, dayOfWeek, errorFlag;

    parameter DEPTH = 279; // 2033 - 1755 + 1
    parameter WIDTH = 20;

    reg [WIDTH - 1:0] entry;
    reg [WIDTH - 1:0] yearTable[DEPTH - 1:0];

    // Not synthesizable, but allowed for this assignment:
    initial
        $readmemh("../year_table_transformed.txt", yearTable);

    always @(year, month, day)
    begin
        if ((year < 1755) || (year > 2033))
            errorFlag = 1;
        else
        begin
            errorFlag = 0;
            dayOfWeek = 30000; // TODO: implement
            entry = yearTable[year - 1755];
            //$display("year: %d, key: %h\n", entry[19:4], entry[3:0]);
        end

    end
endmodule

