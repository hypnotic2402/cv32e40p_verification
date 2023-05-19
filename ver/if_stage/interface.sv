package pkg1;
`include "transaction.sv"
// `include "opcode.sv"
endpackage

// import pkg1::*;
// `include "opcode.sv"
// `include "transaction.sv"

interface intf(input logic clk);

    logic rst_n;

    // Used to calculate the exception offsets
    logic [23:0] m_trap_base_addr_i;
    logic [23:0] u_trap_base_addr_i;
    logic [ 1:0] trap_addr_mux_i;
    // Boot address
    logic [31:0] boot_addr_i;
    logic [31:0] dm_exception_addr_i;

    // Debug mode halt address
    logic [31:0] dm_halt_addr_i;

    // instruction request control
    logic req_i;

    // instruction cache interface
    logic instr_req_o;
    logic [31:0] instr_addr_o;
    logic instr_gnt_i;
    logic instr_rvalid_i;
    logic [31:0] instr_rdata_i;
    logic                   instr_err_i;      // External bus error (validity defined by instr_rvalid_i) (not used yet)
    logic instr_err_pmp_i;  // PMP error (validity defined by instr_gnt_i)

    // Output of IF Pipeline stage
    logic instr_valid_id_o;  // instruction in IF/ID pipeline is valid
    logic       [31:0] instr_rdata_id_o;      // read instruction is sampled and sent to ID stage for decoding
    logic is_compressed_id_o;  // compressed decoder thinks this is a compressed instruction
    logic illegal_c_insn_id_o;  // compressed decoder thinks this is an invalid instruction
    logic [31:0] pc_if_o;
    logic [31:0] pc_id_o;
    logic is_fetch_failed_o;

    // Forwarding ports - control signals
    logic clear_instr_valid_i;  // clear instruction valid bit in IF/ID pipe
    logic pc_set_i;  // set the program counter to a new value
    logic [31:0] mepc_i;  // address used to restore PC when the interrupt/exception is served
    logic [31:0] uepc_i;  // address used to restore PC when the interrupt/exception is served

    logic [31:0] depc_i;  // address used to restore PC when the debug is served

    logic [3:0] pc_mux_i;  // sel for pc multiplexer
    logic [2:0] exc_pc_mux_i;  // selects ISR address

    logic [4:0] m_exc_vec_pc_mux_i;  // selects ISR address for vectorized interrupt lines
    logic [4:0] u_exc_vec_pc_mux_i;  // selects ISR address for vectorized interrupt lines
    logic       csr_mtvec_init_o;  // tell CS regfile to init mtvec

    // jump and branch target and decision
    logic [31:0] jump_target_id_i;  // jump target address
    logic [31:0] jump_target_ex_i;  // jump target address

    // from hwloop controller
    logic        hwlp_jump_i;
    logic [31:0] hwlp_target_i;

    // pipeline stall
    logic halt_if_i;
    logic id_ready_i;

    // misc signals
    logic if_busy_o;  // is the IF stage busy fetching instructions?
    logic perf_imiss_o;  // Instruction Fetch Miss
    
endinterface