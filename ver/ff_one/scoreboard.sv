// package pkg1;
// `include "transaction.sv"
// endpackage

import pkg1::*;

class scoreboard;

    mailbox mon2scb;
    int numTransactions;
    transaction trans;

    // Constructor
    function new(mailbox mon2scb);
        this.mon2scb = mon2scb;
    endfunction

    task main;

        forever begin

            mon2scb.get(trans);

            // Chekcing AND operation
          

            $display("time = %0d, SCOREBOARD : No Ones = %0b , First One = %0d , Input = %0b" , $time , trans.cno_ones_o , trans.first_one_o , trans.in_i);

          

            numTransactions++;

        end

    endtask


endclass