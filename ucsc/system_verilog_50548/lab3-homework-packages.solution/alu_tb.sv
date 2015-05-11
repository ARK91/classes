module alu_tb;

import alu_package::*;
    logic   [7:0]   op_A, op_B;
    myopcode_t      opcode;
    logic   [7:0]   result;
    bit         clk, rst_n;

    // Place instance of the ALU here and use:
    alu alu1 (.data_1   (op_A   ),
              .data_2   (op_B   ),
              .opcode   (opcode ),
              .alu_out  (result ),
              .clk      (clk    ),
              .rst_n    (rst_n  ));

// Generate 10ns clock
    always #5 clk = ~clk;

    task gen_instructions_common();
        randsequence()
            opcode:     RST | MOV | NOT | ADD | AND | XOR | LSH | RSH;
            RST:        {};
            MOV:        {};
            NOT:        {};
            ADD:        {};
            AND:        {};
            XOR:        {};
            LSH:        {};
            RSH:        {};
        endsequence
    endtask

    task gen_instructions();
        gen_instructions_common();

        op_A = $urandom_range(8'h00, 8'hFF);
        op_B = $urandom_range(8'h00, 8'hFF);
    endtask

    task gen_special_instructions();
        gen_instructions_common();

        {op_A , op_B} = 16'h00ff; @(posedge clk) show(); verify();
        {op_A , op_B} = 16'hff00; @(posedge clk) show(); verify();
        {op_A , op_B} = 16'h7720; @(posedge clk) show(); verify();
    endtask

// Apply Stimulus
    initial
    begin
        { opcode, op_B, op_A } = 19'h0_00_00;
        @(posedge clk)
            rst_n = 1'b1;
        @(negedge clk)
            randcase
                2: gen_instructions();
                1: gen_special_instructions();
            endcase

        for(int i=0; i<4; i++) begin
            { opcode, op_B, op_A } = $urandom_range(19'h00000, 19'h7FFFF);
            @(posedge clk) show(); verify();
        end
        $finish;
    end

    // Display results
    task show();
        $display(" time = %4t ns opcode = %s operand_1 = %d ",
                 "operand_2 = %h result = %h" ,
                 $time, opcode.name(), op_A, op_B, result);
    endtask
 
    // Verify Response
    task verify() ;
        logic [7:0] expected_result;

        case (opcode)
            RST : expected_result = 8'h00;
            MOV : expected_result = op_A;
            NOT : expected_result = ~op_A;
            ADD : expected_result = op_A + op_B;
            AND : expected_result = op_A & op_B;
            XOR : expected_result = op_A ^ op_B;
            LSH : expected_result = op_A << 4;
            RSH : expected_result = op_A >> 4;
            default: expected_result = 8'h00;
        endcase

        if ( expected_result == result)
            $display("PASS");
        else
            $display("FAIL");
    endtask

    // Check for timeout
    initial begin
        #2000ns $display ("TIMEOUT REACHED" );
        $finish;
    end

    // To display the waveforms
    initial begin
        $vcdpluson();
    end
endmodule
