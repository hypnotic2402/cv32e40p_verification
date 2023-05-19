package pkg1;
`include "transaction.sv"
endpackage

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
            vif.data_gnt_i <= trans.data_gnt_i;
            vif.data_rvalid_i <= trans.data_rvalid_i;
            vif.data_rdata_i <= trans.data_rdata_i;
            vif.data_we_ex_i <= trans.data_we_ex_i;
            vif.data_type_ex_i <= trans.data_type_ex_i;
            vif.data_wdata_ex_i <= trans.data_wdata_ex_i;
            vif.data_reg_offset_ex_i <= trans.data_reg_offset_ex_i;
            vif.data_load_event_ex_i <= trans.data_load_event_ex_i;
            vif.data_sign_ext_ex_i <= trans.data_sign_ext_ex_i;
            vif.data_req_ex_i <= trans.data_req_ex_i;
            vif.operand_a_ex_i <= trans.operand_a_ex_i;
            vif.operand_b_ex_i <= trans.operand_b_ex_i;
            vif.addr_useincr_ex_i <= trans.addr_useincr_ex_i;
            vif.data_misaligned_ex_i <= trans.data_misaligned_ex_i;
            vif.data_atop_ex_i <= trans.data_atop_ex_i;

            //vif.enable_i <= trans.enable_i;
            //vif.vector_mode_i <= trans.vector_mode_i;
            //vif.bmask_a_i <= trans.bmask_a_i;
            //vif.bmask_b_i <= trans.bmask_b_i;
            //vif.imm_vec_ext_i <= trans.imm_vec_ext_i;
            //vif.is_clpx_i <= trans.is_clpx_i;
            //vif.is_subrot_i <= trans.is_subrot_i;
            //vif.ex_ready_i <= trans.ex_ready_i;
            //vif.clpx_shift_i <= trans.clpx_shift_i;
            //vif.operator_i <= trans.operator_i;
          	//vif.rst_n <= trans.rst_n;
            
            @(posedge vif.clk);
//             trans.display("Driver :  ");
            numTransactions++;


        end
    endtask

endclass