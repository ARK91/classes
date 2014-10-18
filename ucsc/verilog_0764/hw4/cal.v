// File: cal.v
// John Hubbard, 17 Oct 2014
// hw4 assignment for Verilog 0764 class
//

module cal(year, month, day, dayOfWeek, errorFlag);
    input year, month, day;
    output dayOfWeek, errorFlag;
    integer year, month, day, dayOfWeek, errorFlag;
    integer monthKey, dayKey;

    parameter YEAR_TABLE_DEPTH = 279; // 2033 - 1755 + 1
    parameter YEAR_TABLE_WIDTH = 20;  // 16 bits for year, 4 bits for key

    parameter MONTH_TABLE_DEPTH = 14;     // A-N
    parameter MONTH_TABLE_WIDTH = 12 * 4; // 12 months, 4 bits per entry

    parameter DAY_TABLE_DEPTH = 7;       // One row for each "calendar"
    parameter DAY_TABLE_WIDTH = 37 * 8;  // 37 entries, 8 bits per entry

    // Encoding: lower 4 bits: key, upper 20 bits: year:
    reg [YEAR_TABLE_WIDTH - 1:0] yearEntry;
    reg [YEAR_TABLE_WIDTH - 1:0] yearTable[YEAR_TABLE_DEPTH - 1:0];

    reg [MONTH_TABLE_WIDTH - 1:0] monthEntry;
    reg [MONTH_TABLE_WIDTH - 1:0] monthTable[MONTH_TABLE_DEPTH - 1:0];

    reg [DAY_TABLE_WIDTH - 1:0] dayEntry;
    reg [DAY_TABLE_WIDTH - 1:0] dayTable[DAY_TABLE_DEPTH - 1:0];

    // Not synthesizable, but allowed for this assignment:
    initial
        begin
            // Each table has the index in the upper bits, and payload in the
            // lower 4 bits.
            $readmemh("../year_table_transformed.txt", yearTable);
            $readmemh("../month_table.txt", monthTable);
            $readmemh("../day_table.txt", dayTable);
        end

    always @(year, month, day)
    begin
        if ((year < 1755) || (year > 2033))
            errorFlag = 1;
        else
        begin
            errorFlag = 0;

            yearEntry = yearTable[year - 1755];
            // Subtract one, because the zero-th entry is for month 1:
            monthKey = yearEntry[3:0] - 1;

            monthEntry = monthTable[monthKey];
            // Subtract one, to make month zero-based:
            dayKey = ((monthEntry >> ((month-1)*4)) & 4'hF);

            // Subtract 1 again, to get to a zero-based row index:
            dayEntry = dayTable[dayKey] - 1;
            dayOfWeek = (dayEntry >> ((day - 1) * 8)) & 8'hFF;

            // $display("CAL: year: %d, key: %h\n", yearEntry[19:4], monthKey);
            // $display("CAL: year: %d, dayKey: %h\n", yearEntry[19:4], dayKey);
            // $display("CAL: year: %d, dayEntry: %h\n", yearEntry[19:4], dayEntry);
        end

    end
endmodule

