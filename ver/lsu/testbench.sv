`include "cv32e40p_load_store_unit.sv"
//`include "cv32e40p_obi_inteface.sv"
`include "interface.sv"
`include "test.sv"

module testbenchTop;

    bit clk;
    always #5 clk = ~clk;

    intf i_intf(clk);
    test tes(i_intf);

    cv32e40p_load_store_unit load_store_unit(
        .clk(i_intf.clk),
        //.rst_n(i_intf.rst_n),
        .data_req_o(i_intf.data_req_o),
        .data_gnt_i(i_intf.data_gnt_i),
        .data_rvalid_i(i_intf.data_rvalid_i),
        //.data_err_i(i_intf.data_err_i),
        //.data_err_pmp_i(i_intf.data_err_pmp_i),
        .data_addr_o(i_intf.data_addr_o),
        .data_we_o(i_intf.data_we_o),
        .data_be_o(i_intf.data_be_o),
        .data_wdata_o(i_intf.data_wdata_o),
        .data_rdata_i(i_intf.data_rdata_i),
        .data_we_ex_i(i_intf.data_we_ex_i),
        .data_type_ex_i(i_intf.data_type_ex_i),
        .data_wdata_ex_i(i_intf.data_wdata_ex_i),
        .data_reg_offset_ex_i(i_intf.data_reg_offset_ex_i),
        .data_load_event_ex_i(i_intf.data_load_event_ex_i),
        .data_sign_ext_ex_i(i_intf.data_sign_ext_ex_i),
        .data_rdata_ex_o(i_intf.data_rdata_ex_o),
        .data_req_ex_i(i_intf.data_req_ex_i),
        .operand_a_ex_i(i_intf.operand_a_ex_i),
        .operand_b_ex_i(i_intf.operand_b_ex_i),
        .addr_useincr_ex_i(i_intf.addr_useincr_ex_i),
        .data_misaligned_ex_i(i_intf.data_misaligned_ex_i),
        .data_atop_ex_i(i_intf.data_atop_ex_i),
        .data_atop_o(i_intf.data_atop_o),
        //.p_elw_start_o(i_intf.p_elw_start_o),
        //.p_elw_finish_o(i_intf.p_elw_finish_o),
        .lsu_ready_ex_o(i_intf.lsu_ready_ex_o),
        .lsu_ready_wb_o(i_intf.lsu_ready_wb_o),
        .busy_o(i_intf.busy_o)
        //.data_addr_int(i_intf.data_addr_int),
        //.misaligned_st(i_intf.misaligned_st)
    );

    

endmodule