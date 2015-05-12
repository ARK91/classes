module alu_tb;

import alu_package::*;
    logic   [7:0]   op_A, op_B;
    myopcode_t      opcode;
    logic   [7:0]   result;
    bit         clk, rst_n, success;

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
            OPCODE:     OP_RST | OP_MOV | OP_NOT | OP_ADD | OP_AND | OP_XOR | 
                        OP_LSH | OP_RSH;
            OP_RST:        { opcode = RST; };
            OP_MOV:        { opcode = MOV; };
            OP_NOT:        { opcode = NOT; };
            OP_ADD:        { opcode = ADD; };
            OP_AND:        { opcode = AND; };
            OP_XOR:        { opcode = XOR; };
            OP_LSH:        { opcode = LSH; };
            OP_RSH:        { opcode = RSH; };
        endsequence
    endtask

    task gen_instructions();

        gen_instructions_common();


        op_A = $urandom_range(8'h00, 8'hFF);
        op_B = $urandom_range(8'h00, 8'hFF);
        @(posedge clk) show(); verify();
    endtask

    task gen_special_instructions();

        gen_instructions_common();

        randsequence()
            OPERANDS:   A | B | C | D | E;
            A: {{op_A , op_B} = 16'h00ef; @(posedge clk) show(); verify();};
            B: {{op_A , op_B} = 16'h0075; @(posedge clk) show(); verify();};
            C: {{op_A , op_B} = 16'h3301; @(posedge clk) show(); verify();};
            D: {{op_A , op_B} = 16'h7720; @(posedge clk) show(); verify();};
            E: {{op_A , op_B} = 16'h1052; @(posedge clk) show(); verify();};
        endsequence
    endtask

    task gen_other_random_instructions();

        gen_instructions_common();

        success = randomize(opcode, op_A, op_B);
            @(posedge clk) show(); verify();
        success = randomize(opcode, op_A, op_B) with {op_A > 3;};
            @(posedge clk) show(); verify();
        success = randomize(opcode, op_A, op_B) with {op_A inside {1, 2};};
            @(posedge clk) show(); verify();
        success = randomize(opcode, op_A, op_B) with
            {op_A dist{[50:100]:=4, [7:8]:=5}; };
            @(posedge clk) show(); verify();
        success = randomize(opcode, op_A, op_B)
            with {
                if(op_A == 0)
                    op_B == 17;
                else
                    op_B > 18;
                };
            @(posedge clk) show(); verify();
        success = randomize(opcode, op_A, op_B)
            with { (op_A == 0)  -> op_B == 21;
                   (op_A == 10) -> op_B > 22;
                };
            @(posedge clk) show(); verify();
    endtask

// Apply Stimulus
    initial
    begin
	opcode = RST;
    { op_B, op_A } = 16'h0000;
    @(posedge clk)
        rst_n = 1'b1;
	
	@(negedge clk) begin
        randcase
            1: repeat(3) gen_instructions();
            2: repeat(4) gen_special_instructions();
            1: repeat(5) gen_other_random_instructions();
        endcase
	end

        $finish;
    end

    // Display results
    task show();
        $display("opcode = %s operand_1 = %d operand_2 = %d result = %d" ,
                 opcode.name(), op_A, op_B, result);
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
