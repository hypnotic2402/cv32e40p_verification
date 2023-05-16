`include "interface.sv"
`include "test.sv"

module testbenchTop;

    bit clk;
    always #5 clk = ~clk;

    intf i_intf(clk);
    test tes(i_intf);

    cv32e40p_register_file regfile(
        .clk(i_intf.clk),
        .rst_n(i_intf.rst_n),
        .scan_cg_en_i(i_intf.scan_cg_en_i),
        .raddr_a_i(i_intf.raddr_a_i),
        .rdata_a_o(i_intf.rdata_a_o),
        .raddr_b_i(i_intf.raddr_b_i),
        .rdata_b_o(i_intf.rdata_b_o),
        .raddr_c_i(i_intf.raddr_c_i),
        .rdata_c_o(i_intf.rdata_c_o),
        .waddr_a_i(i_intf.waddr_a_i),
        .wdata_a_i(i_intf.wdata_a_i),
        .we_a_i(i_intf.we_a_i),
        .waddr_b_i(i_intf.waddr_b_i),
        .wdata_b_i(i_intf.wdata_b_i),
        .we_b_i(i_intf.we_b_i)
    );

    

endmodule