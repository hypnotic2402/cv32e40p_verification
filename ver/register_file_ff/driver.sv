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
            vif.rst_n <= trans.rst_n;
            vif.scan_cg_en_i <= trans.scan_cg_en_i;
            vif.raddr_a_i <= trans.raddr_a_i;
            vif.raddr_b_i <= trans.raddr_b_i;
            vif.raddr_c_i <= trans.raddr_c_i;           
            vif.waddr_a_i <= trans.waddr_a_i;
            vif.wdata_a_i <= trans.wdata_a_i;
            vif.we_a_i <= trans.we_a_i;
            vif.waddr_b_i <= trans.waddr_b_i;
            vif.wdata_b_i <= trans.wdata_b_i;
            vif.we_b_i <= trans.we_b_i;
            
            
            
            @(posedge vif.clk);
//             trans.display("Driver :  ");
            numTransactions++;


        end
    endtask

endclass