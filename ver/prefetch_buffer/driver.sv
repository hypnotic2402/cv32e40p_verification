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
            vif.req_i <= trans.req_i;
            vif.branch_i <= trans.branch_i;
            vif.branch_addr_i <= trans.branch_addr_i;
            vif.hwlp_jump_i <= trans.hwlp_jump_i;
            vif.hwlp_target_i <= trans.hwlp_target_i;
            vif.fetch_ready_i <= trans.fetch_ready_i;
            vif.instr_gnt_i; <= trans.instr_gnt_i;
            vif.instr_rdata_i <= trans.instr_rdata_i;
            vif.instr_rdata_i <= trans.instr_rdata_i;
            vif.instr_err_i <= trans.instr_err_i;
            vif.instr_err_pmp_i <= trans.instr_err_pmp_i;
            
            @(posedge vif.clk);
//             trans.display("Driver :  ");
            numTransactions++;


        end
    endtask

endclass