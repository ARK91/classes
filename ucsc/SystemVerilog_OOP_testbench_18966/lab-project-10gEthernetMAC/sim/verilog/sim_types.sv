// John Hubbard
// UCSC 18966: SystemVerilog OOP Testbench
// 17 Aug 2015

// Debug flags, to adjust behavior:

`define DEBUG_FLAGS_SIMPLE_LOOPBACK          8'h00
`define DEBUG_FLAG_SKIP_SOP_ON_TX            8'h01
`define DEBUG_FLAG_SKIP_EOP_ON_TX            8'h02
`define DEBUG_FLAG_USE_ZERO_IPG_ON_TX        8'h04
`define DEBUG_FLAG_OVERSIZE_PACKET_ON_TX     8'h08
`define DEBUG_FLAG_UNDERSIZE_PACKET_ON_TX    8'h10

`define VERBOSITY_SILENT   0
`define VERBOSITY_STANDARD 1
`define VERBOSITY_HIGH     2

