//package pkg1;
//`include "transaction.sv"
//`include "opcode.sv"
//endpackage

import pkg1::*;
// `include "opcode.sv"
// `include "transaction.sv"

interface intf(input logic clk);

    logic [31:0] data_rdata_i;  // Data type word, halfword, byte    -> from ex stage
    logic data_rvalid_i;
    logic data_gnt_i;  // high if we are currently performing the second part of a misaligned store
    logic data_we_ex_i;  // write enable                      -> from ex stage
    logic [ 1:0] data_type_ex_i;  // Data type word, halfword, byte    -> from ex stage
    logic [31:0] data_wdata_ex_i;  // data to write to memory           -> from ex stage
    logic [ 1:0] data_reg_offset_ex_i;  // offset inside register for stores -> from ex stage
    logic data_load_event_ex_i;  // load event                        -> from ex stage
    logic [ 1:0] data_sign_ext_ex_i;  // sign extension
    logic data_req_ex_i;  // data request                      -> from ex stage
    logic [31:0] operand_a_ex_i;  // operand a from RF for address     -> from ex stage
    logic [31:0] operand_b_ex_i;  // operand b from RF for address     -> from ex stage
    logic addr_useincr_ex_i;  // use a + b or just a for address   -> from ex stage
    logic data_misaligned_ex_i;  // misaligned access in last ld/st   -> from ID/EX pipeline
    logic [5:0] data_atop_ex_i;  // atomic instructions signal

    logic [31:0] data_addr_o;
    logic data_we_o;
    logic [3:0] data_be_o;
    logic [31:0] data_wdata_o;
    logic data_req_o; //register for byte enable
    logic lsu_ready_ex_o;  // LSU ready for new data in EX stage
    logic lsu_ready_wb_o;  // LSU ready for new data in WB stage
    logic busy_o;
    logic [5:0] data_atop_o;  // atomic instruction signal 
    logic data_misaligned_o;  // misaligned access was detected 
    logic [31:0] data_rdata_ex_o;  // requested data
    

endinterface