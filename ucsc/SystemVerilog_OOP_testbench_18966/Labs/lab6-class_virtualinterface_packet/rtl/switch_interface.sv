interface switch_interface(input clk);

    logic [47:0] src_addr;
    logic [31:0] src_data;

    logic [47:0] dst_addr;
    logic [31:0] dst_data;

    modport switch_port( input clk,
                         input src_addr,
                         input src_data);

    default clocking cb @(posedge clk);
        output #1  src_addr,
                   src_data;

        input #2   dst_addr,
                   dst_data;
    endclocking

    modport testcase_port(input clk,
                          clocking cb);
endinterface
