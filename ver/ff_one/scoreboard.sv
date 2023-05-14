// package pkg1;
// `include "transaction.sv"
// endpackage

import pkg1::*;

class scoreboard;

    mailbox mon2scb;
    int numTransactions;
    transaction trans;
  	int flag;

    // Constructor
    function new(mailbox mon2scb);
        this.mon2scb = mon2scb;
    endfunction

    task main;

        forever begin

            mon2scb.get(trans);

            // Chekcing AND operation
          
			flag = 0;
          for (int i = 0 ; i < trans.first_one_o ; i++) begin
            if (trans.in_i[i] == 1) begin
              flag = 1;
              break;
            end
          end
          
          if ((flag == 0) && (trans.in_i[trans.first_one_o] == 1)) begin
          
            $display("time = %0d, SCOREBOARD : CORRECT - No Ones = %0b , First One = %0d , Input = %0b" , $time , trans.cno_ones_o , trans.first_one_o , trans.in_i);
          end
              
          else begin
            $display("time = %0d, SCOREBOARD : WRONG - No Ones = %0b , First One = %0d , Input = %0b" , $time , trans.cno_ones_o , trans.first_one_o , trans.in_i);
          end
          

            numTransactions++;

        end

    endtask


endclass