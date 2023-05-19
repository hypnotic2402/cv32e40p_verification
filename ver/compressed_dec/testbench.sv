// Code your testbench here
// or browse Examples

`include "interface.sv"
`include "test.sv"

module testbenchTop;

    bit clk;
    always #5 clk = ~clk;

    intf i_intf(clk);
    test tes(i_intf);

    cv32e40p_compressed_decoder compressed_decoder(
        .instr_i(i_intf.instr_i),
        .instr_o(i_intf.instr_o),
        .is_compressed_o(i_intf.is_compressed_o),
        .illegal_instr_o(i_intf.illegal_instr_o)
    );
endmodule