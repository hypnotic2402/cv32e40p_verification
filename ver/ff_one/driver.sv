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
            vif.in_i <= trans.in_i;
            
            
            @(posedge vif.clk);
//             trans.display("Driver :  ");
            numTransactions++;


        end
    endtask

endclass