package pkg1;
`include "transaction.sv"
`include "opcode.sv"
endpackage

// import pkg1::*;
// `include "opcode.sv"
// `include "transaction.sv"

interface intf(input logic clk);

    logic [31:0] in_i ;
    logic [4:0] first_one_o;
    logic cno_ones_o;

endinterface