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
            vif.instr_i <= trans.instr_i;
            // vif.instr_o <= trans.instr_o;
            // vif.is_compressed_o <= trans.is_compressed_o;
            // vif.illegal_instr_o <= trans.illegal_instr_;
            
            @(posedge vif.clk);
//             trans.display("Driver :  ");
            numTransactions++;


        end
    endtask

endclass