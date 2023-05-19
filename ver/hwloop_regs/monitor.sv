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
                trans.hwlp_start_data_i = vif.hwlp_start_data_i;
                trans.hwlp_end_data_i = vif.hwlp_end_data_i;
                trans.hwlp_cnt_data_i = vif.hwlp_cnt_data_i;
                trans.hwlp_we_i = vif.hwlp_we_i;
                trans.hwlp_regid_i  = vif.hwlp_regid_i ;
                trans.valid_i = vif.valid_i;
                trans.hwlp_dec_cnt_i  = vif.hwlp_dec_cnt_i ;
                trans.hwlp_start_addr_o = vif.hwlp_start_addr_o;
                trans.hwlp_end_addr_o = vif.hwlp_end_addr_o;
                trans.hwlp_counter_o = vif.hwlp_counter_o;


            @(posedge vif.clk);
            mon2scb.put(trans);
//             trans.display("Monitor : ");

        end

    endtask


endclass