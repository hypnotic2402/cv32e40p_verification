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

            if(trans.req_i == 0 && trans.rst_n == 0) begin
                if(trans.instr_req_o == 0) begin
                    $display("time = %0d, SCOREBOARD : CORRECT - Input = %0b %0b  , Output = %0b" , $time , trans.rst_n, trans.req_i, trans.instr_req_o);
                end
                else begin
                    $display("time = %0d, SCOREBOARD : WRONG - Input = %0b %0b  , Output = %0b" , $time , trans.rst_n, trans.req_i, trans.instr_req_o);
                end
            end

            if(trans.req_i == 1 && trans.rst_n == 0) begin
                if(trans.instr_req_o == 0) begin
                    $display("time = %0d, SCOREBOARD : CORRECT - Input = %0b %0b  , Output = %0b" , $time , trans.rst_n, trans.req_i, trans.instr_req_o);
                end
                else begin
                    $display("time = %0d, SCOREBOARD : WRONG - Input = %0b %0b  , Output = %0b" , $time , trans.rst_n, trans.req_i, trans.instr_req_o);
                end
            end

            if(trans.rst_n == 1'b0) begin
                if(trans.instr_valid_id_o == 1'b0 && trans.instr_rdata_id_o == '0 && trans.is_fetch_failed_o == 1'b0 && trans.pc_id_o == '0 && trans.is_compressed_id_o == 1'b0 && trans.illegal_c_insn_id_o == 1'b0) begin
                    $display("time = %0d, SCOREBOARD : CORRECT - Input = %0d   , Output = %0b %0b %0b %0b %0b %0b" , $time , trans.rst_n, trans.instr_valid_id_o, trans.instr_rdata_id_o, trans.is_fetch_failed_o, trans.pc_id_o, trans.is_compressed_id_o, trans.illegal_c_insn_id_o);
                end
                else begin
                    $display("time = %0d, SCOREBOARD : WRONG - Input = %0d   , Output = %0b %0b %0b %0b %0b %0b" , $time , trans.rst_n, trans.instr_valid_id_o, trans.instr_rdata_id_o, trans.is_fetch_failed_o, trans.pc_id_o, trans.is_compressed_id_o, trans.illegal_c_insn_id_o);
                end
            end

            // if(trans.rst_n == 1'b1 && trans.if_valid == 1 && trans.instr_valid == 1) begin
            //     if(trans.instr_valid_id_o == 1'b1 && trans.instr_rdata_id_o == instr_decompressed && trans.is_compressed_id_o == instr_compressed_int && trans.illegal_c_insn_id_o == illegal_c_insn && trans.is_fetch_failed_o == 1'b0 && trans.pc_id_o == trans.pc_if_o) begin
            //         $display("time = %0d, SCOREBOARD : CORRECT - Input = %0d %0d   , Output = %0b %0b %0b %0b %0b %0b" , $time , trans.if_valid, trans.instr_valid, trans.instr_valid_id_o, trans.instr_rdata_id_o, trans.is_compressed_id_o, trans.illegal_c_insn_id_o, trans.is_fetch_failed_o, trans.pc_id_o);
            //     end

            //     else begin
            //         $display("time = %0d, SCOREBOARD : CORRECT - Input = %0d %0d   , Output = %0b %0b %0b %0b %0b %0b" , $time , trans.if_valid, trans.instr_valid, trans.instr_valid_id_o, trans.instr_rdata_id_o, trans.is_compressed_id_o, trans.illegal_c_insn_id_o, trans.is_fetch_failed_o, trans.pc_id_o);
            //     end
            // end
            numTransactions++;          
        end


    endtask


endclass