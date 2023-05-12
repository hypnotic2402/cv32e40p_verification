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
          if (trans.operator_i == 7'b0010101)
            begin
                
                if (trans.result_o != trans.operand_a_i & trans.operand_b_i)
                begin
                    $display("time = %0d, SCOREBOARD : Error in AND operation" , $time);
                end

                else
                    $display("time = %0d, SCOREBOARD : correct result in AND operation" , $time);

            end

            // Checking OR operation
          if (trans.operator_i == 0101110)
            begin
                
                if (trans.result_o != trans.operand_a_i | trans.operand_b_i)
                begin
                    $display("time = %0d, SCOREBOARD : Error in OR operation" , $time);
                end

                else
                    $display("time = %0d, SCOREBOARD : correct result in OR operation" , $time);

            end

            // Checking XOR operation
          if (trans.operator_i == 0101111)
            begin
                
                if (trans.result_o != trans.operand_a_i ^ trans.operand_b_i)
                begin
                    $display("time = %0d, SCOREBOARD : Error in XOR operation" , $time);
                end

                else
                    $display("time = %0d, SCOREBOARD : correct result in XOR operation" , $time);

            end

            numTransactions++;

        end

    endtask


endclass