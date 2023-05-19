package pkg1;
`include "transaction.sv"

endpackage
 
// import pkg1::*;
// `include "opcode.sv"
// `include "transaction.sv"

interface intf(input logic clk);

    logic rst_n; 
    logic [          31:0] hwlp_start_data_i;
    logic [          31:0] hwlp_end_data_i;
    logic [          31:0] hwlp_cnt_data_i;
    logic [           2:0] hwlp_we_i;
    logic hwlp_regid_i;  // selects the register set   
    logic valid_i;    
    logic [1:0] hwlp_dec_cnt_i;    
    logic [1:0][31:0] hwlp_start_addr_o;
    logic [1:0][31:0] hwlp_end_addr_o;
    logic [1:0][31:0] hwlp_counter_o;
endinterface