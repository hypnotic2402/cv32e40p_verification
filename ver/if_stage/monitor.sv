// package pkg1;
// `include "transaction.sv"
// endpackage

import pkg1::*;

class monitor;

    virtual intf vif;
    mailbox mon2scb;
    transaction trans;

    // Constructor
    function new(virtual intf vif , mailbox mon2scb);
        this.vif = vif;
        this.mon2scb = mon2scb;
        trans = new;
    endfunction

    task main;

        forever begin

            repeat(2)@(posedge vif.clk);
            trans.rst_n = vif.rst_n;
            trans.m_trap_base_addr_i = vif.m_trap_base_addr_i;
            trans.u_trap_base_addr_i = vif.u_trap_base_addr_i;
            trans.trap_addr_mux_i = vif.trap_addr_mux_i;
            trans.boot_addr_i = vif.boot_addr_i;
            trans.dm_exception_addr_i = vif.dm_exception_addr_i;
            trans.dm_halt_addr_i = vif.dm_halt_addr_i;
            trans.req_i = vif.req_i;
            trans.instr_gnt_i = vif.instr_gnt_i;
            trans.instr_rvalid_i = vif.instr_rvalid_i;
            trans.instr_rdata_i = vif.instr_rdata_i;
            trans.instr_err_i = vif.instr_err_i;
            trans.instr_err_pmp_i = vif.instr_err_pmp_i;
            trans.clear_instr_valid_i = vif.clear_instr_valid_i;  // clear instruction valid bit in IF/ID pipe
            trans.pc_set_i = vif.pc_set_i;  // set the program counter to a new value
            trans.mepc_i = vif.mepc_i;  // address used to restore PC when the interrupt/exception is served
            trans.uepc_i = vif.uepc_i;  // address used to restore PC when the interrupt/exception is served
            trans.depc_i = vif.depc_i;  // address used to restore PC when the debug is served
            trans.pc_mux_i = vif.pc_mux_i;  // sel for pc multiplexer
            trans.exc_pc_mux_i = vif.exc_pc_mux_i;  // selects ISR address
            trans.m_exc_vec_pc_mux_i = vif.m_exc_vec_pc_mux_i;  // selects ISR address for vectorized interrupt lines
            trans.u_exc_vec_pc_mux_i = vif.u_exc_vec_pc_mux_i;  // selects ISR address for vectorized interrupt lines
            trans.jump_target_id_i = vif.jump_target_id_i;  // jump target address
            trans.jump_target_ex_i = vif.jump_target_ex_i;  // jump target address
            trans.hwlp_jump_i = vif.hwlp_jump_i;
            trans.hwlp_target_i = vif.hwlp_target_i;
            trans.halt_if_i = vif.halt_if_i;
            trans.id_ready_i = vif.id_ready_i;
                
            trans.instr_req_o = vif.i_intf.instr_req_o;
            trans.instr_addr_o = vif.i_intf.instr_addr_o;
            trans.instr_valid_id_o = vif.i_intf.instr_valid_id_o;
            trans.instr_rdata_id_o = vif.i_intf.instr_rdata_id_o;
            trans.is_compressed_id_o = vif.i_intf.is_compressed_id_o;
            trans.illegal_c_insn_id_o = vif.i_intf.illegal_c_insn_id_o;
            trans.pc_if_o = vif.i_intf.pc_if_o;
            trans.pc_id_o = vif.i_intf.pc_id_o;
            trans.is_fetch_failed_o = vif.i_intf.is_fetch_failed_o;
            trans.csr_mtvec_init_o = vif.i_intf.csr_mtvec_init_o;
            trans.if_busy_o = vif.i_intf.if_busy_o;
            trans.perf_imiss_o = vif.i_intf.perf_imiss_o;
            

            @(posedge vif.clk);
            mon2scb.put(trans);
//             trans.display("Monitor : ");

        end

    endtask


endclass