package pkg1;
`include "transaction.sv"

endpackage
 
// import pkg1::*;
// `include "opcode.sv"
// `include "transaction.sv"

interface intf(input logic clk);

    logic rst_n;
    logic clk_ungated_i;
    logic scan_cg_en_i;

    logic fetch_enable_i;
    logic ctrl_busy_o;
    logic is_decoding_o;

    // Interface to IF stage
    logic        instr_valid_i;
    logic [31:0] instr_rdata_i;  // comes from pipeline of IF stage
    logic        instr_req_o;
    logic        is_compressed_i;
    logic        illegal_c_insn_i;

    // Jumps and branches
    logic        branch_in_ex_o;
    logic        branch_decision_i;
    logic [31:0] jump_target_o;

    // IF and ID stage signals
    logic       clear_instr_valid_o;
    logic       pc_set_o;
    logic [3:0] pc_mux_o;
    logic [2:0] exc_pc_mux_o;
    logic [1:0] trap_addr_mux_o;


    logic is_fetch_failed_i;

    logic [31:0] pc_id_i;

    // Stalls
    logic halt_if_o;  // controller requests a halt of the IF stage

    logic id_ready_o;  // ID stage is ready for the next instruction
    logic ex_ready_i;  // EX stage is ready for the next instruction
    logic wb_ready_i;  // WB stage is ready for the next instruction

    logic id_valid_o;  // ID stage is done
    logic ex_valid_i;  // EX stage is done

    // Pipeline ID/EX
    logic [31:0] pc_ex_o;

    logic [31:0] alu_operand_a_ex_o;
    logic [31:0] alu_operand_b_ex_o;
    logic [31:0] alu_operand_c_ex_o;
    logic [ 4:0] bmask_a_ex_o;
    logic [ 4:0] bmask_b_ex_o;
    logic [ 1:0] imm_vec_ext_ex_o;
    logic [ 1:0] alu_vec_mode_ex_o;

    logic [5:0] regfile_waddr_ex_o;
    logic       regfile_we_ex_o;

    logic [5:0] regfile_alu_waddr_ex_o;
    logic       regfile_alu_we_ex_o;

    // ALU
    logic              alu_en_ex_o;
    logic [6:0]       alu_operator_ex_o;
    logic              alu_is_clpx_ex_o;
    logic              alu_is_subrot_ex_o;
    logic        [1:0] alu_clpx_shift_ex_o;

    // MUL
    logic [2:0]        mult_operator_ex_o;
    logic        [31:0] mult_operand_a_ex_o;
    logic        [31:0] mult_operand_b_ex_o;
    logic        [31:0] mult_operand_c_ex_o;
    logic               mult_en_ex_o;
    logic               mult_sel_subword_ex_o;
    logic        [ 1:0] mult_signed_mode_ex_o;
    logic        [ 4:0] mult_imm_ex_o;

    logic [31:0] mult_dot_op_a_ex_o;
    logic [31:0] mult_dot_op_b_ex_o;
    logic [31:0] mult_dot_op_c_ex_o;
    logic [ 1:0] mult_dot_signed_ex_o;
    logic        mult_is_clpx_ex_o;
    logic [ 1:0] mult_clpx_shift_ex_o;
    logic        mult_clpx_img_ex_o;

    // APU
    logic                              apu_en_ex_o;
    logic [     5:0]       apu_op_ex_o;
    logic [                 1:0]       apu_lat_ex_o;
    logic [   2:0][31:0] apu_operands_ex_o;
    logic [14:0]       apu_flags_ex_o;
    logic [                 5:0]       apu_waddr_ex_o;

    logic [     2:0][5:0] apu_read_regs_o;
    logic [     2:0]      apu_read_regs_valid_o;
    logic                 apu_read_dep_i;
    logic [     1:0][5:0] apu_write_regs_o;
    logic [     1:0]      apu_write_regs_valid_o;
    logic                 apu_write_dep_i;
    logic                 apu_perf_dep_o;
    logic                 apu_busy_i;
    logic [2:0]      frm_i;

    // CSR ID/EX
    logic              csr_access_ex_o;
    logic [1:0]       csr_op_ex_o;
    logic [1:0]          current_priv_lvl_i;
    logic              csr_irq_sec_o;
    logic        [5:0] csr_cause_o;
    logic              csr_save_if_o;
    logic              csr_save_id_o;
    logic              csr_save_ex_o;
    logic              csr_restore_mret_id_o;
    logic              csr_restore_uret_id_o;
    logic              csr_restore_dret_id_o;
    logic              csr_save_cause_o;

    // hwloop signals
    logic [1:0][31:0] hwlp_start_o;
    logic [1:0][31:0] hwlp_end_o;
    logic [1:0][31:0] hwlp_cnt_o;
    logic                    hwlp_jump_o;
    logic [      31:0]       hwlp_target_o;

    // Interface to load store unit
    logic       data_req_ex_o;
    logic       data_we_ex_o;
    logic [1:0] data_type_ex_o;
    logic [1:0] data_sign_ext_ex_o;
    logic [1:0] data_reg_offset_ex_o;
    logic       data_load_event_ex_o;

    logic data_misaligned_ex_o;

    logic prepost_useincr_ex_o;
    logic data_misaligned_i;
    logic data_err_i;
    logic data_err_ack_o;

    logic [5:0] atop_ex_o;

    // Interrupt signals
    logic [31:0] irq_i;
    logic        irq_sec_i;
    logic [31:0] mie_bypass_i;  // MIE CSR (bypass)
    logic [31:0] mip_o;  // MIP CSR
    logic        m_irq_enable_i;
    logic        u_irq_enable_i;
    logic        irq_ack_o;
    logic [ 4:0] irq_id_o;
    logic [ 4:0] exc_cause_o;

    // Debug Signal
    logic       debug_mode_o;
    logic [2:0] debug_cause_o;
    logic       debug_csr_save_o;
    logic       debug_req_i;
    logic       debug_single_step_i;
    logic       debug_ebreakm_i;
    logic       debug_ebreaku_i;
    logic       trigger_match_i;
    logic       debug_p_elw_no_sleep_o;
    logic       debug_havereset_o;
    logic       debug_running_o;
    logic       debug_halted_o;

    // Wakeup Signal
    logic wake_from_sleep_o;

    // Forward Signals
    logic [5:0] regfile_waddr_wb_i;
    logic regfile_we_wb_i;
    logic [31:0] regfile_wdata_wb_i; // From wb_stage: selects data from data memory; ex_stage result and sp rdata

    logic [ 5:0] regfile_alu_waddr_fw_i;
    logic        regfile_alu_we_fw_i;
    logic [31:0] regfile_alu_wdata_fw_i;

    // from ALU
    logic        mult_multicycle_i;    // when we need multiple cycles in the multiplier and use op c as storage

    // Performance Counters
    logic mhpmevent_minstret_o;
    logic mhpmevent_load_o;
    logic mhpmevent_store_o;
    logic mhpmevent_jump_o;
    logic mhpmevent_branch_o;
    logic mhpmevent_branch_taken_o;
    logic mhpmevent_compressed_o;
    logic mhpmevent_jr_stall_o;
    logic mhpmevent_imiss_o;
    logic mhpmevent_ld_stall_o;
    logic mhpmevent_pipe_stall_o;

    logic        perf_imiss_i;
    logic [31:0] mcounteren_i;


endinterface