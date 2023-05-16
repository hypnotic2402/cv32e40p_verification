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
                trans.rst_n = vif.rst_n; //1 bit

                trans.scan_cg_en_i = vif.scan_cg_en_i; //1 bit

                //Read port R1
                trans.raddr_a_i = vif.raddr_a_i; //31 bits
                trans.rdata_a_o = vif.rdata_a_o; //5 bits

                //Read port R2
                trans.raddr_b_i = vif.raddr_b_i; //31 bits
                trans.rdata_b_o = vif.rdata_b_o; //5 bits


                //Read port R3
                trans.raddr_c_i = vif.raddr_c_i; //31 bits
                trans.rdata_c_o = vif.rdata_c_o; //5 bits


                // Write port W1
                trans.waddr_a_i = vif.waddr_a_i; //31 bits
                trans.wdata_a_i = vif.wdata_a_i; //5 bits
                trans.we_a_i = vif.we_a_i; //1 bit

                // Write port W2
                trans.waddr_b_i = vif.waddr_b_i; //31 bits
                trans.wdata_b_i = vif.wdata_b_i; //5 bits
                trans.we_b_i = vif.we_b_i; //1 bit

            @(posedge vif.clk);
            mon2scb.put(trans);
//             trans.display("Monitor : ");

        end

    endtask


endclass