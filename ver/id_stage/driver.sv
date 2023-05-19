import pkg1::*;
 
class driver;

    int numTransactions;
    virtual intf vif;
    mailbox gen2driv;
    transaction trans;

    //constructor
 
    function new(virtual intf vif , mailbox gen2driv);
        this.vif = vif;
        this.gen2driv = gen2driv;
    endfunction

    task main;

        forever begin

            gen2driv.get(trans);

            @(posedge vif.clk);

            vif.rst_n <= trans.rst_n;
            vif.scan_cg_en_i <= trans.scan_cg_en_i;
            vif.fetch_enable_i <= trans.fetch_enable_i;
            vif.instr_valid_i <= trans.instr_valid_i;
            vif.instr_rdata_i <= trans.instr_rdata_i;// comes from pipeline of IF stage
            vif.is_compressed_i <= trans.is_compressed_i;
            vif.illegal_c_insn_i <= trans.illegal_c_insn_i;
            vif.branch_decision_i <= trans.branch_decision_i;
            vif.is_fetch_failed_i <= trans.is_fetch_failed_i;
            vif.pc_id_i <= trans.pc_id_i;
            vif.ex_ready_i <= trans.ex_ready_i;              // EX stage is ready for the next instruction
            vif.wb_ready_i <= trans.wb_ready_i;                   // WB stage is ready for the next instruction
            vif.ex_valid_i <= trans.ex_valid_i; // EX stage is              // EX stage is done
            vif.apu_read_dep_i <= trans.apu_read_dep_i;
            vif.apu_write_dep_i <= trans.apu_write_dep_i;
            vif.apu_busy_i <= trans.apu_busy_i;
            vif.frm_i <= trans.frm_i;
            vif.current_priv_lvl_i <= trans.current_priv_lvl_i;
            vif.data_misaligned_i <= trans.data_misaligned_i;
            vif.data_err_i <= trans.data_err_i;
            vif.irq_i <= trans.irq_i;
            vif.irq_sec_i <= trans.irq_sec_i;
            vif.mie_bypass_i <= trans.mie_bypass_i;                    // MIE CSR (bypass)
            vif.m_irq_enable_i <= trans.m_irq_enable_i;
            vif.u_irq_enable_i <= trans.u_irq_enable_i;
            vif.debug_req_i <= trans.debug_req_i;
            vif.debug_single_step_i <= trans.debug_single_step_i;
            vif.debug_ebreakm_i <= trans.debug_ebreakm_i;
            vif.debug_ebreaku_i <= trans.debug_ebreaku_i;
            vif.trigger_match_i <= trans.trigger_match_i;
            vif.regfile_waddr_wb_i <= trans.regfile_waddr_wb_i;
            vif.regfile_we_wb_i <= trans.regfile_we_wb_i;
            vif.regfile_wdata_wb_i <= trans.regfile_wdata_wb_i;                 // From wb_stage: selects data from data memory ex_stage result and sp rdata
            vif.regfile_alu_waddr_fw_i <= trans.regfile_alu_waddr_fw_i;
            vif.regfile_alu_we_fw_i <= trans.regfile_alu_we_fw_i;
            vif.regfile_alu_wdata_fw_i <= trans.regfile_alu_wdata_fw_i;
            vif.mult_multicycle_i  <= trans.mult_multicycle_i;                // when we need multiple cycles in the multiplier and use op c as storage
            vif.perf_imiss_i <= trans.perf_imiss_i;
            vif.mcounteren_i <= trans.mcounteren_i;
            
            
            @(posedge vif.clk);
//             trans.display("Driver :  ");
            numTransactions++;


        end
    endtask

endclass