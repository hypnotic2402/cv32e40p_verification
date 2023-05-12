// package p2;
// `include "opcode.sv"
// endpackage


class transaction;

    // Defining IO's of AL
    rand bit [31:0] operand_a_i , operand_b_i , operand_c_i;
    rand bit enable_i;
    rand bit [1:0] vector_mode_i;
    rand bit [4:0] bmask_a_i;
    rand bit [4:0] bmask_b_i;
    rand bit [1:0] imm_vec_ext_i;
    rand bit is_clpx_i , is_subrot_i , ex_ready_i;
    rand bit [1:0] clpx_shift_i;
    rand bit [6:0] operator_i;
  	rand bit rst_n;

    bit [31:0] result_o;
    bit comparison_result_o , ready_o;


    // Constraints to be added
  
  constraint and_en {operator_i inside {7'b0010101 , 7'b0101110 , 7'b0101111};};
//     constraint or_en {operator_i in {7'b0101110}};
//     constraint xor_en {operator_i in {7'b0101111}};

    // Coverage Metrics

    covergroup cg;

        option.per_instance = 1;
        coverpoint operand_a_i;
        coverpoint operand_b_i;
        coverpoint operand_c_i;
        coverpoint enable_i;
        coverpoint vector_mode_i;
        coverpoint bmask_a_i;
        coverpoint bmask_b_i;
        coverpoint imm_vec_ext_i;
        coverpoint is_clpx_i;
        coverpoint is_subrot_i;
        coverpoint ex_ready_i;
        coverpoint clpx_shift_i;
        coverpoint rst_n;


    endgroup

    function new();
        cg = new;
    endfunction

    function void display(string name);

        $display("time = %0d , %s , A = %0h , B = %0h , C = %0h" , $time , name , operand_a_i , operand_b_i , operand_c_i);

    endfunction



endclass