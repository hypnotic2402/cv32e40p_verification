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

            // write logic here
            if (trans.rst_n == 0) 
            begin
                if (trans.alu_en_ex_o!= '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 1 - alu_en_ex_o when rst" , $time);
                end

                if (trans.alu_operator_ex_o      != 7'b0000011)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 2 - alu_operator_ex_o when rst" , $time);
                end

                if(trans.alu_operand_a_ex_o     != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 3 - alu_operand_a_ex_o when rst" , $time);
                end
                if(trans.alu_operand_b_ex_o     != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 4 - alu_operand_b_ex_o when rst", $time);
                end
                if(trans.alu_operand_c_ex_o     != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 5 -alu_operand_c_ex_o when rst", $time);
                end
                if(trans.bmask_a_ex_o           != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 6 - bmask_a_ex_o when rst", $time);
                end
                if(trans.bmask_b_ex_o           != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 7 - bmask_b_ex_o when rst", $time);
                end
                if(trans.imm_vec_ext_ex_o       != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 8 - imm_vec_ext_ex_o when rst", $time);
                end
                if(trans.alu_vec_mode_ex_o      != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 9 - alu_vec_mode_ex_o when rst", $time);
                end
                if(trans.alu_clpx_shift_ex_o    != 2'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 10 - alu_clpx_shift_ex_o when rst", $time);
                end
                if(trans.alu_is_clpx_ex_o       != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 11 - alu_is_clpx_ex_o when rst", $time);
                end
                if(trans.alu_is_subrot_ex_o     != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 12 - alu_is_subrot_ex_o when rst", $time);
                end
                if(trans.mult_operator_ex_o     != 3'b000)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 13 - mult_operator_ex_o when rst", $time);
                end
                if(trans.mult_operand_a_ex_o    != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 14 - mult_operand_a_ex_o when rst", $time);
                end
                if(trans.mult_operand_b_ex_o    != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 15 - mult_operand_b_ex_o when rst", $time);
                end
                if(trans.mult_operand_c_ex_o    != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 16 - mult_operand_c_ex_o when rst", $time);
                end
                if(trans.mult_en_ex_o           != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 17 - mult_en_ex_o when rst", $time);
                end
                if(trans.mult_sel_subword_ex_o  != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 18 - mult_sel_subword_ex_o when rst", $time);
                end
                if(trans.mult_signed_mode_ex_o  != 2'b00)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 19 - mult_signed_mode_ex_o when rst", $time);
                end
                if(trans.mult_imm_ex_o          != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 20 - mult_imm_ex_o when rst", $time);
                end
                if(trans.mult_dot_op_a_ex_o     != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 21 - mult_dot_op_a_ex_o when rst", $time);
                end
                if(trans.mult_dot_op_b_ex_o     != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 22 - mult_dot_op_b_ex_o when rst", $time);
                end
                if(trans.mult_dot_op_c_ex_o     != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 23 - mult_dot_op_c_ex_o when rst", $time);
                end
                if(trans.mult_dot_signed_ex_o   != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 24 - mult_dot_signed_ex_o when rst", $time);
                end
                if(trans.mult_is_clpx_ex_o      != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 25 - mult_is_clpx_ex_o when rst", $time);
                end
                if(trans.mult_clpx_shift_ex_o   != 2'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 26 - mult_clpx_shift_ex_o when rst", $time);
                end
                if(trans.mult_clpx_img_ex_o     != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 27 - mult_clpx_img_ex_o when rst", $time);
                end
                if(trans.apu_en_ex_o            != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 28 - apu_en_ex_o when rst", $time);
                end
                if(trans.apu_op_ex_o            != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 29 - apu_op_ex_o when rst", $time);
                end
                if(trans.apu_lat_ex_o           != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 30 - apu_lat_ex_o when rst", $time);
                end
                if(trans.apu_operands_ex_o[0]   != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 31 - apu_operands_ex_o[0] when rst", $time);
                end
                if(trans.apu_operands_ex_o[1]   != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 32 - apu_operands_ex_o[1] when rst", $time);
                end
                if(trans.apu_operands_ex_o[2]   != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 33 - apu_operands_ex_o[2] when rst", $time);
                end
                if(trans.apu_flags_ex_o         != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 34 - apu_flags_ex_o when rst", $time);
                end
                if(trans.apu_waddr_ex_o         != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 35 - apu_waddr_ex_o when rst", $time);
                end
                if(trans.regfile_waddr_ex_o     != 6'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 36 - regfile_waddr_ex_o when rst", $time);
                end
                if(trans.regfile_we_ex_o        != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 37 - regfile_we_ex_o when rst", $time);
                end
                if(trans.regfile_alu_waddr_ex_o != 6'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 38 - regfile_alu_waddr_ex_o when rst", $time);
                end
                if(trans.regfile_alu_we_ex_o    != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 39 - regfile_alu_we_ex_o when rst", $time);
                end
                if(trans.prepost_useincr_ex_o   != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 40 - prepost_useincr_ex_o when rst", $time);
                end
                if(trans.csr_access_ex_o        != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 41 - csr_access_ex_o when rst", $time);
                end
                if(trans.csr_op_ex_o            != 2'b00)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 42 - csr_op_ex_o when rst", $time);
                end
                if(trans.data_we_ex_o           != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 43 - data_we_ex_o when rst", $time);
                end
                if(trans.data_type_ex_o         != 2'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 44 - data_type_ex_o when rst", $time);
                end
                if(trans.data_sign_ext_ex_o     != 2'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 45 - data_sign_ext_ex_o when rst", $time);
                end
                if(trans.data_reg_offset_ex_o   != 2'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 46 - data_reg_offset_ex_o when rst", $time);
                end
                if(trans.data_req_ex_o          != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 47 - data_req_ex_o when rst", $time);
                end
                if(trans.data_load_event_ex_o   != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 48 - data_load_event_ex_o when rst", $time);
                end
                if(trans.atop_ex_o              != 5'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 49 - atop_ex_o when rst", $time);
                end
                if(trans.data_misaligned_ex_o   != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 50 - data_misaligned_ex_o when rst", $time);
                end
                if(trans.pc_ex_o                != '0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 51 - pc_ex_o when rst", $time);
                end
                if(trans.branch_in_ex_o         != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase 52 - branch_in_ex_o when rst", $time);
                end
                if(trans.mhpmevent_minstret_o     != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase - mhpmevent_minstret_o when rst", $time);
                end
                if(trans.mhpmevent_load_o         != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase - mhpmevent_load_o     when rst", $time);
                end
                if(trans.mhpmevent_store_o        != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase - mhpmevent_store_o    when rst", $time);
                end
                if(trans.mhpmevent_jump_o         != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase - mhpmevent_jump_o     when rst", $time);
                end
                if(trans.mhpmevent_branch_o       != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase - mhpmevent_branch_o   when rst", $time);
                end
                if(trans.mhpmevent_compressed_o   != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase - mhpmevent_compressed_when rst", $time);
                end
                if(trans.mhpmevent_branch_taken_o != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase - mhpmevent_branch_takewhen rst", $time);
                end
                if(trans.mhpmevent_jr_stall_o     != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase - mhpmevent_jr_stall_o when rst", $time);
                end
                if(trans.mhpmevent_imiss_o        != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase - mhpmevent_imiss_o    when rst", $time);
                end
                if(trans.mhpmevent_ld_stall_o     != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase - mhpmevent_ld_stall_o when rst", $time);
                end
                if(trans.mhpmevent_pipe_stall_o   != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase - mhpmevent_pipe_stall_when rst", $time);
                end

            end

            else if(trans.rst_n == 1'b1 & trans.data_misaligned_i == 1'b1 & trans.ex_ready_i == 1'b1)
            begin
                if (trans.data_misaligned_ex_o != 1'b1)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase - data_misaligned_i when not rst", $time);
                end
            end

            else if(trans.rst_n == 1'b1 & trans.data_err_i == 1'b1)
            begin
                if(trans.is_decoding_o == 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase - is_decoding_o when not rst", $time);

                end
            end

            if(trans.is_fetch_failed_i == 1'b0 || trans.ex_ready_i == 1'b0)
            begin
                if(trans.id_valid_o != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Error in testcase - id_valid_o when not rst", $time);

                end
                else 
                    $display("HI!");

            end
            
//checking for opcodes
            if(trans.instr_rdata_i != '0)
            begin

                if(trans.instr_rdata_i[6:0] == 7'h6f) //jal
                begin
                    if(trans.alu_operator_ex_o != 7'b0011000)
                    begin
                        $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_JAL when not rst", $time);

                    end
                end

                if(trans.instr_rdata_i[6:0] == 7'h67) //jalr
                begin
                    if(trans.alu_operator_ex_o != 7'b0011000)
                    begin
                        $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_JALR when not rst", $time);

                    end
                end

                if(trans.instr_rdata_i[6:0] == 7'h63) //branch
                begin
                    if(trans.instr_rdata_i[14:12] == 3'b000)
                    begin
                        if(trans.alu_operator_ex_o !=  7'b0001100)
                        begin
                            $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_BRANCH - ALU_EQ when not rst", $time);
                        end
                    end

                    if(trans.instr_rdata_i[14:12] == 3'b001)
                    begin
                        if(trans.alu_operator_ex_o !=  7'b0001101)
                        begin
                            $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_BRANCH - ALU_NE when not rst", $time);
                        end
                    end

                    if(trans.instr_rdata_i[14:12] == 3'b100)
                    begin
                        if(trans.alu_operator_ex_o !=  7'b0000000)
                        begin
                            $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_BRANCH - ALU_LTS when not rst", $time);
                        end
                    end

                    if(trans.instr_rdata_i[14:12] == 3'b101)
                    begin
                        if(trans.alu_operator_ex_o !=  7'b0001010)
                        begin
                            $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_BRANCH - ALU_GES when not rst", $time);
                        end
                    end
                    if(trans.instr_rdata_i[14:12] == 3'b110)
                    begin
                        if(trans.alu_operator_ex_o !=  7'b0000001)
                        begin
                            $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_BRANCH - ALU_LTU when not rst", $time);
                        end
                    end

                    if(trans.instr_rdata_i[14:12] == 3'b111)
                    begin
                        if(trans.alu_operator_ex_o !=  7'b0001011)
                        begin
                            $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_BRANCH - ALU_GEU when not rst", $time);
                        end
                    end
                end

                if(trans.instr_rdata_i[6:0] == 7'h23)//store
                begin
                    if(trans.alu_operator_ex_o != 7'b0011000)
                    begin
                        $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_STORE when not rst", $time);
                    end

                    if(trans.instr_rdata_i[14:12] == 3'b000)
                    begin
                        if(trans.data_type_ex_o != 2'b10) //SB
                        begin
                            $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_STORE - SB when not rst", $time);
                        end
                    end

                    if(trans.instr_rdata_i[14:12] == 3'b000)
                    begin
                        if(trans.data_type_ex_o != 2'b10) //SH
                        begin
                            $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_STORE - SH when not rst", $time);
                        end
                    end

                    if(trans.instr_rdata_i[14:12] == 3'b010)
                    begin
                        if(trans.data_type_ex_o != 2'b00) //SW
                        begin
                            $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_STORE - SW when not rst", $time);
                        end
                    end
                end

                if(trans.instr_rdata_i[6:0] == 7'h03) //LOAD
                begin
                    if(trans.alu_operator_ex_o != 7'b0011000)
                    begin
                        $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_LOAD when not rst", $time);

                    end

                    if(trans.instr_rdata_i[14:12] == 3'b000 || trans.instr_rdata_i[14:12] == 3'b100)
                    begin
                        if(trans.data_type_ex_o != 2'b10) //LB, LBU
                        begin
                            $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_LOAD - LB(U) when not rst", $time);
                        end
                    end

                    if(trans.instr_rdata_i[14:12] == 3'b001 || trans.instr_rdata_i[14:12] == 3'b101)
                    begin
                        if(trans.data_type_ex_o != 2'b10) //LH, LHU
                        begin
                            $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_LOAD - LH(U) when not rst", $time);
                        end
                    end

                    if(trans.instr_rdata_i[14:12] == 3'b010)
                    begin
                        if(trans.data_type_ex_o != 2'b00) //LW
                        begin
                            $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_STORE - LW when not rst", $time);
                        end
                    end
                end

                if(trans.instr_rdata_i[6:0] == 7'h37) //LUI
                begin
                    if(trans.alu_operator_ex_o != 7'b0011000)
                    begin
                        $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_LUI when not rst", $time);
                    end 
                end

                if(trans.instr_rdata_i[6:0] == 7'h17) //AUIPC
                begin
                    if(trans.alu_operator_ex_o != 7'b0011000)
                    begin
                        $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_AUIPC when not rst", $time);
                    end 
                end

                if(trans.instr_rdata_i[6:0] == 7'h13) //OPIMM
                begin
                    if(trans.instr_rdata_i[14:12] == 3'b000)
                    begin
                        if(trans.alu_operator_ex_o != 7'b0011000)
                        begin
                            $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_OPIMM - ALU_ADD when not rst", $time);
                        end
                    end

                    if(trans.instr_rdata_i[14:12] == 3'b010)
                    begin
                        if(trans.alu_operator_ex_o != 7'b0000010)
                        begin
                            $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_OPIMM - ALU_SLTS when not rst", $time);
                        end
                    end
                    if(trans.instr_rdata_i[14:12] == 3'b011)
                    begin
                        if(trans.alu_operator_ex_o !=  7'b0000011)
                        begin
                            $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_OPIMM - ALU_SLTU when not rst", $time);
                        end
                    end

                    if(trans.instr_rdata_i[14:12] == 3'b100)
                    begin
                        if(trans.alu_operator_ex_o !=  7'b0101111)
                        begin
                            $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_OPIMM - ALU_XOR when not rst", $time);
                        end
                    end

                    if(trans.instr_rdata_i[14:12] == 3'b110)
                    begin
                        if(trans.alu_operator_ex_o !=  7'b0101110)
                        begin
                            $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_OPIMM - ALU_OR when not rst", $time);
                        end
                    end
                    if(trans.instr_rdata_i[14:12] == 3'b111)
                    begin
                        if(trans.alu_operator_ex_o != 7'b0010101)
                        begin
                            $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_OPIMM - ALU_AND when not rst", $time);
                        end
                    end
                    if(trans.instr_rdata_i[14:12] == 3'b001)
                    begin
                        if(trans.alu_operator_ex_o != 7'b0100111)
                        begin
                            $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_OPIMM - ALU_SLL when not rst", $time);
                            if (trans.instr_rdata_i[31:25] != 7'b0)
                            begin
                                $display("time = %0d, SCOREBOARD :OPCODE_OPIMM - ALU_SLL - illegal instr when not rst", $time);
                            end
                            
                        end
                    end

                    if(trans.instr_rdata_i[14:12] == 3'b101)
                    begin                        
                        if (trans.instr_rdata_i[31:25] == 7'b0)
                        begin
                            if(trans.alu_operator_ex_o != 7'b0100101)
                            begin
                                $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_OPIMM - ALU_SRL when not rst", $time);
                            end
                        end

                        else if (trans.instr_rdata_i[31:25] == 7'b010_0000)
                        begin
                            if(trans.alu_operator_ex_o != 7'b0100100)
                            begin
                                $display("time = %0d, SCOREBOARD : Error in testcase - OPCODE_OPIMM - ALU_SRL when not rst", $time);
                            end
                        end
                        else
                        begin
                                $display("time = %0d, SCOREBOARD :OPCODE_OPIMM - illegal inst when not rst", $time);
                        end 
                    end
                end

                if(trans.instr_rdata_i[31:30] == 2'b00 || trans.instr_rdata_i[31:30] == 2'b01)
                begin
                    case ({trans.instr_rdata_i[30:25], trans.instr_rdata_i[14:12]})
                        // RV32I ALU operations
                        {6'b00_0000, 3'b000}: begin
                            if(trans.alu_operator_ex_o != 7'b0011000) 
                            begin 
                                $display("time = %0d, SCOREBOARD : Error in testcase - Add when not rst", $time);
                            end   // Add
                        end

                        {6'b10_0000, 3'b000}: begin
                            if (trans.alu_operator_ex_o != 7'b0011001)
                            begin 
                                $display("time = %0d, SCOREBOARD : Error in testcase - Sub when not rst", $time);
                            end   // Sub
                        end
                        {6'b00_0000, 3'b010}: begin
                            if(trans.alu_operator_ex_o != 7'b0000010)
                            begin
                                $display("time = %0d, SCOREBOARD : Error in test - Set on less than when not rst", $time);
                            end  // Set Lower Than
                        end
                        {6'b00_0000, 3'b011}: begin
                            if(trans.alu_operator_ex_o != 7'b0000011)
                            begin
                                $display("time = %0d, SCOREBOARD : Error in test - Set on less than unsigned when not rst", $time);
                            end  // Set Lower Than Unsigned
                        end
                        {6'b00_0000, 3'b100}: begin
                            if(trans.alu_operator_ex_o != 7'b0101111)
                            begin
                                $display("time = %0d, SCOREBOARD : Error in test - XOR when not rst", $time);
                            end  // Xor
                        end
                        {6'b00_0000, 3'b110}: begin
                            if(trans.alu_operator_ex_o !=  7'b0101110)
                            begin
                                $display("time = %0d, SCOREBOARD : Error in test - OR when not rst", $time);
                            end  // Or
                        end
                        {6'b00_0000, 3'b111}: begin
                            if(trans.alu_operator_ex_o != 7'b0010101)
                            begin
                                $display("time = %0d, SCOREBOARD : Error in test - AND when not rst", $time);
                            end  // And
                        end
                        {6'b00_0000, 3'b001}: begin
                            if(trans.alu_operator_ex_o != 7'b0100111)
                            begin
                                $display("time = %0d, SCOREBOARD : Error in test - Shift left logical when not rst", $time);
                            end  // Shift Left Logical
                        end
                        {6'b00_0000, 3'b101}: begin
                            if(trans.alu_operator_ex_o != 7'b0100101)
                            begin
                                $display("time = %0d, SCOREBOARD : Error in test - Shift Right Logical when not rst", $time);
                            end  // Shift Right Logical
                        end
                        {6'b10_0000, 3'b101}: begin
                            if(trans.alu_operator_ex_o != 7'b0100100)
                            begin
                                $display("time = %0d, SCOREBOARD : Error in test - Shift Right Arithmetic when not rst", $time);
                            end  // Shift Right Arithmetic
                        end
                        {6'b00_0001, 3'b000}: begin
                            if(trans.mult_operator_ex_o != 3'b000)
                            begin
                                $display("time = %0d, SCOREBOARD : Error in test - mul when not rst", $time);
                            end
                        end // mul
                        {6'b00_0001, 3'b001}: begin
                            if(trans.mult_operator_ex_o != 3'b110 & trans.mult_signed_mode_ex_o != 2'b11)
                            begin
                                $display("time = %0d, SCOREBOARD : Error in test - mulh when not rst", $time);
                            end
                        end // mulh                           
                        {6'b00_0001, 3'b010}: begin
                            if(trans.mult_operator_ex_o != 3'b110 & trans.mult_signed_mode_ex_o != 2'b01)
                            begin
                                $display("time = %0d, SCOREBOARD : Error in test - mulhsu when not rst", $time);
                            end
                        end // mulhsu                            
                        {6'b00_0001, 3'b011}: begin
                            if(trans.mult_operator_ex_o != 3'b110 & trans.mult_signed_mode_ex_o != 2'b00)
                            begin
                                $display("time = %0d, SCOREBOARD : Error in test - mulhu when not rst", $time);
                            end
                        end // mulhu                           
                        {6'b00_0001, 3'b100}: begin
                            if(trans.alu_operator_ex_o != 7'b0110001)
                            begin
                                $display("time = %0d, SCOREBOARD : Error in test - div when not rst", $time);
                            end
                        end // div                            
                        {6'b00_0001, 3'b101}: begin
                            if(trans.alu_operator_ex_o != 7'b0110000)
                            begin
                                $display("time = %0d, SCOREBOARD : Error in test - div unsigned when not rst", $time);
                            end
                        end // divu                           
                        {6'b00_0001, 3'b110}: begin
                            if(trans.alu_operator_ex_o != 7'b0110011 )
                            begin
                                $display("time = %0d, SCOREBOARD : Error in test - remainder when not rst", $time);
                            end
                        end // rem                           
                        {6'b00_0001, 3'b111}: begin
                            if(trans.alu_operator_ex_o != 7'b0110010)
                            begin
                                $display("time = %0d, SCOREBOARD : Error in test - remainder unsigned when not rst", $time);
                            end
                        end // remu
                        default: begin
                            $display("time = %0d, SCOREBOARD : Illegal instr when not rst", $time);
                        end
                    endcase   
                end

                //PULP Instructions

                if(trans.instr_rdata_i[6:0] == 7'h0b) begin
                    if (trans.instr_rdata_i[14:13] != 3'b11) 
                    begin // cv.l[bhw][u] and cv.elw                      
                        if(trans.alu_operator_ex_o != 7'b0011000) begin
                            $display("time = %0d, SCOREBOARD : Error in test - PULP instr 1 when not rst", $time);
                        end
                        // sign/zero extension
                        if(trans.data_sign_ext_ex_o != {1'b0,~trans.instr_rdata_i[14]}) begin
                            $display("time = %0d, SCOREBOARD : Error in test - PULP instr 1 - sign extension when not rst", $time);
                        end

                        // load size
                        case (trans.instr_rdata_i[13:12])
                            2'b00  : begin
                                if(trans.data_type_ex_o != 2'b10) begin
                                    $display("time = %0d, SCOREBOARD : Error in test -  PULP instr LB(U) datatype", $time);
                                end
                            end // LB/LBU
                            2'b01  : begin
                                if(trans.data_type_ex_o != 2'b01) begin
                                    $display("time = %0d, SCOREBOARD : Error in test - PULP instr LH(U) datatype ", $time);
                                end
                            end // LH/LHU
                            default: begin
                                if(trans.data_type_ex_o != 2'b00) begin
                                    $display("time = %0d, SCOREBOARD :Error in test - PULP instr LW, ELW datatype   ", $time);
                                end
                            end // LW/ELW
                        endcase
                    end 
                        
                    else  
                    begin   // cv.beqimm and cv.bneimm 
                        if (trans.instr_rdata_i[12] == 1'b0) begin // cv.beqimm
                            if(trans.alu_operator_ex_o != 7'b0001100)
                            begin
                                $display("time = %0d, SCOREBOARD : Error in test - PULP instr beqimm", $time);
                            end
                        end
                        else begin                       // cv.bneimm
                            if(trans.alu_operator_ex_o != 7'b0001101)
                            begin
                                $display("time = %0d, SCOREBOARD : Error in test - PULP instr bneimm", $time);
                            end
                            
                        end
                    end                    
                end
            end

            numTransactions++;
        end

           

        

    endtask

endclass