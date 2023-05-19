// package pkg1;
// `include "transaction.sv"
// endpackage

import pkg1::*;
 
class monitor;

    virtual intf vif;
    mailbox mon2scb;
    transaction trans;

    // Constructor
    function new(virtual intf vif , mailbox mon2scb);
        this.vif = vif;
        this.mon2scb = mon2scb;
        trans = new;
    endfunction

    task main;

        forever begin

            repeat(2)@(posedge vif.clk);
            // inputs
                trans.rst_n = vif.rst_n;
                trans.scan_cg_en_i = vif.scan_cg_en_i;
                trans.fetch_enable_i = vif.fetch_enable_i;
                trans.instr_valid_i = vif.instr_valid_i;
                trans.instr_rdata_i = vif.instr_rdata_i;// comes from pipeline of IF stage
                trans.is_compressed_i = vif.is_compressed_i;
                trans.illegal_c_insn_i = vif.illegal_c_insn_i;
                trans.branch_decision_i = vif.branch_decision_i;
                trans.is_fetch_failed_i = vif.is_fetch_failed_i;
                trans.pc_id_i = vif.pc_id_i;
                trans.ex_ready_i = vif.ex_ready_i;              // EX stage is ready for the next instruction
                trans.wb_ready_i = vif.wb_ready_i;                   // WB stage is ready for the next instruction
                trans.ex_valid_i = vif.ex_valid_i; // EX stage is              // EX stage is done
                trans.apu_read_dep_i = vif.apu_read_dep_i;
                trans.apu_write_dep_i = vif.apu_write_dep_i;
                trans.apu_busy_i = vif.apu_busy_i;
                trans.frm_i = vif.frm_i;
                trans.current_priv_lvl_i = vif.current_priv_lvl_i;
                trans.data_misaligned_i = vif.data_misaligned_i;
                trans.data_err_i = vif.data_err_i;
                trans.irq_i = vif.irq_i;
                trans.irq_sec_i = vif.irq_sec_i;
                trans.mie_bypass_i = vif.mie_bypass_i;                    // MIE CSR (bypass)
                trans.m_irq_enable_i = vif.m_irq_enable_i;
                trans.u_irq_enable_i = vif.u_irq_enable_i;
                trans.debug_req_i = vif.debug_req_i;
                trans.debug_single_step_i = vif.debug_single_step_i;
                trans.debug_ebreakm_i = vif.debug_ebreakm_i;
                trans.debug_ebreaku_i = vif.debug_ebreaku_i;
                trans.trigger_match_i = vif.trigger_match_i;
                trans.regfile_waddr_wb_i = vif.regfile_waddr_wb_i;
                trans.regfile_we_wb_i = vif.regfile_we_wb_i;
                trans.regfile_wdata_wb_i = vif.regfile_wdata_wb_i;                 // From wb_stage: selects data from data memory ex_stage result and sp rdata
                trans.regfile_alu_waddr_fw_i = vif.regfile_alu_waddr_fw_i;
                trans.regfile_alu_we_fw_i = vif.regfile_alu_we_fw_i;
                trans.regfile_alu_wdata_fw_i = vif.regfile_alu_wdata_fw_i;
                trans.mult_multicycle_i  = vif.mult_multicycle_i;                // when we need multiple cycles in the multiplier and use op c as storage
                trans.perf_imiss_i = vif.perf_imiss_i;
                trans.mcounteren_i = vif.mcounteren_i;

            // outputs
                trans.ctrl_busy_o = vif.ctrl_busy_o;
                trans.is_decoding_o = vif.is_decoding_o;
                trans.instr_req_o = vif.instr_req_o;
                trans.branch_in_ex_o = vif.branch_in_ex_o;
                trans.jump_target_o = vif.jump_target_o;
                trans.clear_instr_valid_o = vif.clear_instr_valid_o;
                trans.pc_set_o = vif.pc_set_o;
                trans.pc_mux_o = vif.pc_mux_o;
                trans.exc_pc_mux_o = vif.exc_pc_mux_o;
                trans.trap_addr_mux_o = vif.trap_addr_mux_o;
                trans.halt_if_o = vif.halt_if_o; // controller requests a halt of the IF stage = vif.halt_if_o  // controller requests a halt of the IF stage;
                trans.id_ready_o = vif.id_ready_o; // ID stage is ready for the next instruction = vif.id_ready_o  // ID stage is ready for the next instruction;
                trans.id_valid_o = vif.id_valid_o; // ID stage is done;
                trans.pc_ex_o = vif.pc_ex_o;
                trans.alu_operand_a_ex_o = vif.alu_operand_a_ex_o;
                trans.alu_operand_b_ex_o = vif.alu_operand_b_ex_o;
                trans.alu_operand_c_ex_o = vif.alu_operand_c_ex_o;
                trans.bmask_a_ex_o = vif.bmask_a_ex_o;
                trans.bmask_b_ex_o = vif.bmask_b_ex_o;
                trans.imm_vec_ext_ex_o = vif.imm_vec_ext_ex_o;
                trans.alu_vec_mode_ex_o = vif.alu_vec_mode_ex_o;
                trans.regfile_waddr_ex_o = vif.regfile_waddr_ex_o;
                trans.regfile_we_ex_o = vif.regfile_we_ex_o;
                trans.regfile_alu_waddr_ex_o = vif.regfile_alu_waddr_ex_o;
                trans.regfile_alu_we_ex_o = vif.regfile_alu_we_ex_o;
                trans.alu_en_ex_o = vif.alu_en_ex_o;
                trans.alu_operator_ex_o = vif.alu_operator_ex_o;
                trans.alu_is_clpx_ex_o = vif.alu_is_clpx_ex_o;
                trans.alu_is_subrot_ex_o = vif.alu_is_subrot_ex_o;
                trans.alu_clpx_shift_ex_o = vif.alu_clpx_shift_ex_o;
                trans.mult_operator_ex_o = vif.mult_operator_ex_o;
                trans.mult_operand_a_ex_o = vif.mult_operand_a_ex_o;
                trans.mult_operand_b_ex_o = vif.mult_operand_b_ex_o;
                trans.mult_operand_c_ex_o = vif.mult_operand_c_ex_o;
                trans.mult_en_ex_o = vif.mult_en_ex_o;
                trans.mult_sel_subword_ex_o = vif.mult_sel_subword_ex_o;
                trans.mult_signed_mode_ex_o = vif.mult_signed_mode_ex_o;
                trans.mult_imm_ex_o = vif.mult_imm_ex_o;
                trans.mult_dot_op_a_ex_o = vif.mult_dot_op_a_ex_o;
                trans.mult_dot_op_b_ex_o = vif.mult_dot_op_b_ex_o;
                trans.mult_dot_op_c_ex_o = vif.mult_dot_op_c_ex_o;
                trans.mult_dot_signed_ex_o = vif.mult_dot_signed_ex_o;
                trans.mult_is_clpx_ex_o = vif.mult_is_clpx_ex_o;
                trans.mult_clpx_shift_ex_o = vif.mult_clpx_shift_ex_o;
                trans.mult_clpx_img_ex_o = vif.mult_clpx_img_ex_o;
                trans.apu_en_ex_o = vif.apu_en_ex_o;
                trans.apu_op_ex_o = vif.apu_op_ex_o;
                trans.apu_lat_ex_o = vif.apu_lat_ex_o;
                trans.apu_operands_ex_o = vif.apu_operands_ex_o;
                trans.apu_flags_ex_o = vif.apu_flags_ex_o;
                trans.apu_waddr_ex_o = vif.apu_waddr_ex_o;
                trans.apu_read_regs_o = vif.apu_read_regs_o;
                trans.apu_read_regs_valid_o = vif.apu_read_regs_valid_o;
                trans.apu_write_regs_o = vif.apu_write_regs_o;
                trans.apu_write_regs_valid_o = vif.apu_write_regs_valid_o;
                trans.apu_perf_dep_o = vif.apu_perf_dep_o;
                trans.csr_access_ex_o = vif.csr_access_ex_o;
                trans.csr_op_ex_o = vif.csr_op_ex_o;
                trans.csr_irq_sec_o = vif.csr_irq_sec_o;
                trans.csr_cause_o = vif.csr_cause_o;
                trans.csr_save_if_o = vif.csr_save_if_o;
                trans.csr_save_id_o = vif.csr_save_id_o;
                trans.csr_save_ex_o = vif.csr_save_ex_o;
                trans.csr_restore_mret_id_o = vif.csr_restore_mret_id_o;
                trans.csr_restore_uret_id_o = vif.csr_restore_uret_id_o;
                trans.csr_restore_dret_id_o = vif.csr_restore_dret_id_o;
                trans.csr_save_cause_o = vif.csr_save_cause_o;
                trans.hwlp_start_o = vif.hwlp_start_o;
                trans.hwlp_end_o = vif.hwlp_end_o;
                trans.hwlp_cnt_o = vif.hwlp_cnt_o;
                trans.hwlp_jump_o = vif.hwlp_jump_o;
                trans.hwlp_target_o = vif.hwlp_target_o;
                trans.data_req_ex_o = vif.data_req_ex_o;
                trans.data_we_ex_o = vif.data_we_ex_o;
                trans.data_type_ex_o = vif.data_type_ex_o;
                trans.data_sign_ext_ex_o = vif.data_sign_ext_ex_o;
                trans.data_reg_offset_ex_o = vif.data_reg_offset_ex_o;
                trans.data_load_event_ex_o = vif.data_load_event_ex_o;
                trans.data_misaligned_ex_o = vif.data_misaligned_ex_o;
                trans.prepost_useincr_ex_o = vif.prepost_useincr_ex_o;
                trans.data_err_ack_o = vif.data_err_ack_o;
                trans.atop_ex_o = vif.atop_ex_o;
                trans.mip_o = vif.mip_o;  // MIP CSR = vif.mip_o  // MIP CSR;
                trans.irq_ack_o = vif.irq_ack_o;
                trans.irq_id_o = vif.irq_id_o;
                trans.exc_cause_o = vif.exc_cause_o;
                trans.debug_mode_o = vif.debug_mode_o;
                trans.debug_cause_o = vif.debug_cause_o;
                trans.debug_csr_save_o = vif.debug_csr_save_o;
                trans.debug_p_elw_no_sleep_o = vif.debug_p_elw_no_sleep_o;
                trans.debug_havereset_o = vif.debug_havereset_o;
                trans.debug_running_o = vif.debug_running_o;
                trans.debug_halted_o = vif.debug_halted_o;
                trans.wake_from_sleep_o = vif.wake_from_sleep_o;
                trans.mhpmevent_minstret_o = vif.mhpmevent_minstret_o;
                trans.mhpmevent_load_o = vif.mhpmevent_load_o;
                trans.mhpmevent_store_o = vif.mhpmevent_store_o;
                trans.mhpmevent_jump_o = vif.mhpmevent_jump_o;
                trans.mhpmevent_branch_o = vif.mhpmevent_branch_o;
                trans.mhpmevent_branch_taken_o = vif.mhpmevent_branch_taken_o;
                trans.mhpmevent_compressed_o = vif.mhpmevent_compressed_o;
                trans.mhpmevent_jr_stall_o = vif.mhpmevent_jr_stall_o;
                trans.mhpmevent_imiss_o = vif.mhpmevent_imiss_o;
                trans.mhpmevent_ld_stall_o = vif.mhpmevent_ld_stall_o;
                trans.mhpmevent_pipe_stall_o = vif.mhpmevent_pipe_stall_o;

            @(posedge vif.clk);
            mon2scb.put(trans);
//             trans.display("Monitor : ");

        end

    endtask


endclass