// package p2;
// `include "opcode.sv"
// endpackage


class transaction;

    // Defining IO's of AL
    rand bit [31:0] instr_i,
    bit [31:0] instr_o,
    bit        is_compressed_o,
    bit        illegal_instr_o
    


    // Constraints to be added
//   constraint resetOff {rst_n == 1;};
//   constraint and_en {operator_i inside {7'b0010101 , 7'b0101110 , 7'b0101111};};
//     constraint or_en {operator_i in {7'b0101110}};
//     constraint xor_en {operator_i in {7'b0101111}};

    // Coverage Metrics

    covergroup cg;

        option.per_instance = 1;
        coverpoint instr_i;
        


    endgroup

    function new();
        cg = new;
    endfunction

    // function void display(string name);

    //     $display("time = %0d , %s , in_i = %0b " , $time , name , in_i);

    // endfunction



endclass