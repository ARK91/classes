interface switch_interface(input clk);

    logic [47:0] src_addr;
    logic [31:0] src_data;

    logic [47:0] dst_addr;
    logic [31:0] dst_data;

    modport switch_port( input clk,
                         input src_addr,
                         input src_data);

    modport testcase_port(input clk,
                          output src_addr,
                          output src_data,

                          input dst_addr,
                          input dst_data);
endinterface
