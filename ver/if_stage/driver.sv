// package pkg1;
// `include "transaction.sv"
// endpackage

import pkg1::*;

class driver;

    int numTransactions;
    virtual intf vif;
    mailbox gen2driv;
    transaction trans;

    //constructor

    function new(virtual intf vif , mailbox gen2driv);
        this.vif = vif;
        this.gen2driv = gen2driv;
    endfunction

    task main;

        forever begin

            gen2driv.get(trans);

            @(posedge vif.clk);
            vif.rst_n <= trans.rst_n;
            vif.m_trap_base_addr_i <= trans.m_trap_base_addr_i;
            vif.u_trap_base_addr_i <= trans.u_trap_base_addr_i;
            vif.trap_addr_mux_i <= trans.trap_addr_mux_i;
            vif.boot_addr_i <= trans.boot_addr_i;
            vif.dm_exception_addr_i <= trans.dm_exception_addr_i;
            vif.dm_halt_addr_i <= trans.dm_halt_addr_i;
            vif.req_i <= trans.req_i;
            vif.instr_gnt_i <= trans.instr_gnt_i;
            vif.instr_rvalid_i <= trans.instr_rvalid_i;
            vif.instr_rdata_i <= trans.instr_rdata_i;
            vif.instr_err_i <= trans.instr_err_i;
            vif.instr_err_pmp_i <= trans.instr_err_pmp_i;
            vif.clear_instr_valid_i <= trans.clear_instr_valid_i;  // clear instruction valid bit in IF/ID pipe
            vif.pc_set_i <= trans.pc_set_i;  // set the program counter to a new value
            vif.mepc_i <= trans.mepc_i;  // address used to restore PC when the interrupt/exception is served
            vif.uepc_i <= trans.uepc_i;  // address used to restore PC when the interrupt/exception is served
            vif.depc_i <= trans.depc_i;  // address used to restore PC when the debug is served
            vif.pc_mux_i <= trans.pc_mux_i;  // sel for pc multiplexer
            vif.exc_pc_mux_i <= trans.exc_pc_mux_i;  // selects ISR address
            vif.m_exc_vec_pc_mux_i <= trans.m_exc_vec_pc_mux_i;  // selects ISR address for vectorized interrupt lines
            vif.u_exc_vec_pc_mux_i <= trans.u_exc_vec_pc_mux_i;  // selects ISR address for vectorized interrupt lines
            vif.jump_target_id_i <= trans.jump_target_id_i;  // jump target address
            vif.jump_target_ex_i <= trans.jump_target_ex_i;  // jump target address
            vif.hwlp_jump_i <= trans.hwlp_jump_i;
            vif.hwlp_target_i <= trans.hwlp_target_i;
            vif.halt_if_i <= trans.halt_if_i;
            vif.id_ready_i <= trans.id_ready_i;
            
            @(posedge vif.clk);
//             trans.display("Driver :  ");
            numTransactions++;


        end
    endtask

endclass