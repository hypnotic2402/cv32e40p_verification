// package p2;
// `include "opcode.sv"
// endpackage


class transaction;

    // Defining IO's of AL
    rand logic [31:0] operand_a_i , operand_b_i , operand_c_i;
    rand logic enable_i;
    rand logic [1:0] vector_mode_i;
    rand logic [4:0] bmask_a_i;
    rand logic [4:0] bmask_b_i;
    rand logic [1:0] imm_vec_ext_i;
    rand logic is_clpx_i , is_subrot_i , ex_ready_i;
    rand logic [1:0] clpx_shift_i;
    rand logic [6:0] operator_i;
  	rand logic rst_n;

    bit [31:0] result_o;
    bit comparison_result_o , ready_o;


    // Constraints to be added
  constraint resetOff {rst_n == 1;};

  constraint abs_en {operator_i ==7'b0010100; operand_b_i == 7'b0000000 ; enable_i == 1 ; is_clpx_i == 0; is_subrot_i == 0; ex_ready_i == 1;};
  constraint slet_en {operator_i ==7'b0000110 ; enable_i == 1 ; is_clpx_i == 0; is_subrot_i == 0; ex_ready_i == 1;};
  constraint sletu_en {operator_i ==7'b0000111 ; enable_i == 1 ; is_clpx_i == 0; is_subrot_i == 0; ex_ready_i == 1;};
  constraint min_en {operator_i == 7'b0010000 ; enable_i == 1 ; is_clpx_i == 0; is_subrot_i == 0; ex_ready_i == 1;};
  constraint minu_en {operator_i == 7'b0010001 ; enable_i == 1 ; is_clpx_i == 0; is_subrot_i == 0; ex_ready_i == 1;};
  constraint max_en {operator_i == 7'b0010010 ; enable_i == 1 ; is_clpx_i == 0; is_subrot_i == 0; ex_ready_i == 1;};
  constraint maxu_en {operator_i == 7'b0010011 ; enable_i == 1 ; is_clpx_i == 0; is_subrot_i == 0; ex_ready_i == 1;};
  

  constraint and_en {operator_i == 7'b0010101 ; enable_i == 1 ; is_clpx_i == 0; is_subrot_i == 0; ex_ready_i == 1;};
  constraint or_en {operator_i == 7'b0101110 ; enable_i == 1 ; is_clpx_i == 0; is_subrot_i == 0; ex_ready_i == 1;};
  constraint xor_en {operator_i == 7'b0101111 ; enable_i == 1 ; is_clpx_i == 0; is_subrot_i == 0; ex_ready_i == 1;};
//     constraint or_en {operator_i in {7'b0101110}};
//     constraint xor_en {operator_i in {7'b0101111}};

    // Coverage Metrics

    covergroup cg;

        option.per_instance = 1;
        coverpoint operand_a_i;
        coverpoint operand_b_i;
        coverpoint operand_c_i;
        // coverpoint enable_i;
        coverpoint vector_mode_i;
        coverpoint bmask_a_i;
        coverpoint bmask_b_i;
        coverpoint imm_vec_ext_i;
        // coverpoint is_clpx_i;
        coverpoint is_subrot_i;
        // coverpoint ex_ready_i;
        coverpoint clpx_shift_i;
        // coverpoint rst_n;


    endgroup

    function new();
        cg = new;
    endfunction

    function void display(string name);

      $display("time = %0d , %s , A = %0b , B = %0b , C = %0b , enable = %0b, rst_n = %0b , vector_mode = %0b" , $time , name , operand_a_i , operand_b_i , operand_c_i , enable_i , rst_n , vector_mode_i);

    endfunction



endclass