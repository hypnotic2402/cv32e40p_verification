class transaction;
 
    // all the rand bit= I/P
    // all the bit = O/P
    rand bit rst_n;

    rand bit scan_cg_en_i;

    rand  bit fetch_enable_i;
    bit ctrl_busy_o;
    bit is_decoding_o;

    // Interface to IF stage
    rand  bit        instr_valid_i;
    rand  bit [31:0] instr_rdata_i;  // comes from pipeline of IF stage
    bit        instr_req_o;
    rand  bit        is_compressed_i;
    rand  bit        illegal_c_insn_i;

    // Jumps and branches
    bit        branch_in_ex_o;
    rand  bit        branch_decision_i;
    bit [31:0] jump_target_o;

    // IF and ID stage signals
    bit       clear_instr_valid_o;
    bit       pc_set_o;
    bit [3:0] pc_mux_o;
    bit [2:0] exc_pc_mux_o;
    bit [1:0] trap_addr_mux_o;


    rand bit is_fetch_failed_i;

    rand bit [31:0] pc_id_i;

    // Stalls
    bit halt_if_o;  // controller requests a halt of the IF stage

    bit id_ready_o;  // ID stage is ready for the next instruction
    rand  bit ex_ready_i;  // EX stage is ready for the next instruction
    rand  bit wb_ready_i;  // WB stage is ready for the next instruction

    bit id_valid_o;  // ID stage is done
    rand  bit ex_valid_i;  // EX stage is done

    // Pipeline ID/EX
    bit [31:0] pc_ex_o;

    bit [31:0] alu_operand_a_ex_o;
    bit [31:0] alu_operand_b_ex_o;
    bit [31:0] alu_operand_c_ex_o;
    bit [ 4:0] bmask_a_ex_o;
    bit [ 4:0] bmask_b_ex_o;
    bit [ 1:0] imm_vec_ext_ex_o;
    bit [ 1:0] alu_vec_mode_ex_o;

    bit [5:0] regfile_waddr_ex_o;
    bit       regfile_we_ex_o;

    bit [5:0] regfile_alu_waddr_ex_o;
    bit       regfile_alu_we_ex_o;

    // ALU
    bit              alu_en_ex_o;
    bit [6:0]       alu_operator_ex_o;
    bit              alu_is_clpx_ex_o;
    bit              alu_is_subrot_ex_o;
    bit        [1:0] alu_clpx_shift_ex_o;

    // MUL
    bit [2:0]        mult_operator_ex_o;
    bit        [31:0] mult_operand_a_ex_o;
    bit        [31:0] mult_operand_b_ex_o;
    bit        [31:0] mult_operand_c_ex_o;
    bit               mult_en_ex_o;
    bit               mult_sel_subword_ex_o;
    bit        [ 1:0] mult_signed_mode_ex_o;
    bit        [ 4:0] mult_imm_ex_o;

    bit [31:0] mult_dot_op_a_ex_o;
    bit [31:0] mult_dot_op_b_ex_o;
    bit [31:0] mult_dot_op_c_ex_o;
    bit [ 1:0] mult_dot_signed_ex_o;
    bit        mult_is_clpx_ex_o;
    bit [ 1:0] mult_clpx_shift_ex_o;
    bit        mult_clpx_img_ex_o;

    // APU
    bit                              apu_en_ex_o;
    bit [     5:0]       apu_op_ex_o;
    bit [                 1:0]       apu_lat_ex_o;
    bit [   2:0][31:0] apu_operands_ex_o;
    bit [14:0]       apu_flags_ex_o;
    bit [                 5:0]       apu_waddr_ex_o;

    bit [     2:0][5:0] apu_read_regs_o;
    bit [     2:0]      apu_read_regs_valid_o;
    rand  bit                 apu_read_dep_i;
    bit [     1:0][5:0] apu_write_regs_o;
    bit [     1:0]      apu_write_regs_valid_o;
    rand  bit                 apu_write_dep_i;
    bit                 apu_perf_dep_o;
    rand  bit                 apu_busy_i;
    rand  bit [2:0]      frm_i;

    // CSR ID/EX
    bit              csr_access_ex_o;
    bit [1:0]       csr_op_ex_o;
    rand  bit [1:0]          current_priv_lvl_i;
    bit              csr_irq_sec_o;
    bit        [5:0] csr_cause_o;
    bit              csr_save_if_o;
    bit              csr_save_id_o;
    bit              csr_save_ex_o;
    bit              csr_restore_mret_id_o;
    bit              csr_restore_uret_id_o;
    bit              csr_restore_dret_id_o;
    bit              csr_save_cause_o;

    // hwloop signals
    bit [1:0][31:0] hwlp_start_o;
    bit [1:0][31:0] hwlp_end_o;
    bit [1:0][31:0] hwlp_cnt_o;
    bit                    hwlp_jump_o;
    bit [      31:0]       hwlp_target_o;

    // Interface to load store unit
    bit       data_req_ex_o;
    bit       data_we_ex_o;
    bit [1:0] data_type_ex_o;
    bit [1:0] data_sign_ext_ex_o;
    bit [1:0] data_reg_offset_ex_o;
    bit       data_load_event_ex_o;

    bit data_misaligned_ex_o;

    bit prepost_useincr_ex_o;
    rand  bit data_misaligned_i;
    rand  bit data_err_i;
    bit data_err_ack_o;

    bit [5:0] atop_ex_o;

    // Interrupt signals
    rand  bit [31:0] irq_i;
    rand  bit        irq_sec_i;
    rand  bit [31:0] mie_bypass_i;  // MIE CSR (bypass)
    bit [31:0] mip_o;  // MIP CSR
    rand  bit        m_irq_enable_i;
    rand  bit        u_irq_enable_i;
    bit        irq_ack_o;
    bit [ 4:0] irq_id_o;
    bit [ 4:0] exc_cause_o;

    // Debug Signal
    bit       debug_mode_o;
    bit [2:0] debug_cause_o;
    bit       debug_csr_save_o;
    rand  bit       debug_req_i;
    rand  bit       debug_single_step_i;
    rand  bit       debug_ebreakm_i;
    rand  bit       debug_ebreaku_i;
    rand  bit       trigger_match_i;
    bit       debug_p_elw_no_sleep_o;
    bit       debug_havereset_o;
    bit       debug_running_o;
    bit       debug_halted_o;

    // Wakeup Signal
    bit wake_from_sleep_o;

    // Forward Signals
    rand bit [5:0] regfile_waddr_wb_i;
    rand bit regfile_we_wb_i;
    rand  bit [31:0] regfile_wdata_wb_i; // From wb_stage: selects data from data memory; ex_stage result and sp rdata

    rand bit [ 5:0] regfile_alu_waddr_fw_i;
    rand bit        regfile_alu_we_fw_i;
    rand bit [31:0] regfile_alu_wdata_fw_i;

    // from ALU
    rand  bit        mult_multicycle_i;    // when we need multiple cycles in the multiplier and use op c as storage

    // Performance Counters
    bit mhpmevent_minstret_o;
    bit mhpmevent_load_o;
    bit mhpmevent_store_o;
    bit mhpmevent_jump_o;
    bit mhpmevent_branch_o;
    bit mhpmevent_branch_taken_o;
    bit mhpmevent_compressed_o;
    bit mhpmevent_jr_stall_o;
    bit mhpmevent_imiss_o;
    bit mhpmevent_ld_stall_o;
    bit mhpmevent_pipe_stall_o;

    rand bit        perf_imiss_i;
    rand bit [31:0] mcounteren_i;

    // Coverage Metrics
    constraint fetch_failure {is_fetch_failed_i <= 0;} // fetch is successful
    constraint valid_instr_input {instr_valid_i <= 1;} //always giving a valid instr -> not saying that the instruction is done

    covergroup cg;
    
    // all rands are coverpoints
        option.per_instance = 1;
           // all the rand bit= I/P
        coverpoint rst_n;
        coverpoint  scan_cg_en_i;
        // coverpoint  fetch_enable_i;
        // coverpoint instr_valid_i;
        coverpoint instr_rdata_i;  // comes from pipeline of IF stage
        // coverpoint  is_compressed_i;
        // coverpoint  illegal_c_insn_i;
        coverpoint  branch_decision_i;
        // coverpoint  is_fetch_failed_i;
        // coverpoint  pc_id_i;
        coverpoint  ex_ready_i;  // EX stage is ready for the next instruction
        // coverpoint  wb_ready_i;  // WB stage is ready for the next instruction
        // coverpoint  ex_valid_i;  // EX stage is done
        // coverpoint  apu_read_dep_i;
        // coverpoint  apu_write_dep_i;
        // coverpoint  apu_busy_i;
        // coverpoint  frm_i;
        // coverpoint  current_priv_lvl_i; 
        coverpoint  data_misaligned_i;
        coverpoint  data_err_i;
        // coverpoint  irq_i;
        // coverpoint  irq_sec_i;
        // coverpoint  mie_bypass_i;  // MIE CSR (bypass)
        // coverpoint  m_irq_enable_i;
        // coverpoint  u_irq_enable_i;
        // coverpoint  debug_req_i;
        // coverpoint  debug_single_step_i;
        // coverpoint  debug_ebreakm_i;
        // coverpoint  debug_ebreaku_i;
        // coverpoint  trigger_match_i;
        coverpoint  regfile_waddr_wb_i;
        coverpoint  regfile_we_wb_i;
        coverpoint  regfile_wdata_wb_i; // From wb_stage: selects data from data memory; ex_stage result and sp rdata
        coverpoint  regfile_alu_waddr_fw_i;
        coverpoint  regfile_alu_we_fw_i;
        coverpoint  regfile_alu_wdata_fw_i;
        coverpoint  mult_multicycle_i;    // when we need multiple cycles in the multiplier and use op c as storage
        // coverpoint  perf_imiss_i;
        // coverpoint  mcounteren_i;

    endgroup

    function new();
        cg = new;
    endfunction

    function void display(string name);

        $display("time = %0d ; %s ; rst_n = %0b ; scan_cg_en_i = %0b " , $time , name , rst_n, scan_cg_en_i);
        
        

    endfunction



endclass