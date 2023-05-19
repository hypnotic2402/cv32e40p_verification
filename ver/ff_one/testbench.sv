// Code your testbench here
// or browse Examples

`include "interface.sv"
`include "test.sv"

module testbenchTop;

    bit clk;
    always #5 clk = ~clk;

    intf i_intf(clk);
    test tes(i_intf);

    cv32e40p_ff_one ff_one(
        .in_i(i_intf.in_i),
        .first_one_o(i_intf.first_one_o),
        .no_ones_o(i_intf.cno_ones_o)

    );

    

endmodule