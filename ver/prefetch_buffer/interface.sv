package pkg1;
`include "transaction.sv"
// `include "opcode.sv"
endpackage

// import pkg1::*;
// `include "opcode.sv"
// `include "transaction.sv"

interface intf( logic clk);

     logic rst_n,

     logic        req_i,
     logic        branch_i,
     logic [31:0] branch_addr_i,

     logic        hwlp_jump_i,
     logic [31:0] hwlp_target_i,

      logic        fetch_ready_i,
     logic        fetch_valid_o,
     logic [31:0] fetch_rdata_o,

    // goes to instruction memory / instruction cache
     logic        instr_req_o,
      logic        instr_gnt_i,
     logic [31:0] instr_addr_o,
      logic [31:0] instr_rdata_i,
      logic        instr_rvalid_i,
      logic        instr_err_i,  // Not used yet (future addition)
      logic        instr_err_pmp_i,  // Not used yet (future addition)

    // Prefetch Buffer Status
     logic busy_o
    
endinterface