// package p2;
// `include "opcode.sv"
// endpackage


class transaction;

    rand bit rst_n;

    // Used to calculate the exception offsets
    rand bit [23:0] m_trap_base_addr_i;
    rand bit [23:0] u_trap_base_addr_i;
    rand bit [ 1:0] trap_addr_mux_i;
    // Boot address
    rand bit [31:0] boot_addr_i;
    rand bit [31:0] dm_exception_addr_i;

    // Debug mode halt address
    rand bit [31:0] dm_halt_addr_i;

    // instruction request control
    rand bit req_i;

    // instruction cache interface
    bit instr_req_o;
    bit [31:0] instr_addr_o;
    rand bit instr_gnt_i;
    rand bit instr_rvalid_i;
    rand bit [31:0] instr_rdata_i;
    rand bit                   instr_err_i;      // External bus error (validity defined by instr_rvalid_i) (not used yet)
    rand bit instr_err_pmp_i;  // PMP error (validity defined by instr_gnt_i)

    // Output of IF Pipeline stage
    bit instr_valid_id_o;  // instruction in IF/ID pipeline is valid
    bit       [31:0] instr_rdata_id_o;      // read instruction is sampled and sent to ID stage for decoding
    bit is_compressed_id_o;  // compressed decoder thinks this is a compressed instruction
    bit illegal_c_insn_id_o;  // compressed decoder thinks this is an invalid instruction
    bit [31:0] pc_if_o;
    bit [31:0] pc_id_o;
    bit is_fetch_failed_o;

    // Forwarding ports - control signals
    rand bit clear_instr_valid_i;  // clear instruction valid bit in IF/ID pipe
    rand bit pc_set_i;  // set the program counter to a new value
    rand bit [31:0] mepc_i;  // address used to restore PC when the interrupt/exception is served
    rand bit [31:0] uepc_i;  // address used to restore PC when the interrupt/exception is served

    rand bit [31:0] depc_i;  // address used to restore PC when the debug is served

    rand bit [3:0] pc_mux_i;  // sel for pc multiplexer
    rand bit [2:0] exc_pc_mux_i;  // selects ISR address

    rand bit [4:0] m_exc_vec_pc_mux_i;  // selects ISR address for vectorized interrupt lines
    rand bit [4:0] u_exc_vec_pc_mux_i;  // selects ISR address for vectorized interrupt lines
    bit       csr_mtvec_init_o;  // tell CS regfile to init mtvec

    // jump and branch target and decision
    rand bit [31:0] jump_target_id_i;  // jump target address
    rand bit [31:0] jump_target_ex_i;  // jump target address

    // from hwloop controller
    rand bit        hwlp_jump_i;
    rand bit [31:0] hwlp_target_i;

    // pipeline stall
    rand bit halt_if_i;
    rand bit id_ready_i;

    // misc signals
    bit if_busy_o;  // is the IF stage busy fetching instructions?
    bit perf_imiss_o;  // Instruction Fetch Miss


    // Constraints to be added
//   constraint resetOff {rst_n == 1;};
//   constraint and_en {operator_i inside {7'b0010101 , 7'b0101110 , 7'b0101111};};
//     constraint or_en {operator_i in {7'b0101110}};
//     constraint xor_en {operator_i in {7'b0101111}};

    // Coverage Metrics

    covergroup cg;

        option.per_instance = 1;

        coverpoint rst_n;
        coverpoint m_trap_base_addr_i;
        coverpoint u_trap_base_addr_i;
        coverpoint trap_addr_mux_i;
        coverpoint boot_addr_i;
        coverpoint dm_exception_addr_i;
        coverpoint dm_halt_addr_i;
        coverpoint req_i;
        coverpoint instr_gnt_i;
        coverpoint instr_rvalid_i;
        coverpoint instr_rdata_i;
        coverpoint instr_err_i;
        coverpoint instr_err_pmp_i;
        coverpoint clear_instr_valid_i;  // clear instruction valid bit in IF/ID pipe
        coverpoint pc_set_i;  // set the program counter to a new value
        coverpoint mepc_i;  // address used to restore PC when the interrupt/exception is served
        coverpoint uepc_i;  // address used to restore PC when the interrupt/exception is served
        coverpoint depc_i;  // address used to restore PC when the debug is served
        coverpoint pc_mux_i;  // sel for pc multiplexer
        coverpoint exc_pc_mux_i;  // selects ISR address
        coverpoint m_exc_vec_pc_mux_i;  // selects ISR address for vectorized interrupt lines
        coverpoint u_exc_vec_pc_mux_i;  // selects ISR address for vectorized interrupt lines
        coverpoint jump_target_id_i;  // jump target address
        coverpoint jump_target_ex_i;  // jump target address
        coverpoint hwlp_jump_i;
        coverpoint hwlp_target_i;
        coverpoint halt_if_i;
        coverpoint id_ready_i;
        


    endgroup

    function new();
        cg = new;
    endfunction

    // function void display(string name);

    //     $display("time = %0d , %s , in_i = %0b " , $time , name , in_i);

    // endfunction



endclass