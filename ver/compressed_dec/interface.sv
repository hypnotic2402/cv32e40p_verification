package pkg1;
`include "transaction.sv"
// `include "opcode.sv"
endpackage

// import pkg1::*;
// `include "opcode.sv"
// `include "transaction.sv"

interface intf(input logic clk);

    logic [31:0] instr_i,
    logic [31:0] instr_o,
    logic        is_compressed_o,
    logic        illegal_instr_o
    
endinterface