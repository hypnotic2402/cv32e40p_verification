// package p2;
// `include "opcode.sv"
// endpackage


class transaction;

    //// Defining IO's of AL
    //rand bit [31:0] operand_a_i , operand_b_i , operand_c_i;
    //rand bit enable_i;
    //rand bit [1:0] vector_mode_i;
    //rand bit [4:0] bmask_a_i;
    //rand bit [4:0] bmask_b_i;
    //rand bit [1:0] imm_vec_ext_i;
    //rand bit is_clpx_i , is_subrot_i , ex_ready_i;
    //rand bit [1:0] clpx_shift_i;
    //rand bit [6:0] operator_i;
  	//rand bit rst_n;

    //bit [31:0] result_o;
    //bit comparison_result_o , ready_o;

    // Defining IO's of LSU

    rand bit data_gnt_i;
    rand bit data_rvalid_i;
    rand bit [31:0] data_rdata_i;
    rand bit data_we_ex_i;  // write enable                      -> from ex stage
    rand bit [ 1:0] data_type_ex_i;  // Data type word, halfword, byte    -> from ex stage
    rand bit [31:0] data_wdata_ex_i;  // data to write to memory           -> from ex stage
    rand bit [ 1:0] data_reg_offset_ex_i;  // offset inside register for stores -> from ex stage
    rand bit data_load_event_ex_i;  // load event                        -> from ex stage
    rand bit [ 1:0] data_sign_ext_ex_i;  // sign extension 
    rand bit data_misaligned_ex_i;  // misaligned access in last ld/st   -> from ID/EX pipeline
    rand bit [5:0] data_atop_ex_i;  // atomic instructions signal
    rand bit data_req_ex_i;  // data request                      -> from ex stage
    rand bit [31:0] operand_a_ex_i;  // operand a from RF for address     -> from ex stage
    rand bit [31:0] operand_b_ex_i;  // operand b from RF for address     -> from ex stage
    rand bit addr_useincr_ex_i;  // use a + b or just a for address   -> from ex stage
    bit [31:0] data_addr_o;
    bit data_we_o;
    bit [3:0] data_be_o;
    bit [31:0] data_wdata_o;
    bit data_req_o;
    bit busy_o;
    bit lsu_ready_ex_o;  // LSU ready for new data in EX stage
    bit lsu_ready_wb_o;  // LSU ready for new data in WB stage
    bit [5:0] data_atop_o;  // atomic instruction signal         -> core output
    bit data_misaligned_o;  // misaligned access was detected    -> to controller
    bit [31:0] data_rdata_ex_o;  // requested data

    // Constraints to be added
  
  //constraint and_en {operator_i inside {7'b0010101 , 7'b0101110 , 7'b0101111};};
//     constraint or_en {operator_i in {7'b0101110}};
//     constraint xor_en {operator_i in {7'b0101111}};
    
    // Coverage Metrics

    covergroup cg;

        option.per_instance = 1;
        //coverpoint operand_a_i;
        //coverpoint operand_b_i;
       // coverpoint operand_c_i;
     //   coverpoint enable_i;
        //coverpoint vector_mode_i;
        //coverpoint bmask_a_i;
        //coverpoint bmask_b_i;
        //coverpoint imm_vec_ext_i;
        //coverpoint is_clpx_i;
        //coverpoint is_subrot_i;
        //coverpoint ex_ready_i;
        //coverpoint clpx_shift_i;
        //coverpoint rst_n;

        // BE generation part
        //coverpoint data_type_ex_i; // Data tpe 00 Word, 01 Half Word, 11, 10 byte 
        //coverpoint misaligned_st; // 1'b0 -> non-misaligned case , 1'b1 -> misaligned case
        //coverpoint data_addr_int;

        // prepare data to be written to the memory
        // we handle misaligned accesses, half word and byte accesses and
        // register offsets here

        //coverpoint data_reg_offset_ex_i;
        //coverpoint wdata_offset;

        coverpoint data_gnt_i;
        coverpoint data_rvalid_i;
        coverpoint data_rdata_i;
        coverpoint data_we_ex_i;  // write enable                      -> from ex stage
        coverpoint data_type_ex_i;  // Data type word, halfword, byte    -> from ex stage
        coverpoint data_wdata_ex_i;  // data to write to memory           -> from ex stage
        coverpoint data_reg_offset_ex_i;  // offset inside register for stores -> from ex stage
        coverpoint data_load_event_ex_i;  // load event                        -> from ex stage
        coverpoint data_sign_ext_ex_i;  // sign extension
        coverpoint data_req_ex_i;  // data request                      -> from ex stage
        coverpoint operand_a_ex_i;  // operand a from RF for address     -> from ex stage
        coverpoint operand_b_ex_i;  // operand b from RF for address     -> from ex stage
        coverpoint addr_useincr_ex_i;  // use a + b or just a for address   -> from ex stage
        coverpoint data_atop_ex_i;  // atomic instructions signal
        coverpoint data_misaligned_ex_i;  // misaligned access in last ld/st   -> from ID/EX pipeline

    endgroup

    function new();
        cg = new;
    endfunction

    function void display(string name);

        $display("time = %0d , %s , data_gnt_i = %0h , data_rvalid_i = %0h , data_rdata_i = %0h" , $time , name , data_gnt_i , data_rvalid_i , data_rdata_i);

    endfunction



endclass