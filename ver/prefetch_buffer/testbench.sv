// Code your testbench here
// or browse Examples

`include "interface.sv"
`include "test.sv"

module testbenchTop;

    bit clk;
    always #5 clk = ~clk;

    intf i_intf(clk);
    test tes(i_intf);

    cv32e40p_prefetch_buffer prefetch_buffer(
            .clk(i_intf.clk),
            .rst_n(i_intf.rst_n),
            .req_i(i_intf.req_i),
            .branch_i(i_intf.branch_i),
            .branch_addr_i(i_intf.branch_addr_i),
            .hwlp_jump_i(i_intf.hwlp_jump_i),
            .hwlp_target_i(i_intf.hwlp_target_i),
            .fetch_ready_i(i_intf.fetch_ready_i),
            .instr_gnt_i(i_intf.instr_gnt_i),
            .instr_rdata_i(i_intf.instr_rdata_i),
            .instr_rdata_i(i_intf.instr_rdata_i),
            .instr_err_i(i_intf.instr_err_i),
            .instr_err_pmp_i(i_intf.instr_err_pmp_i),
                
            .fetch_valid_o(i_intf.fetch_valid_o),
            .fetch_rdata_o(i_intf.fetch_rdata_o),
            .instr_req_o(i_intf.instr_req_o),
            .instr_addr_o(i_intf.instr_addr_o),
            .busy_o(i_intf.busy_o)
    );

    

endmodule