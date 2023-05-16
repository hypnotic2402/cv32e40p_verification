package pkg1;
`include "transaction.sv"

endpackage
 
// import pkg1::*;
// `include "opcode.sv"
// `include "transaction.sv"

interface intf(input logic clk);


    logic rst_n; //1 bit

    logic scan_cg_en_i; //1 bit

    //Read port R1
    logic [4:0] raddr_a_i; //4 bits
    logic [31:0] rdata_a_o; //5 bits

    //Read port R2
    logic [4:0] raddr_b_i; //4 bits
    logic [31:0] rdata_b_o; //5 bits


    //Read port R3
    logic [4:0] raddr_c_i; //4 bits
    logic [31:0] rdata_c_o; //5 bits


    // Write port W1
    logic [4:0] waddr_a_i; //4 bits
    logic [31:0] wdata_a_i; //5 bits
    logic                  we_a_i; //1 bit

    // Write port W2
    logic [4:0] waddr_b_i; //4 bits
    logic [31:0] wdata_b_i; //5 bits
    logic                  we_b_i; //1 bit


endinterface