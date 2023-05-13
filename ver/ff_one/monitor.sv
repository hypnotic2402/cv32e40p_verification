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
                trans.in_i = vif.in_i;
                
            trans.first_one_o = vif.first_one_o;
            trans.cno_ones_o = vif.cno_ones_o;
            

            @(posedge vif.clk);
            mon2scb.put(trans);
//             trans.display("Monitor : ");

        end

    endtask


endclass