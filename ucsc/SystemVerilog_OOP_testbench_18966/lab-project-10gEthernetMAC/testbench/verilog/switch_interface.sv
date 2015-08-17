// John Hubbard
// UCSC 18966: SystemVerilog OOP Testbench
// 17 Aug 2015

interface switch_interface(input clk);

    // TX path DUT inputs
    logic         pkt_tx_val;
    logic         pkt_tx_sop;
    logic         pkt_tx_eop;
    logic [2:0]   pkt_tx_mod;
    logic [63:0]  pkt_tx_data;

    // TX path DUT outputs:
    logic         pkt_tx_full;

    // RX path DUT outputs:
    logic         pkt_rx_avail;
    logic         pkt_rx_val;
    logic         pkt_rx_sop;
    logic         pkt_rx_eop;
    logic [2:0]   pkt_rx_mod;
    logic [63:0]  pkt_rx_data;
    logic         pkt_rx_err;

    // RX path DUT inputs:
    logic         pkt_rx_ren;

    default clocking cb @(posedge clk);
        output #1  pkt_tx_val,
                   pkt_tx_sop,
                   pkt_tx_eop,
                   pkt_tx_mod,
                   pkt_tx_data,
                   pkt_rx_ren;

        input #2  pkt_tx_full,
                  pkt_rx_avail,
                  pkt_rx_val,
                  pkt_rx_sop,
                  pkt_rx_eop,
                  pkt_rx_mod,
                  pkt_rx_data,
                  pkt_rx_err;
    endclocking

    modport testcase_port(input clk,
                          clocking cb);
endinterface
