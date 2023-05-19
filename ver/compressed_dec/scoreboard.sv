// package pkg1;
// `include "transaction.sv"
// endpackage

import pkg1::*;

class scoreboard;

    mailbox mon2scb;
    int numTransactions;
    transaction trans;
    
    parameter OPCODE_OP = 7'h33;
    parameter OPCODE_OPIMM = 7'h13;
    parameter OPCODE_STORE = 7'h23;
    parameter OPCODE_LOAD = 7'h03;
    parameter OPCODE_BRANCH = 7'h63;
    parameter OPCODE_JAL = 7'h6f;
    parameter OPCODE_LUI = 7'h37;
    // Constructor
    function new(mailbox mon2scb);
        this.mon2scb = mon2scb;
    endfunction

    task main;

        forever begin

            mon2scb.get(trans);

           
          
			//The Following Scoreboard tests for FPU = 0
            if(trans.instr_i[1:0] == 2'b00) begin   //C0
              if (trans.instr_i[15:13] == 3'b000) begin
                if(trans.instr_o == {2'b0, trans.instr_i[10:7],trans.instr_i[12:11],trans.instr_i[5],trans.instr_i[6],2'b00,5'h02,3'b000,2'b01,trans.instr_i[4:2],OPCODE_OPIMM}) begin
                  $display("time = %0d, SCOREBOARD : CORRECT - Output = %0d   , Input = %0b" , $time , trans.instr_o , trans.instr_i);
                end
                else begin
                  $display("time = %0d, SCOREBOARD : WRONG - Output = %0d   , Input = %0b" , $time , trans.instr_o , trans.instr_i);
                end
                if (trans.instr_i[12:5] == 8'b0 && trans.illegal_instr_o == 1'b1) begin
                  $display("time = %0d, SCOREBOARD : CORRECT - Output = %0d   , Input = %0b" , $time , trans.illegal_instr_o , trans.instr_i);
                end
                else begin
                  $display("time = %0d, SCOREBOARD : WRONG - Output = %0d   , Input = %0b" , $time , trans.illegal_instr_o , trans.instr_i);
                end
              end

              if (trans.instr_i[15:13] == 3'b001) begin
                  if (trans.illegal_instr_o == 1'b1) begin
                    $display("time = %0d, SCOREBOARD : CORRECT - Output = %0d   , Input = %0b" , $time , trans.illegal_instr_o , trans.instr_i);
                  end
                  else begin
                    $display("time = %0d, SCOREBOARD : WRONG - Output = %0d   , Input = %0b" , $time , trans.illegal_instr_o , trans.instr_i);
                  end
              end

              if (trans.instr_i[15:13] == 3'b010) begin
                if(trans.instr_o == {5'b0, trans.instr_i[5], trans.instr_i[12:10], trans.instr_i[6], 2'b00, 2'b01, trans.instr_i[9:7], 3'b010, 2'b01, trans.instr_i[4:2], OPCODE_LOAD}) begin
                  $display("time = %0d, SCOREBOARD : CORRECT - Output = %0d   , Input = %0b" , $time , trans.instr_o , trans.instr_i);
                end
                else begin
                  $display("time = %0d, SCOREBOARD : WRONG - Output = %0d   , Input = %0b" , $time , trans.instr_o , trans.instr_i);
                end
              end

              if (trans.instr_i[15:13] == 3'b011) begin
                  if (trans.illegal_instr_o == 1'b1) begin
                    $display("time = %0d, SCOREBOARD : CORRECT - Output = %0d   , Input = %0b" , $time , trans.illegal_instr_o , trans.instr_i);
                  end
                  else begin
                    $display("time = %0d, SCOREBOARD : WRONG - Output = %0d   , Input = %0b" , $time , trans.illegal_instr_o , trans.instr_i);
                  end
              end

              if (trans.instr_i[15:13] == 3'b101) begin
                  if (trans.illegal_instr_o == 1'b1) begin
                    $display("time = %0d, SCOREBOARD : CORRECT - Output = %0d   , Input = %0b" , $time , trans.illegal_instr_o , trans.instr_i);
                  end
                  else begin
                    $display("time = %0d, SCOREBOARD : WRONG - Output = %0d   , Input = %0b" , $time , trans.illegal_instr_o , trans.instr_i);
                  end
              end

              if (trans.instr_i[15:13] == 3'b110) begin
                if(trans.instr_o == {5'b0, trans.instr_i[5], trans.instr_i[12], 2'b01, trans.instr_i[4:2], 2'b01, trans.instr_i[9:7], 3'b010, trans.instr_i[11:10], trans.instr_i[6], 2'b00, OPCODE_STORE}) begin
                  $display("time = %0d, SCOREBOARD : CORRECT - Output = %0d   , Input = %0b" , $time , trans.instr_o , trans.instr_i);
                end
                else begin
                  $display("time = %0d, SCOREBOARD : WRONG - Output = %0d   , Input = %0b" , $time , trans.instr_o , trans.instr_i);
                end
              end

              if (trans.instr_i[15:13] == 3'b111) begin
                  if (trans.illegal_instr_o == 1'b1) begin
                    $display("time = %0d, SCOREBOARD : CORRECT - Output = %0d   , Input = %0b" , $time , trans.illegal_instr_o , trans.instr_i);
                  end
                  else begin
                    $display("time = %0d, SCOREBOARD : WRONG - Output = %0d   , Input = %0b" , $time , trans.illegal_instr_o , trans.instr_i);
                  end
              end
            end





            if(trans.instr_i[1:0] == 2'b01) begin   //C1
              if (trans.instr_i[15:13] == 3'b000) begin
                if(trans.instr_o == {{6{trans.instr_i[12]}}, trans.instr_i[12], trans.instr_i[6:2], trans.instr_i[11:7], 3'b0, trans.instr_i[11:7], OPCODE_OPIMM}) begin
                  $display("time = %0d, SCOREBOARD : CORRECT - Output = %0d   , Input = %0b" , $time , trans.instr_o , trans.instr_i);
                end
                else begin
                  $display("time = %0d, SCOREBOARD : WRONG - Output = %0d   , Input = %0b" , $time , trans.instr_o , trans.instr_i);
                end
              end

              if (trans.instr_i[15:13] == 3'b001 || trans.instr_i[15:13] == 3'b101) begin
                if(trans.instr_o == {trans.instr_i[12], trans.instr_i[8], trans.instr_i[10:9], trans.instr_i[6], trans.instr_i[7], trans.instr_i[2], trans.instr_i[11], trans.instr_i[5:3], {9{trans.instr_i[12]}}, 4'b0, ~trans.instr_i[15], OPCODE_JAL}) begin
                  $display("time = %0d, SCOREBOARD : CORRECT - Output = %0d   , Input = %0b" , $time , trans.instr_o , trans.instr_i);
                end
                else begin
                  $display("time = %0d, SCOREBOARD : WRONG - Output = %0d   , Input = %0b" , $time , trans.instr_o , trans.instr_i);
                end
              end

              if (trans.instr_i[15:13] == 3'b010) begin
                if (trans.instr_i[11:7] == 5'b0 && trans.instr_o == {{6{trans.instr_i[12]}}, trans.instr_i[12], trans.instr_i[6:2], 5'b0, 3'b0, trans.instr_i[11:7], OPCODE_OPIMM}) begin
                  $display("time = %0d, SCOREBOARD : CORRECT - Output = %0d   , Input = %0b" , $time , trans.instr_o , trans.instr_i);
                end
                else if (trans.instr_o == {{6{trans.instr_i[12]}}, trans.instr_i[12], trans.instr_i[6:2], 5'b0, 3'b0, trans.instr_i[11:7], OPCODE_OPIMM}) begin
                  $display("time = %0d, SCOREBOARD : CORRECT - Output = %0d   , Input = %0b" , $time , trans.instr_o , trans.instr_i);
                end
                else begin
                  $display("time = %0d, SCOREBOARD : WRONG - Output = %0d   , Input = %0b" , $time , trans.instr_o , trans.instr_i);
                end
              end

              if (trans.instr_i[15:13] == 3'b011) begin
                if ({trans.instr_i[12], trans.instr_i[6:2]} == 6'b0) begin
                  if(trans.illegal_instr_o == 1'b1) begin
                    $display("time = %0d, SCOREBOARD : CORRECT - Output = %0d   , Input = %0b" , $time , trans.illegal_instr_o , trans.instr_i);
                  end
                  else begin
                    $display("time = %0d, SCOREBOARD : WRONG - Output = %0d   , Input = %0b" , $time , trans.illegal_instr_o , trans.instr_i);
                  end
                end
                else begin
                  if (trans.instr_i[11:7] == 5'h02 && trans.instr_o == {{3{trans.instr_i[12]}}, trans.instr_i[4:3], trans.instr_i[5], trans.instr_i[2], trans.instr_i[6], 4'b0, 5'h02, 3'b000, 5'h02, OPCODE_OPIMM}) begin
                    $display("time = %0d, SCOREBOARD : CORRECT - Output = %0d   , Input = %0b" , $time , trans.instr_o , trans.instr_i);
                  end
                  else if (trans.instr_i[11:7] == 5'b0 && trans.instr_o == {{15{trans.instr_i[12]}}, trans.instr_i[6:2], trans.instr_i[11:7], OPCODE_LUI}) begin
                    $display("time = %0d, SCOREBOARD : CORRECT - Output = %0d   , Input = %0b" , $time , trans.instr_o , trans.instr_i);
                  end
                  else if (trans.instr_o == {{15{trans.instr_i[12]}}, trans.instr_i[6:2], trans.instr_i[11:7], OPCODE_LUI}) begin
                    $display("time = %0d, SCOREBOARD : CORRECT - Output = %0d   , Input = %0b" , $time , trans.instr_o , trans.instr_i);
                  end
                  else begin
                    $display("time = %0d, SCOREBOARD : WRONG - Output = %0d   , Input = %0b" , $time , trans.instr_o , trans.instr_i);
                  end
            end
              end

              if (trans.instr_i[15:13] == 3'b110 || trans.instr_i[15:13] == 3'b111) begin
                if (trans.instr_o == {{4{trans.instr_i[12]}}, trans.instr_i[6:5], trans.instr_i[2], 5'b0, 2'b01, trans.instr_i[9:7], 2'b00, trans.instr_i[13], trans.instr_i[11:10], trans.instr_i[4:3], trans.instr_i[12], OPCODE_BRANCH}) begin
                  $display("time = %0d, SCOREBOARD : CORRECT - Output = %0d   , Input = %0b" , $time , trans.instr_o , trans.instr_i);
                end
                else begin
                  $display("time = %0d, SCOREBOARD : CORRECT - Output = %0d   , Input = %0b" , $time , trans.instr_o , trans.instr_i);
                end
            
              end
              end
            end
          

            numTransactions++;

        end

    endtask


endclass