package pkg1;
`include "transaction.sv"
`include "opcode.sv"
endpackage

// import pkg1::*;
// `include "opcode.sv"
// `include "transaction.sv"

interface intf(input logic clk);

    logic [31:0] operand_a_i , operand_b_i , operand_c_i;
    logic enable_i;
    logic [1:0] vector_mode_i;
    logic [4:0] bmask_a_i;
    logic [4:0] bmask_b_i;
    logic [1:0] imm_vec_ext_i;
    logic is_clpx_i , is_subrot_i , ex_ready_i;
    logic [1:0] clpx_shift_i;
 	logic [6:0] operator_i;
  	logic rst_n;

    logic [31:0] result_o;
    logic comparison_result_o , ready_o;

endinterface