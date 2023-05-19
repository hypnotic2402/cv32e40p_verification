// package p2;
// `include "opcode.sv"
// endpackage


class transaction;
 
    // all the rand bit = I/P
    // all the bit = O/P

    
    rand bit rst_n; //1 bit

    rand bit scan_cg_en_i; //1 bit

    //Read port R1
    rand  bit [4:0] raddr_a_i; //32 bits
    bit [31:0] rdata_a_o; //5 bits

    //Read port R2
    rand  bit [4:0] raddr_b_i; //32 bits
    bit [31:0] rdata_b_o; //5 bits


    //Read port R3
    rand  bit [4:0] raddr_c_i; //32 bits
    bit [31:0] rdata_c_o; //5 bits


    // Write port W1
    rand bit [4:0] waddr_a_i; //32 bits
    rand bit [31:0] wdata_a_i; //5 bits
    rand bit                  we_a_i; //1 bit

    // Write port W2
    rand bit [4:0] waddr_b_i; //32 bits
    rand bit [31:0] wdata_b_i; //5 bits
    rand bit                  we_b_i;//1 bit

    // Coverage Metrics
    constraint raddr_a {raddr_a_i <= 2**4;}
    constraint raddr_b {raddr_b_i <= 2**4;}
    constraint raddr_c {raddr_c_i <= 2**4;}

    constraint waddr_a {waddr_a_i <= 2**4;}
    constraint waddr_b {waddr_b_i <= 2**4;}


    covergroup cg;
    
    // all inputs are coverpoints
        option.per_instance = 1;
        coverpoint rst_n;
        coverpoint scan_cg_en_i;
        //coverpoint raddr_a_i;
        //coverpoint raddr_b_i;
        //coverpoint raddr_c_i;
        //coverpoint waddr_a_i;
        coverpoint wdata_a_i;
        coverpoint we_a_i;
        //coverpoint waddr_b_i;
        coverpoint wdata_b_i;
        coverpoint we_b_i;
    endgroup

    function new();
        cg = new;
    endfunction

    function void display(string name);

        $display("time = %0d , %s , rst_n = %0b , scan_cg_en_i = %0b , raddr_a_i = %0b , rdata_a_o = %0b " , $time , name , rst_n, scan_cg_en_i, raddr_a_i, rdata_a_o);
        $display("time = %0d , %s , rst_n = %0b , scan_cg_en_i = %0b , raddr_b_i = %0b , rdata_b_o = %0b " , $time , name , rst_n, scan_cg_en_i, raddr_b_i, rdata_b_o);
        $display("time = %0d , %s , rst_n = %0b , scan_cg_en_i = %0b , raddr_c_i = %0b , rdata_c_o = %0b " , $time , name , rst_n, scan_cg_en_i, raddr_c_i, rdata_c_o);
        $display("time = %0d , %s , rst_n = %0b , scan_cg_en_i = %0b , waddr_a_i = %0b , wdata_a_i = %0b , we_a_i = %0b " , $time , name , rst_n, scan_cg_en_i, waddr_a_i, wdata_a_i, we_a_i);
        $display("time = %0d , %s , rst_n = %0b , scan_cg_en_i = %0b , waddr_b_i = %0b , wdata_b_i = %0b , we_b_i = %0b " , $time , name , rst_n, scan_cg_en_i, waddr_b_i, wdata_b_i, we_b_i);
        

    endfunction



endclass