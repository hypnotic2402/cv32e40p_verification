`include "interface.sv"
`include "test.sv"

module testbenchTop;

    bit clk;
    always #5 clk = ~clk;

    intf i_intf(clk);
    test tes(i_intf);

    cv32e40p_hwloop_regs hwlp_reg(
        .rst_n(i_intf.rst_n),
        .hwlp_start_data_i(i_intf.hwlp_start_data_i),
        .hwlp_end_data_i(i_intf.hwlp_end_data_i),
        .hwlp_cnt_data_i(i_intf.hwlp_cnt_data_i),
        .hwlp_we_i(i_intf.hwlp_we_i),
        .hwlp_regid_i(i_intf.hwlp_regid_i),
        .valid_i(i_intf.valid_i),
        .hwlp_dec_cnt_i(i_intf.hwlp_dec_cnt_i),
        .hwlp_start_addr_o(i_intf.hwlp_start_addr_o),
        .hwlp_end_addr_o(i_intf.hwlp_end_addr_o),
        .hwlp_counter_o(i_intf.hwlp_counter_o)

    );

    

endmodule