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
            trans.clk = vif.clk;
            trans.rst_n = vif.rst_n;
            trans.req_i = vif.req_i;
            trans.branch_i = vif.branch_i;
            trans.branch_addr_i = vif.branch_addr_i;
            trans.hwlp_jump_i = vif.hwlp_jump_i;
            trans.hwlp_target_i = vif.hwlp_target_i;
            trans.fetch_ready_i = vif.fetch_ready_i;
            trans.instr_gnt_i = vif.instr_gnt_i;
            trans.instr_rdata_i = vif.instr_rdata_i;
            trans.instr_rdata_i = vif.instr_rdata_i;
            trans.instr_err_i = vif.instr_err_i;
            trans.instr_err_pmp_i = vif.instr_err_pmp_i;
                
            trans.fetch_valid_o = vif.fetch_valid_o;
            trans.fetch_rdata_o = vif.fetch_rdata_o;
            trans.instr_req_o = vif.instr_req_o;
            trans.instr_addr_o = vif.instr_addr_o;
            trans.busy_o = vif.busy_o;
            

            @(posedge vif.clk);
            mon2scb.put(trans);
//             trans.display("Monitor : ");

        end

    endtask


endclass