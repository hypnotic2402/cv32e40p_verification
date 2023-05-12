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
            vif.operand_a_i <= trans.operand_a_i;
            vif.operand_b_i <= trans.operand_b_i;
            vif.operand_c_i <= trans.operand_c_i;
            vif.enable_i <= trans.enable_i;
            vif.vector_mode_i <= trans.vector_mode_i;
            vif.bmask_a_i <= trans.bmask_a_i;
            vif.bmask_b_i <= trans.bmask_b_i;
            vif.imm_vec_ext_i <= trans.imm_vec_ext_i;
            vif.is_clpx_i <= trans.is_clpx_i;
            vif.is_subrot_i <= trans.is_subrot_i;
            vif.ex_ready_i <= trans.ex_ready_i;
            vif.clpx_shift_i <= trans.clpx_shift_i;
            vif.operator_i <= trans.operator_i;
          	vif.rst_n <= trans.rst_n;
            
            @(posedge vif.clk);
//             trans.display("Driver :  ");
            numTransactions++;


        end
    endtask

endclass