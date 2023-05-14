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

           
          
			flag = 0;
          for (int i = 0 ; i < 32 ; i++) begin
            if (trans.in_i[i] == 1) begin
              flag++;
//               break;
            end
          end
//           $display("time = %0d, SCOREBOARD : CORRECT - Output = %0d   , Input = %0b" , $time , trans.result_o , trans.in_i);

          if (flag == trans.result_o) begin
          
            $display("time = %0d, SCOREBOARD : CORRECT - Output = %0d   , Input = %0b" , $time , trans.result_o , trans.in_i);
          end
              
          else begin
            $display("time = %0d, SCOREBOARD : WRONG - Output = %0d   , Input = %0b" , $time , trans.result_o , trans.in_i);
          end
          

            numTransactions++;

        end

    endtask


endclass