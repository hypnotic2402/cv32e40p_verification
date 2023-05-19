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
            trans.instr_i = vif.instr_i;
            trans.instr_o = vif.instr_o;
            trans.is_compressed_o = vif.is_compressed_o;
            trans.illegal_instr_o = vif.illegal_instr_o;
            

            @(posedge vif.clk);
            mon2scb.put(trans);
//             trans.display("Monitor : ");

        end

    endtask


endclass