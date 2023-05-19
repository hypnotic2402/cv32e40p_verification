// package p2;
// `include "opcode.sv"
// endpackage


class transaction; 
    // all the rand bit = I/P
    // all the bit = O/P
    rand bit rst_n;

    // from ex stage
    rand bit [          31:0] hwlp_start_data_i;
    rand bit [          31:0] hwlp_end_data_i;
    rand bit [          31:0] hwlp_cnt_data_i;
    rand bit [           2:0] hwlp_we_i;
    rand bit  hwlp_regid_i;  // selects the register set

    // from controller
    rand bit valid_i;

    // from hwloop controller
    rand bit [1:0] hwlp_dec_cnt_i;

    // to hwloop controller
    bit [1:0][31:0] hwlp_start_addr_o;
    bit [1:0][31:0] hwlp_end_addr_o;
    bit [1:0][31:0] hwlp_counter_o;

    // Coverage Metrics
    covergroup cg;
        option.per_instance = 1;
        coverpoint rst_n;
        coverpoint hwlp_start_data_i;
        coverpoint hwlp_end_data_i;
        coverpoint hwlp_cnt_data_i;
        coverpoint hwlp_we_i;
        coverpoint hwlp_regid_i;
        coverpoint valid_i;
        coverpoint hwlp_dec_cnt_i;
    endgroup

    function new();
        cg = new;
    endfunction

    function void display(string name);

        $display("time = %0d , %s , rst_n = %0b , start_data_in = %0b , end_data_in = %0b , count_data_in = %0b,  start_data_out = %0b , end_data_out = %0b , count_data_out = %0b," , $time , name , rst_n, hwlp_start_data_i, hwlp_end_data_i, hwlp_cnt_data_i, hwlp_start_addr_o, hwlp_end_addr_o, hwlp_counter_o);
       

    endfunction



endclass