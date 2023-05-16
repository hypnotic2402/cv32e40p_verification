// package p2;
// `include "opcode.sv"
// endpackage


class transaction;

    // Defining IO's of AL
    rand bit clk,
    rand bit rst_n,

    rand bit        req_i,
    rand bit        branch_i,
    rand bit [31:0] branch_addr_i,

    rand bit        hwlp_jump_i,
    rand bit [31:0] hwlp_target_i,

    rand bit        fetch_ready_i,
    bit        fetch_valid_o,
    bit [31:0] fetch_rdata_o,

    // goes to instruction memory / instruction cache
    bit        instr_req_o,
    rand bit        instr_gnt_i,
    bit [31:0] instr_addr_o,
    rand bit [31:0] instr_rdata_i,
    rand bit        instr_rvalid_i,
    rand bit        instr_err_i,  // Not used yet (future addition)
    rand bit        instr_err_pmp_i,  // Not used yet (future addition)

    // Prefetch Buffer Status
    bit busy_o


    // Constraints to be added
//   constraint resetOff {rst_n == 1;};
//   constraint and_en {operator_i inside {7'b0010101 , 7'b0101110 , 7'b0101111};};
//     constraint or_en {operator_i in {7'b0101110}};
//     constraint xor_en {operator_i in {7'b0101111}};

    // Coverage Metrics

    covergroup cg;

        option.per_instance = 1;
        coverpoint in_i;
        


    endgroup

    function new();
        cg = new;
    endfunction

    function void display(string name);

        $display("time = %0d , %s , in_i = %0b " , $time , name , in_i);

    endfunction



endclass