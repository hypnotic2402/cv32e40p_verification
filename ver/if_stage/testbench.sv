`include "interface.sv"
`include "test.sv"

module testbenchTop;

    bit clk;
    always #5 clk = ~clk;

    intf i_intf(clk);
    test tes(i_intf);

    cv32e40p_if_stage if_stage(
    .rst_n(i_intf.rst_n),
    .m_trap_base_addr_i(i_intf.m_trap_base_addr_i),
    .u_trap_base_addr_i(i_intf.u_trap_base_addr_i),
    .trap_addr_mux_i(i_intf.trap_addr_mux_i),
    .boot_addr_i(i_intf.boot_addr_i),
    .dm_exception_addr_i(i_intf.dm_exception_addr_i),
    .dm_halt_addr_i(i_intf.dm_halt_addr_i),
    .req_i(i_intf.req_i),
    .instr_gnt_i(i_intf.instr_gnt_i),
    .instr_rvalid_i(i_intf.instr_rvalid_i),
    .instr_rdata_i(i_intf.instr_rdata_i),
    .instr_err_i(i_intf.instr_err_i),
    .instr_err_pmp_i(i_intf.instr_err_pmp_i),
    .clear_instr_valid_i(i_intf.clear_instr_valid_i),  // clear instruction valid bit in IF/ID pipe
    .pc_set_i(i_intf.pc_set_i),  // set the program counter to a new value
    .mepc_i(i_intf.mepc_i),  // address used to restore PC when the interrupt/exception is served
    .uepc_i(i_intf.uepc_i),  // address used to restore PC when the interrupt/exception is served
    .depc_i(i_intf.depc_i),  // address used to restore PC when the debug is served
    .pc_mux_i(i_intf.pc_mux_i),  // sel for pc multiplexer
    .exc_pc_mux_i(i_intf.exc_pc_mux_i),  // selects ISR address
    .m_exc_vec_pc_mux_i(i_intf.m_exc_vec_pc_mux_i),  // selects ISR address for vectorized interrupt lines
    .u_exc_vec_pc_mux_i(i_intf.u_exc_vec_pc_mux_i),  // selects ISR address for vectorized interrupt lines
    .jump_target_id_i(i_intf.jump_target_id_i),  // jump target address
    .jump_target_ex_i(i_intf.jump_target_ex_i),  // jump target address
    .hwlp_jump_i(i_intf.hwlp_jump_i),
    .hwlp_target_i(i_intf.hwlp_target_i),
    .halt_if_i(i_intf.halt_if_i),
    .id_ready_i(i_intf.id_ready_i),

    .instr_req_o(i_intf.instr_req_o),
    .instr_addr_o(i_intf.instr_addr_o),
    .instr_valid_id_o(i_intf.instr_valid_id_o),
    .instr_rdata_id_o(i_intf.instr_rdata_id_o),
    .is_compressed_id_o(i_intf.is_compressed_id_o),
    .illegal_c_insn_id_o(i_intf.illegal_c_insn_id_o),
    .pc_if_o(i_intf.pc_if_o),
    .pc_id_o(i_intf.pc_id_o),
    .is_fetch_failed_o(i_intf.is_fetch_failed_o),
    .csr_mtvec_init_o(i_intf.csr_mtvec_init_o),
    .if_busy_o(i_intf.if_busy_o),
    .perf_imiss_o(i_intf.perf_imiss_o)
    );

    

endmodule