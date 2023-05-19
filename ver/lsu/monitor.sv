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
                trans.data_gnt_i = vif.data_gnt_i;
                trans.data_rvalid_i = vif.data_rvalid_i;
                trans.data_rdata_i = vif.data_rdata_i;
                trans.data_we_ex_i = vif.data_we_ex_i;
                trans.data_type_ex_i = vif.data_type_ex_i;
                trans.data_wdata_ex_i = vif.data_wdata_ex_i;
                trans.data_reg_offset_ex_i = vif.data_reg_offset_ex_i;
                trans.data_load_event_ex_i = vif.data_load_event_ex_i;
                trans.data_sign_ext_ex_i = vif.data_sign_ext_ex_i;
                trans.data_req_ex_i = vif.data_req_ex_i;
                trans.operand_a_ex_i = vif.operand_a_ex_i;
                trans.operand_b_ex_i = vif.operand_b_ex_i;
                trans.addr_useincr_ex_i = vif.addr_useincr_ex_i;
                trans.data_misaligned_ex_i = vif.data_misaligned_ex_i;
                trans.data_atop_ex_i = vif.data_atop_ex_i;
                
            trans.data_req_o = vif.data_req_o;
            trans.data_wdata_o = vif.data_wdata_o;
            trans.data_we_o = vif.data_we_o;
            trans.data_be_o = vif.data_be_o;
            trans.data_addr_o = vif.data_addr_o;
            trans.data_rdata_ex_o = vif.data_rdata_ex_o;
            trans.data_misaligned_o = vif.data_misaligned_o;
            trans.data_atop_o = vif.data_atop_o;
            trans.lsu_ready_ex_o = vif.lsu_ready_ex_o;
            trans.lsu_ready_wb_o = vif.lsu_ready_wb_o;
            trans.busy_o = vif.busy_o;

            $display("time = %0d , data_req_o = %0h , data_addr_o = %0h , data_wdata_o = %0h" , $time , trans.data_req_o , trans.data_addr_o , trans.data_wdata_o);
            $display("time = %0d , data_we_o = %0h , data_be_o = %0h " , $time , trans.data_we_o , trans.data_be_o);

            @(posedge vif.clk);
            mon2scb.put(trans);
//             trans.display("Monitor : ");

        end

    endtask


endclass