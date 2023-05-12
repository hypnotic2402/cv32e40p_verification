`include "interface.sv"
`include "test.sv"

module testbenchTop;

    bit clk;
    always #5 clk = ~clk;

    intf i_intf(clk);
    test tes(i_intf);

    cv32e40p_alu (
        .clk(i_intf.clk),
        .rst_n(i_intf.rst_n),
        .enable_i(i_intf.enable_i),
        .operator_i(i_intf.operator_i),
        .operand_a_i(i_intf.operand_a_i),
        .operand_b_i(i_intf.operand_b_i),
        .operand_c_i(i_intf.operand_c_i),
        .vector_mode_i(i_intf.vector_mode_i),
        .bmask_a_i(i_intf.bmask_a_i),
        .bmask_b_i(i_intf.bmask_b_i),
        .imm_vec_ext_i(i_intf.imm_vec_ext_i),
        .is_clpx_i(i_intf.is_clpx_i),
        .is_subrot_i(i_intf.is_subrot_i),
        .clpx_shift_i(i_intf.clpx_shift_i),
        .result_o(i_intf.result_o),
        .comparison_result_o(i_intf.comparison_result_o),
        .ready_o(i_intf.ready_o),
        .ex_ready_i(i_intf.ex_ready_i)

    );

    

endmodule