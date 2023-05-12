package pkg1;
`include "transaction.sv"
endpackage

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
                trans.operand_a_i = vif.operand_a_i;
                trans.operand_b_i = vif.operand_b_i;
                trans.operand_c_i = vif.operand_c_i;
                trans.enable_i = vif.enable_i;
                trans.vector_mode_i = vif.vector_mode_i;
                trans.bmask_a_i = vif.bmask_a_i;
                trans.bmask_b_i = vif.bmask_b_i;
                trans.imm_vec_ext_i = vif.imm_vec_ext_i;
                trans.is_clpx_i = vif.is_clpx_i;
                trans.is_subrot_i = vif.is_subrot_i;
                trans.ex_ready_i = vif.ex_ready_i;
                trans.clpx_shift_i = vif.clpx_shift_i;
                trans.operator_i = vif.operator_i;
            trans.result_o = vif.result_o;
            trans.comparison_result_o = vif.comparison_result_o;
            trans.ready_o = vif.ready_o;

            @(posedge vif.clk);
            mon2scb.put(trans);
            trans.display("Monitor : ");

        end

    endtask


endclass