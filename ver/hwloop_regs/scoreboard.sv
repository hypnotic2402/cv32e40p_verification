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
        int unsigned i = 0;
        forever begin

            mon2scb.get(trans);

            // write logic here
         
            /////////////////////////////////////////////////////////////////////////////////
            // HWLOOP start-address register                                               //
            /////////////////////////////////////////////////////////////////////////////////
            
            if (trans.rst_n == 1'b0) begin
                if(trans.hwlp_start_addr_o != '{default: 32'b0}) begin
                    $display("time = %0d, SCOREBOARD : Error in RESET test case 1 operation when reset" , $time);
                end
                else if (trans.hwlp_we_i[0] == 1'b1) begin
                    if(trans.hwlp_start_addr_o[trans.hwlp_regid_i] != trans.hwlp_start_data_i) begin
                        $display("time = %0d, SCOREBOARD : Error in test case 2 operation" , $time);
                    end
                end
            end


        /////////////////////////////////////////////////////////////////////////////////
        // HWLOOP end-address register                                                 //
        /////////////////////////////////////////////////////////////////////////////////
        
            if (trans.rst_n == 1'b0) begin
                if(trans.hwlp_end_addr_o != '{default: 32'b0}) begin
                    $display("time = %0d, SCOREBOARD : Error in RESET test case 2 operation when reset" , $time);
                end 
                else if (trans.hwlp_we_i[1] == 1'b1) begin
                    if(trans.hwlp_end_addr_o[trans.hwlp_regid_i] != trans.hwlp_end_data_i) begin
                        $display("time = %0d, SCOREBOARD : Error in test case 3 operation" , $time);
                    end
                end
            end


        /////////////////////////////////////////////////////////////////////////////////
        // HWLOOP counter register with decrement logic                                //
        /////////////////////////////////////////////////////////////////////////////////
        
            if (trans.rst_n == 1'b0) begin
                if(trans.hwlp_counter_o != '{default: 32'b0}) begin
                    $display("time = %0d, SCOREBOARD : Error in RESET test case 3 operation when reset" , $time);
                end
                else 
                begin
                    for (i = 0; i < 2; i++) begin
                        if ((trans.hwlp_we_i[2] == 1'b1) && (i == trans.hwlp_regid_i)) 
                        begin
                            if(trans.hwlp_counter_o[i] != trans.hwlp_cnt_data_i) begin
                                $display("time = %0d, SCOREBOARD : Error in CNT test case 1 operation" , $time);
                            end
                        end 
                        // else 
                        // begin
                        // if (trans.hwlp_dec_cnt_i[i] && trans.valid_i) hwlp_counter_q[i] <= hwlp_counter_n[i];
                        // end
                    end
                end
            end

        numTransactions++;

        end

    endtask

endclass