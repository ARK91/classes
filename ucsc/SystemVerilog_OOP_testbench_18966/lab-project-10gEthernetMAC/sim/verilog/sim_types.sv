// John Hubbard
// UCSC 18966: SystemVerilog OOP Testbench
// 17 Aug 2015

// Debug flags, to adjust behavior:

`define DEBUG_FLAGS_SIMPLE_LOOPBACK          0
`define DEBUG_FLAG_SKIP_SOP_ON_TX            1
`define DEBUG_FLAG_SKIP_EOP_ON_TX            2
`define DEBUG_FLAG_USE_ZERO_IPG_ON_TX        4
`define DEBUG_FLAG_OVERSIZE_PACKET_ON_TX     8
`define DEBUG_FLAG_UNDERSIZE_PACKET_ON_TX   16

typedef enum {
    VERBOSITY_SILENT,
    VERBOSITY_STANDARD,
    VERBOSITY_HIGH
} verbosity_t;


