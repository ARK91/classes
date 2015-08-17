#!/bin/bash
#
# This is the runsim for leaf (testcase) directories.

source ../../scripts/runsim-master.sh

run-vcs \
    ../../rtl/verilog/fault_sm.v             \
    ../../rtl/verilog/generic_fifo_ctrl.v    \
    ../../rtl/verilog/generic_fifo.v         \
    ../../rtl/verilog/generic_mem_medium.v   \
    ../../rtl/verilog/generic_mem_small.v    \
    ../../rtl/verilog/meta_sync_single.v     \
    ../../rtl/verilog/meta_sync.v            \
    ../../rtl/verilog/rx_data_fifo.v         \
    ../../rtl/verilog/rx_dequeue.v           \
    ../../rtl/verilog/rx_enqueue.v           \
    ../../rtl/verilog/rx_hold_fifo.v         \
    ../../rtl/verilog/sync_clk_core.v        \
    ../../rtl/verilog/sync_clk_wb.v          \
    ../../rtl/verilog/sync_clk_xgmii_tx.v    \
    ../../rtl/verilog/tx_data_fifo.v         \
    ../../rtl/verilog/tx_dequeue.v           \
    ../../rtl/verilog/tx_enqueue.v           \
    ../../rtl/verilog/tx_hold_fifo.v         \
    ../../rtl/verilog/wishbone_if.v          \
    ../../rtl/verilog/xge_mac.v              \
    ../../testbench/verilog/switch_interface.sv \
    ../../testbench/verilog/testbench.sv \
    ../../sim/verilog/packet.sv \
    ../../sim/verilog/driver.sv \
    ../../sim/verilog/monitor.sv \
    ../../sim/verilog/scoreboard.sv \
    ../../sim/verilog/env.sv \
    ../../sim/verilog/tasks.sv \
    testcase.sv \
    -v2k_generate +warn=noOBSV2G \
    -override_timescale=1ps/1ps \
    +incdir+../../rtl/include \
    +incdir+../../sim/verilog \
    +plusarg_save +ntb_random_seed_automatic


