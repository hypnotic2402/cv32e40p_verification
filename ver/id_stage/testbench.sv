`include "interface.sv"
`include "test.sv"

module testbenchTop;

    bit clk;
    bit clk_ungated_i;
    always #5 clk = ~clk;
    

    intf i_intf(clk);
    test tes(i_intf);

    cv32e40p_id_stage id_stage(
        .clk(i_intf.clk),
        .clk_ungated_i(i_intf.clk_ungated_i),
        .rst_n(i_intf.rst_n),
        .scan_cg_en_i(i_intf.scan_cg_en_i),
        .fetch_enable_i(i_intf.fetch_enable_i),
        .ctrl_busy_o(i_intf.ctrl_busy_o),
        .is_decoding_o(i_intf.is_decoding_o),
        .instr_valid_i(i_intf.instr_valid_i),
        .instr_rdata_i  (i_intf.instr_rdata_i  ),
        .instr_req_o(i_intf.instr_req_o),
        .is_compressed_i(i_intf.is_compressed_i),
        .illegal_c_insn_i(i_intf.illegal_c_insn_i),
        .branch_in_ex_o(i_intf.branch_in_ex_o),
        .branch_decision_i(i_intf.branch_decision_i),
        .jump_target_o(i_intf.jump_target_o),
        .clear_instr_valid_o(i_intf.clear_instr_valid_o),
        .pc_set_o(i_intf.pc_set_o),
        .pc_mux_o(i_intf.pc_mux_o),
        .exc_pc_mux_o(i_intf.exc_pc_mux_o),
        .trap_addr_mux_o(i_intf.trap_addr_mux_o),
        .is_fetch_failed_i(i_intf.is_fetch_failed_i),
        .pc_id_i(i_intf.pc_id_i),
        .halt_if_o  (i_intf.halt_if_o  ),
        .id_ready_o  (i_intf.id_ready_o  ),
        .ex_ready_i  (i_intf.ex_ready_i  ),
        .wb_ready_i  (i_intf.wb_ready_i  ),
        .id_valid_o  (i_intf.id_valid_o  ),
        .ex_valid_i  (i_intf.ex_valid_i  ),
        .pc_ex_o(i_intf.pc_ex_o),
        .alu_operand_a_ex_o(i_intf.alu_operand_a_ex_o),
        .alu_operand_b_ex_o(i_intf.alu_operand_b_ex_o),
        .alu_operand_c_ex_o(i_intf.alu_operand_c_ex_o),
        .bmask_a_ex_o(i_intf.bmask_a_ex_o),
        .bmask_b_ex_o(i_intf.bmask_b_ex_o),
        .imm_vec_ext_ex_o(i_intf.imm_vec_ext_ex_o),
        .alu_vec_mode_ex_o(i_intf.alu_vec_mode_ex_o),
        .regfile_waddr_ex_o(i_intf.regfile_waddr_ex_o),
        .regfile_we_ex_o(i_intf.regfile_we_ex_o),
        .regfile_alu_waddr_ex_o(i_intf.regfile_alu_waddr_ex_o),
        .regfile_alu_we_ex_o(i_intf.regfile_alu_we_ex_o),
        .alu_en_ex_o(i_intf.alu_en_ex_o),
        .alu_operator_ex_o(i_intf.alu_operator_ex_o),
        .alu_is_clpx_ex_o(i_intf.alu_is_clpx_ex_o),
        .alu_is_subrot_ex_o(i_intf.alu_is_subrot_ex_o),
        .alu_clpx_shift_ex_o(i_intf.alu_clpx_shift_ex_o),
        .mult_operator_ex_o(i_intf.mult_operator_ex_o),
        .mult_operand_a_ex_o(i_intf.mult_operand_a_ex_o),
        .mult_operand_b_ex_o(i_intf.mult_operand_b_ex_o),
        .mult_operand_c_ex_o(i_intf.mult_operand_c_ex_o),
        .mult_en_ex_o(i_intf.mult_en_ex_o),
        .mult_sel_subword_ex_o(i_intf.mult_sel_subword_ex_o),
        .mult_signed_mode_ex_o(i_intf.mult_signed_mode_ex_o),
        .mult_imm_ex_o(i_intf.mult_imm_ex_o),
        .mult_dot_op_a_ex_o(i_intf.mult_dot_op_a_ex_o),
        .mult_dot_op_b_ex_o(i_intf.mult_dot_op_b_ex_o),
        .mult_dot_op_c_ex_o(i_intf.mult_dot_op_c_ex_o),
        .mult_dot_signed_ex_o(i_intf.mult_dot_signed_ex_o),
        .mult_is_clpx_ex_o(i_intf.mult_is_clpx_ex_o),
        .mult_clpx_shift_ex_o(i_intf.mult_clpx_shift_ex_o),
        .mult_clpx_img_ex_o(i_intf.mult_clpx_img_ex_o),
        .apu_en_ex_o(i_intf.apu_en_ex_o),
        .apu_op_ex_o(i_intf.apu_op_ex_o),
        .apu_lat_ex_o(i_intf.apu_lat_ex_o),
        .apu_operands_ex_o(i_intf.apu_operands_ex_o),
        .apu_flags_ex_o(i_intf.apu_flags_ex_o),
        .apu_waddr_ex_o(i_intf.apu_waddr_ex_o),
        .apu_read_regs_o(i_intf.apu_read_regs_o),
        .apu_read_regs_valid_o(i_intf.apu_read_regs_valid_o),
        .apu_read_dep_i(i_intf.apu_read_dep_i),
        .apu_write_regs_o(i_intf.apu_write_regs_o),
        .apu_write_regs_valid_o(i_intf.apu_write_regs_valid_o),
        .apu_write_dep_i(i_intf.apu_write_dep_i),
        .apu_perf_dep_o(i_intf.apu_perf_dep_o),
        .apu_busy_i(i_intf.apu_busy_i),
        .frm_i(i_intf.frm_i),
        .csr_access_ex_o(i_intf.csr_access_ex_o),
        .csr_op_ex_o(i_intf.csr_op_ex_o),
        .current_priv_lvl_i(i_intf.current_priv_lvl_i),
        .csr_irq_sec_o(i_intf.csr_irq_sec_o),
        .csr_cause_o(i_intf.csr_cause_o),
        .csr_save_if_o(i_intf.csr_save_if_o),
        .csr_save_id_o(i_intf.csr_save_id_o),
        .csr_save_ex_o(i_intf.csr_save_ex_o),
        .csr_restore_mret_id_o(i_intf.csr_restore_mret_id_o),
        .csr_restore_uret_id_o(i_intf.csr_restore_uret_id_o),
        .csr_restore_dret_id_o(i_intf.csr_restore_dret_id_o),
        .csr_save_cause_o(i_intf.csr_save_cause_o),
        .hwlp_start_o(i_intf.hwlp_start_o),
        .hwlp_end_o(i_intf.hwlp_end_o),
        .hwlp_cnt_o(i_intf.hwlp_cnt_o),
        .hwlp_jump_o(i_intf.hwlp_jump_o),
        .hwlp_target_o(i_intf.hwlp_target_o),
        .data_req_ex_o(i_intf.data_req_ex_o),
        .data_we_ex_o(i_intf.data_we_ex_o),
        .data_type_ex_o(i_intf.data_type_ex_o),
        .data_sign_ext_ex_o(i_intf.data_sign_ext_ex_o),
        .data_reg_offset_ex_o(i_intf.data_reg_offset_ex_o),
        .data_load_event_ex_o(i_intf.data_load_event_ex_o),
        .data_misaligned_ex_o(i_intf.data_misaligned_ex_o),
        .prepost_useincr_ex_o(i_intf.prepost_useincr_ex_o),
        .data_misaligned_i(i_intf.data_misaligned_i),
        .data_err_i(i_intf.data_err_i),
        .data_err_ack_o(i_intf.data_err_ack_o),
        .atop_ex_o(i_intf.atop_ex_o),
        .irq_i(i_intf.irq_i),
        .irq_sec_i(i_intf.irq_sec_i),
        .mie_bypass_i  (i_intf.mie_bypass_i  ),
        .mip_o  (i_intf.mip_o  ),
        .m_irq_enable_i(i_intf.m_irq_enable_i),
        .u_irq_enable_i(i_intf.u_irq_enable_i),
        .irq_ack_o(i_intf.irq_ack_o),
        .irq_id_o(i_intf.irq_id_o),
        .exc_cause_o(i_intf.exc_cause_o),
        .debug_mode_o(i_intf.debug_mode_o),
        .debug_cause_o(i_intf.debug_cause_o),
        .debug_csr_save_o(i_intf.debug_csr_save_o),
        .debug_req_i(i_intf.debug_req_i),
        .debug_single_step_i(i_intf.debug_single_step_i),
        .debug_ebreakm_i(i_intf.debug_ebreakm_i),
        .debug_ebreaku_i(i_intf.debug_ebreaku_i),
        .trigger_match_i(i_intf.trigger_match_i),
        .debug_p_elw_no_sleep_o(i_intf.debug_p_elw_no_sleep_o),
        .debug_havereset_o(i_intf.debug_havereset_o),
        .debug_running_o(i_intf.debug_running_o),
        .debug_halted_o(i_intf.debug_halted_o),
        .wake_from_sleep_o(i_intf.wake_from_sleep_o),
        .regfile_waddr_wb_i(i_intf.regfile_waddr_wb_i),
        .regfile_we_wb_i(i_intf.regfile_we_wb_i),
        .regfile_wdata_wb_i (i_intf.regfile_wdata_wb_i ),
        .regfile_alu_waddr_fw_i(i_intf.regfile_alu_waddr_fw_i),
        .regfile_alu_we_fw_i(i_intf.regfile_alu_we_fw_i),
        .regfile_alu_wdata_fw_i(i_intf.regfile_alu_wdata_fw_i),
        .mult_multicycle_i    (i_intf.mult_multicycle_i    ),
        .mhpmevent_minstret_o(i_intf.mhpmevent_minstret_o),
        .mhpmevent_load_o(i_intf.mhpmevent_load_o),
        .mhpmevent_store_o(i_intf.mhpmevent_store_o),
        .mhpmevent_jump_o(i_intf.mhpmevent_jump_o),
        .mhpmevent_branch_o(i_intf.mhpmevent_branch_o),
        .mhpmevent_branch_taken_o(i_intf.mhpmevent_branch_taken_o),
        .mhpmevent_compressed_o(i_intf.mhpmevent_compressed_o),
        .mhpmevent_jr_stall_o(i_intf.mhpmevent_jr_stall_o),
        .mhpmevent_imiss_o(i_intf.mhpmevent_imiss_o),
        .mhpmevent_ld_stall_o(i_intf.mhpmevent_ld_stall_o),
        .mhpmevent_pipe_stall_o(i_intf.mhpmevent_pipe_stall_o),
        .perf_imiss_i(i_intf.perf_imiss_i),
        .mcounteren_i(i_intf.mcounteren_i)
    );

    

endmodule