// Code your testbench here
// or browse Examples

`include "interface.sv"
`include "test.sv"

module testbenchTop;

    bit clk;
    always #5 clk = ~clk;

    intf i_intf(clk);
    test tes(i_intf);

    cv32e40p_popcnt popcnt(
        .in_i(i_intf.in_i),
        .result_o(i_intf.result_o)
    );

    

endmodule