// John Hubbard
// UCSC 18966: SystemVerilog OOP Testbench
// 17 Aug 2015

`include "timescale.v"
`include "defines.v"

module testbench();

    bit           clk_156m25;
    bit           clk_312m50;
    bit           clk_xgmii_rx;
    bit           clk_xgmii_tx;

    wire           wb_ack_o;
    wire [31:0]    wb_dat_o;
    wire           wb_int_o;
    wire [7:0]     xgmii_txc;
    wire [63:0]    xgmii_txd;
    wire           wb_clk_i;
    wire           wb_cyc_i;
    wire           wb_rst_i;
    wire           wb_stb_i;
    wire           wb_we_i;

    wire  [7:0]    wb_adr_i;
    wire  [31:0]   wb_dat_i;

    wire [7:0]     xgmii_rxc;
    wire [63:0]    xgmii_rxd;

    wire [3:0]     tx_dataout;

    wire           xaui_tx_l0_n;
    wire           xaui_tx_l0_p;
    wire           xaui_tx_l1_n;
    wire           xaui_tx_l1_p;
    wire           xaui_tx_l2_n;
    wire           xaui_tx_l2_p;
    wire           xaui_tx_l3_n;
    wire           xaui_tx_l3_p;

    // Start up the clocks
    initial begin
        forever begin
            WaitPS(3200);
            clk_156m25 = ~clk_156m25;
            clk_xgmii_rx = ~clk_xgmii_rx;
            clk_xgmii_tx = ~clk_xgmii_tx;
        end
    end

    initial begin
        forever begin
            WaitPS(1600);
            clk_312m50 = ~clk_312m50;
        end
    end

    // Tie off unused Wishbone interface ports:
    assign wb_adr_i = 8'b0;
    assign wb_clk_i = 1'b0;
    assign wb_cyc_i = 1'b0;
    assign wb_dat_i = 32'b0;
    assign wb_rst_i = 1'b1;
    assign wb_stb_i = 1'b0;
    assign wb_we_i = 1'b0;

    // This testbench runs in loopback mode:
    assign xgmii_rxc = xgmii_txc;
    assign xgmii_rxd = xgmii_txd;

    // Instantiate the testcase:
    switch_interface sif( .clk(clk_156m25) );
    testcase itestcase(sif.testcase_port, sif.testcase_port);

    // Instantiate the DUT (device under test):
    xge_mac dut(// Outputs
                .pkt_rx_avail               (sif.pkt_rx_avail),
                .pkt_rx_data                (sif.pkt_rx_data[63:0]),
                .pkt_rx_eop                 (sif.pkt_rx_eop),
                .pkt_rx_err                 (sif.pkt_rx_err),
                .pkt_rx_mod                 (sif.pkt_rx_mod[2:0]),
                .pkt_rx_sop                 (sif.pkt_rx_sop),
                .pkt_rx_val                 (sif.pkt_rx_val),
                .pkt_tx_full                (sif.pkt_tx_full),
                .wb_ack_o                   (wb_ack_o),
                .wb_dat_o                   (wb_dat_o[31:0]),
                .wb_int_o                   (wb_int_o),
                .xgmii_txc                  (xgmii_txc[7:0]),
                .xgmii_txd                  (xgmii_txd[63:0]),
                // Inputs
                .clk_156m25                 (clk_156m25),
                .clk_xgmii_rx               (clk_xgmii_rx),
                .clk_xgmii_tx               (clk_xgmii_tx),
                .pkt_rx_ren                 (sif.pkt_rx_ren),
                .pkt_tx_data                (sif.pkt_tx_data[63:0]),
                .pkt_tx_eop                 (sif.pkt_tx_eop),
                .pkt_tx_mod                 (sif.pkt_tx_mod[2:0]),
                .pkt_tx_sop                 (sif.pkt_tx_sop),
                .pkt_tx_val                 (sif.pkt_tx_val),
                .reset_156m25_n             (sif.reset_156m25_n),
                .reset_xgmii_rx_n           (sif.reset_xgmii_rx_n),
                .reset_xgmii_tx_n           (sif.reset_xgmii_tx_n),
                .wb_adr_i                   (wb_adr_i[7:0]),
                .wb_clk_i                   (wb_clk_i),
                .wb_cyc_i                   (wb_cyc_i),
                .wb_dat_i                   (wb_dat_i[31:0]),
                .wb_rst_i                   (wb_rst_i),
                .wb_stb_i                   (wb_stb_i),
                .wb_we_i                    (wb_we_i),
                .xgmii_rxc                  (xgmii_rxc[7:0]),
                .xgmii_rxd                  (xgmii_rxd[63:0]));
endmodule
