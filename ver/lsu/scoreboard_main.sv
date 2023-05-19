// package pkg1;
// `include "transaction.sv"
// endpackage

import pkg1::*;

class scoreboard;

    mailbox mon2scb;
    int numTransactions;
    transaction trans;
    int flag = 0;

    // Constructor
    function new(mailbox mon2scb);
        this.mon2scb = mon2scb;
    endfunction

    task main;

        forever begin

            mon2scb.get(trans);

            // Chekcing AND operation
          //if (trans.operator_i == 7'b0010101)
          //  begin
          //      
          //      if (trans.result_o != trans.operand_a_i & trans.operand_b_i)
          //      begin
          //          $display("time = %0d, SCOREBOARD : Error in AND operation" , $time);
          //      end
//
          //      end else begin
          //          $display("time = %0d, SCOREBOARD : correct result in AND operation" , $time);
//
          //  end
//
          //  // Checking OR operation
          //if (trans.operator_i == 0101110)
          //  begin
          //      
          //      if (trans.result_o != trans.operand_a_i | trans.operand_b_i)
          //      begin
          //          $display("time = %0d, SCOREBOARD : Error in OR operation" , $time);
          //      end
//
          //      end else begin
          //          $display("time = %0d, SCOREBOARD : correct result in OR operation" , $time);
//
          //  end
//
          //  // Checking XOR operation
          //if (trans.operator_i == 0101111)
          //  begin
          //      
          //      if (trans.result_o != trans.operand_a_i ^ trans.operand_b_i)
          //      begin
          //          $display("time = %0d, SCOREBOARD : Error in XOR operation" , $time);
          //      end
//
          //      end else begin
          //          $display("time = %0d, SCOREBOARD : correct result in XOR operation" , $time);
//
          //  end

             // sign extension for bytes
        always_comb begin
            case (rdata_offset_q)
            2'b00: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[7:0]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[7:0]};
                else rdata_b_ext = {{24{resp_rdata[7]}}, resp_rdata[7:0]};
            end

            2'b01: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[15:8]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[15:8]};
                else rdata_b_ext = {{24{resp_rdata[15]}}, resp_rdata[15:8]};
            end

            2'b10: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[23:16]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[23:16]};
                else rdata_b_ext = {{24{resp_rdata[23]}}, resp_rdata[23:16]};
            end

            2'b11: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[31:24]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[31:24]};
                else rdata_b_ext = {{24{resp_rdata[31]}}, resp_rdata[31:24]};
            end
            endcase  // case (rdata_offset_q)
        end

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            rdata_q <= '0;
            end
            else if (trans.trans.data_rvalid_i) begin
            case (data_type_q)
                2'b00: rdata_q <= rdata_w_ext[31:0];
                2'b01: rdata_q <= rdata_h_ext[31:0];
                2'b10, 2'b11: rdata_q <= rdata_b_ext[31:0];
            endcase
            end
        end

        ////////////////////////   LSU control ///////////////////////////
        logic ena_load, ena_store;
        logic rvalid_p, rvalid_n;

        always_comb begin
            ena_load = (data_type_q != 2'b00) || (trans.data_req_ex_i && !trans.data_we_ex_i && !trans.addr_useincr_ex_i);
            ena_store = (data_type_q != 2'b00) || (trans.data_req_ex_i && trans.data_we_ex_i && !trans.addr_useincr_ex_i);
            rvalid_p = trans.trans.data_rvalid_i && !trans.data_err_i && !trans.data_misaligned_ex_i;
            rvalid_n = trans.trans.data_rvalid_i && !trans.data_err_i && trans.data_misaligned_ex_i;
        end

        ////////////////////   LSU states ///////////////////////////
        logic [1:0] lsu_state_q, lsu_state_d;
        logic busy_o;
        logic [31:0] rdata_q;

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            lsu_state_q <= `LSU_STATE_IDLE;
            lsu_state_d <= `LSU_STATE_IDLE;
            end
            else begin
            lsu_state_q <= lsu_state_d;
            lsu_state_d <= (lsu_state_q == `LSU_STATE_IDLE && (ena_load || ena_store)) ? `LSU_STATE_ACCESS : `LSU_STATE_IDLE;
            end
        end

        assign busy_o = (lsu_state_q != `LSU_STATE_IDLE);

        ////////////////   LSU start and finish signals ////////////////////
        logic [1:0] p_elw_start_o, p_elw_finish_o;

        always_comb begin
            p_elw_start_o = {1'b0, lsu_state_d[0]};
            p_elw_finish_o = {1'b0, lsu_state_q[0]};
        end

        //////////////////////////   LSU memory //////////////////////////
        logic [31:0] mem [0:`MEM_SIZE];

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            mem <= '{default:32'hxxxx_xxxx};
            end
            else begin
            if (addr_aligend) begin
                if (trans.data_we_ex_i) mem[addr_ex_q] <= trans.data_wdata_ex_i;
                rdata_q <= mem[addr_ex_q];
            end
            else begin
                if (trans.data_we_ex_i) mem[addr_ex_q] <= '{default:32'hxxxx_xxxx};
                rdata_q <= '0;
            end
            end
        end

        //////////////////////////   LSU output ///////////////////////////
        logic [31:0] rdata_p, rdata_n;
        logic [2:0] resp_ex;
        logic [2:0] resp_rdata;
        logic [1:0] misaligned_st;

        assign rdata_p = (data_type_q == 2'b00) ? {16'hxxxx, mem[addr_ex_q][15:0]} : mem[addr_ex_q];
        assign rdata_n = (data_type_q == 2'b00) ? {16'hxxxx, mem[addr_ex_q + 4'h4][15:0]} : mem[addr_ex_q + 4'h4];

        // response generation
        always_comb begin
            if (addr_aligend) begin
            if (trans.trans.data_rvalid_i && !trans.data_err_i) resp_ex = `RESP_OKAY;
            else if (trans.trans.data_rvalid_i && trans.data_err_i) resp_ex = `RESP_ERROR;
            else resp_ex = `RESP_DV;
            end
            else begin
            if (trans.trans.data_rvalid_i && !trans.data_err_i && !trans.data_misaligned_ex_i) resp_ex = `RESP_ERROR;
            else if (trans.trans.data_rvalid_i && trans.data_err_i && !trans.data_misaligned_ex_i) resp_ex = `RESP_ERROR;
            else if (trans.trans.data_rvalid_i && !trans.data_err_i && trans.data_misaligned_ex_i) resp_ex = `RESP_MISALIGN;
            else resp_ex = `RESP_DV;
            end
        end

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            misaligned_st <= 2'b0;
            end
            else if (trans.data_misaligned_ex_i) begin
            if (trans.addr_useincr_ex_i) misaligned_st <= 2'b1;
            else misaligned_st <= 2'b0;
            end
        end

        always_comb begin
            if (misaligned_st == 2'b00) resp_rdata = resp_ex;
            else if (misaligned_st == 2'b01) resp_rdata = `RESP_OKAY;
            else if (misaligned_st == 2'b10) resp_rdata = `RESP_MISALIGN;
            else resp_rdata = `RESP_DV;
        end

        // final output mux
        always_comb begin
            case (lsu_state_q)
            `LSU_STATE_IDLE: begin
                p_err_o = 1'b0;
                p_err_type_o = 1'b0;
                p_rdata_o = '0;
            end

            `LSU_STATE_ACCESS: begin
                p_err_o = trans.data_err_i;
                p_err_type_o = data_err_type_i;
                p_rdata_o = (addr_aligend) ? rdata_q : '0;
            end
            endcase
        end

        /////////////////////   LSU read data path ///////////////////////
        logic [1:0] rdata_offset_q, rdata_offset_d;
        logic [1:0] data_sign_ext_q, data_sign_ext_d;
        logic [31:0] rdata_w_ext, rdata_h_ext, rdata_b_ext;

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            rdata_offset_q <= '0;
            rdata_offset_d <= '0;
            data_sign_ext_q <= '0;
            data_sign_ext_d <= '0;
            end
            else begin
            rdata_offset_q <= rdata_offset_d;
            rdata_offset_d <= addr_ex_q[1:0];
            data_sign_ext_q <= data_sign_ext_d;
            data_sign_ext_d <= trans.data_sign_ext_ex_i;
            end
        end

        // sign extension for words
        always_comb begin
            case (rdata_offset_q)
            2'b00: begin
                if (data_sign_ext_q == 2'b0) rdata_w_ext = {16'h0000, resp_rdata[15:0]};
                else if (data_sign_ext_q == 2'b10) rdata_w_ext = {16'hffff, resp_rdata[15:0]};
                else rdata_w_ext = {{16{resp_rdata[15]}}, resp_rdata[15:0]};
            end

            2'b01: begin
                if (data_sign_ext_q == 2'b0) rdata_w_ext = {16'h0000, resp_rdata[31:16]};
                else if (data_sign_ext_q == 2'b10) rdata_w_ext = {16'hffff, resp_rdata[31:16]};
                else rdata_w_ext = {{16{resp_rdata[31]}}, resp_rdata[31:16]};
            end
            endcase  // case (rdata_offset_q)
        end

        // sign extension for half-words
        always_comb begin
            case (rdata_offset_q)
            2'b00: begin
                if (data_sign_ext_q == 2'b00) rdata_h_ext = {24'h00_0000, resp_rdata[7:0]};
                else if (data_sign_ext_q == 2'b10) rdata_h_ext = {24'hff_ffff, resp_rdata[7:0]};
                else rdata_h_ext = {{24{resp_rdata[7]}}, resp_rdata[7:0]};
            end

            2'b01: begin
                if (data_sign_ext_q == 2'b00) rdata_h_ext = {24'h00_0000, resp_rdata[15:8]};
                else if (data_sign_ext_q == 2'b10) rdata_h_ext = {24'hff_ffff, resp_rdata[15:8]};
                else rdata_h_ext = {{24{resp_rdata[15]}}, resp_rdata[15:8]};
            end
            endcase  // case (rdata_offset_q)
        end

        // sign extension for bytes
        always_comb begin
            case (rdata_offset_q)
            2'b00: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[7:0]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[7:0]};
                else rdata_b_ext = {{24{resp_rdata[7]}}, resp_rdata[7:0]};
            end

            2'b01: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[15:8]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[15:8]};
                else rdata_b_ext = {{24{resp_rdata[15]}, resp_rdata[15:8]};
            end

            2'b10: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[23:16]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[23:16]};
                else rdata_b_ext = {{24{resp_rdata[23]}}, resp_rdata[23:16]};
            end

            2'b11: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[31:24]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[31:24]};
                else rdata_b_ext = {{24{resp_rdata[31]}}, resp_rdata[31:24]};
            end
            endcase  // case (rdata_offset_q)
        end

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            rdata_q <= '0;
            end
            else if (trans.trans.data_rvalid_i) begin
            case (data_type_q)
                2'b00: rdata_q <= rdata_w_ext[31:0];
                2'b01: rdata_q <= rdata_h_ext[31:0];
                2'b10, 2'b11: rdata_q <= rdata_b_ext[31:0];
            endcase
            end
        end

        ////////////////////////   LSU control ///////////////////////////
        logic ena_load, ena_store;
        logic rvalid_p, rvalid_n;

        always_comb begin
            ena_load = (data_type_q != 2'b00) || (trans.data_req_ex_i && !trans.data_we_ex_i && !trans.addr_useincr_ex_i);
            ena_store = (data_type_q != 2'b00) || (trans.data_req_ex_i && trans.data_we_ex_i && !trans.addr_useincr_ex_i);
            rvalid_p = trans.trans.data_rvalid_i && !trans.data_err_i && !trans.data_misaligned_ex_i;
            rvalid_n = trans.trans.data_rvalid_i && !trans.data_err_i && trans.data_misaligned_ex_i;
        end

        ////////////////////   LSU states ///////////////////////////
        logic [1:0] lsu_state_q, lsu_state_d;
        logic busy_o;
        logic [31:0] rdata_q;

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            lsu_state_q <= `LSU_STATE_IDLE;
            lsu_state_d <= `LSU_STATE_IDLE;
            end
            else begin
            lsu_state_q <= lsu_state_d;
            lsu_state_d <= (lsu_state_q == `LSU_STATE_IDLE && (ena_load || ena_store)) ? `LSU_STATE_ACCESS : `LSU_STATE_IDLE;
            end
        end

        assign busy_o = (lsu_state_q != `LSU_STATE_IDLE);

        ////////////////   LSU start and finish signals ////////////////////
        logic [1:0] p_elw_start_o, p_elw_finish_o;

        always_comb begin
            p_elw_start_o = {1'b0, lsu_state_d[0]};
            p_elw_finish_o = {1'b0, lsu_state_q[0]};
        end

        //////////////////////////   LSU memory //////////////////////////
        logic [31:0] mem [0:`MEM_SIZE];

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            mem <= '{default:32'hxxxx_xxxx};
            end
            else begin
            if (addr_aligend) begin
                if (trans.data_we_ex_i) mem[addr_ex_q] <= trans.data_wdata_ex_i;
                rdata_q <= mem[addr_ex_q];
            end
            else begin
                if (trans.data_we_ex_i) mem[addr_ex_q] <= '{default:32'hxxxx_xxxx};
                rdata_q <= '0;
            end
            end
        end

        //////////////////////////   LSU output ///////////////////////////
        logic [31:0] rdata_p, rdata_n;
        logic [2:0] resp_ex;
        logic [2:0] resp_rdata;
        logic [1:0] misaligned_st;

        assign rdata_p = (data_type_q == 2'b00) ? {16'hxxxx, mem[addr_ex_q][15:0]} : mem[addr_ex_q];
        assign rdata_n = (data_type_q == 2'b00) ? {16'hxxxx, mem[addr_ex_q + 4'h4][15:0]} : mem[addr_ex_q + 4'h4];

        // response generation
        always_comb begin
            if (addr_aligend) begin
            if (trans.trans.data_rvalid_i && !trans.data_err_i) resp_ex = `RESP_OKAY;
            else if (trans.trans.data_rvalid_i && trans.data_err_i) resp_ex = `RESP_ERROR;
            else resp_ex = `RESP_DV;
            end
            else begin
            if (trans.trans.data_rvalid_i && !trans.data_err_i && !trans.data_misaligned_ex_i) resp_ex = `RESP_ERROR;
            else if (trans.trans.data_rvalid_i && trans.data_err_i && !trans.data_misaligned_ex_i) resp_ex = `RESP_ERROR;
            else if (trans.trans.data_rvalid_i && !trans.data_err_i && trans.data_misaligned_ex_i) resp_ex = `RESP_MISALIGN;
            else resp_ex = `RESP_DV;
            end
        end

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            misaligned_st <= 2'b0;
            end
            else if (trans.data_misaligned_ex_i) begin
            if (trans.addr_useincr_ex_i) misaligned_st <= 2'b1;
            else misaligned_st <= 2'b0;
            end
        end

        always_comb begin
            if (misaligned_st == 2'b00) resp_rdata = resp_ex;
            else if (misaligned_st == 2'b01) resp_rdata = `RESP_OKAY;
            else if (misaligned_st == 2'b10) resp_rdata = `RESP_MISALIGN;
            else resp_rdata = `RESP_DV;
        end

        // final output mux
        always_comb begin
            case (lsu_state_q)
            `LSU_STATE_IDLE: begin
                p_err_o = 1'b0;
                p_err_type_o = 1'b0;
                p_rdata_o = '0;
            end

            `LSU_STATE_ACCESS: begin
                p_err_o = trans.data_err_i;
                p_err_type_o = data_err_type_i;
                p_rdata_o = (addr_aligend) ? rdata_q : '0;
            end
            endcase
        end

        /////////////////////   LSU read data path ///////////////////////
        logic [1:0] rdata_offset_q, rdata_offset_d;
        logic [1:0] data_sign_ext_q, data_sign_ext_d;
        logic [31:0] rdata_w_ext, rdata_h_ext, rdata_b_ext;

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            rdata_offset_q <= '0;
            rdata_offset_d <= '0;
            data_sign_ext_q <= '0;
            data_sign_ext_d <= '0;
            end
            else begin
            rdata_offset_q <= rdata_offset_d;
            rdata_offset_d <= addr_ex_q[1:0];
            data_sign_ext_q <= data_sign_ext_d;
            data_sign_ext_d <= trans.data_sign_ext_ex_i;
            end
        end

        // sign extension for words
        always_comb begin
            case (rdata_offset_q)
            2'b00: begin
                if (data_sign_ext_q == 2'b0) rdata_w_ext = {16'h0000, resp_rdata[15:0]};
                else if (data_sign_ext_q == 2'b10) rdata_w_ext = {16'hffff, resp_rdata[15:0]};
                else rdata_w_ext = {{16{resp_rdata[15]}}, resp_rdata[15:0]};
            end

            2'b01: begin
                if (data_sign_ext_q == 2'b0) rdata_w_ext = {16'h0000, resp_rdata[31:16]};
                else if (data_sign_ext_q == 2'b10) rdata_w_ext = {16'hffff, resp_rdata[31:16]};
                else rdata_w_ext = {{16{resp_rdata[31]}}, resp_rdata[31:16]};
            end
            endcase  // case (rdata_offset_q)
        end

        // sign extension for half-words
        always_comb begin
            case (rdata_offset_q)
            2'b00: begin
                if (data_sign_ext_q == 2'b00) rdata_h_ext = {24'h00_0000, resp_rdata[7:0]};
                else if (data_sign_ext_q == 2'b10) rdata_h_ext = {24'hff_ffff, resp_rdata[7:0]};
                else rdata_h_ext = {{24{resp_rdata[7]}}, resp_rdata[7:0]};
            end

            2'b01: begin
                if (data_sign_ext_q == 2'b00) rdata_h_ext = {24'h00_0000, resp_rdata[15:8]};
                else if (data_sign_ext_q == 2'b10) rdata_h_ext = {24'hff_ffff, resp_rdata[15:8]};
                else rdata_h_ext = {{24{resp_rdata[15]}}, resp_rdata[15:8]};
            end

            2'b10: begin
                if (data_sign_ext_q == 2'b00) rdata_h_ext = {24'h00_0000, resp_rdata[23:16]};
                else if (data_sign_ext_q == 2'b10) rdata_h_ext = {24'hff_ffff, resp_rdata[23:16]};
                else rdata_h_ext = {{24{resp_rdata[23]}}, resp_rdata[23:16]};
            end

            2'b11: begin
                if (data_sign_ext_q == 2'b00) rdata_h_ext = {24'h00_0000, resp_rdata[31:24]};
                else if (data_sign_ext_q == 2'b10) rdata_h_ext = {24'hff_ffff, resp_rdata[31:24]};
                else rdata_h_ext = {{24{resp_rdata[31]}}, resp_rdata[31:24]};
            end
            endcase  // case (rdata_offset_q)
        end

        // sign extension for bytes
        always_comb begin
            case (rdata_offset_q)
            2'b00: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[7:0]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[7:0]};
                else rdata_b_ext = {{24{resp_rdata[7]}}, resp_rdata[7:0]};
            end

            2'b01: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[15:8]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[15:8]};
                else rdata_b_ext = {{24{resp_rdata[15]}}, resp_rdata[15:8]};
            end

            2'b10: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[23:16]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[23:16]};
                else rdata_b_ext = {{24{resp_rdata[23]}}, resp_rdata[23:16]};
            end

            2'b11: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[31:24]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[31:24]};
                else rdata_b_ext = {{24{resp_rdata[31]}}, resp_rdata[31:24]};
            end
            endcase  // case (rdata_offset_q)
        end

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            rdata_q <= '0;
            end
            else if (trans.trans.data_rvalid_i) begin
            case (data_type_q)
                2'b00: rdata_q <= rdata_w_ext[31:0];
                2'b01: rdata_q <= rdata_h_ext[31:0];
                2'b10, 2'b11: rdata_q <= rdata_b_ext[31:0];
            endcase
            end
        end

        ////////////////////////   LSU control ///////////////////////////
        logic ena_load, ena_store;
        logic rvalid_p, rvalid_n;

        always_comb begin
            ena_load = (data_type_q != 2'b00) || (trans.data_req_ex_i && !trans.data_we_ex_i && !trans.addr_useincr_ex_i);
            ena_store = (data_type_q != 2'b00) || (trans.data_req_ex_i && trans.data_we_ex_i && !trans.addr_useincr_ex_i);
            rvalid_p = trans.trans.data_rvalid_i && !trans.data_err_i && !trans.data_misaligned_ex_i;
            rvalid_n = trans.trans.data_rvalid_i && !trans.data_err_i && trans.data_misaligned_ex_i;
        end

        ////////////////////   LSU states ///////////////////////////
        logic [1:0] lsu_state_q, lsu_state_d;
        logic busy_o;
        logic [31:0] rdata_q;

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            lsu_state_q <= `LSU_STATE_IDLE;
            lsu_state_d <= `LSU_STATE_IDLE;
            end
            else begin
            lsu_state_q <= lsu_state_d;
            lsu_state_d <= (lsu_state_q == `LSU_STATE_IDLE && (ena_load || ena_store)) ? `LSU_STATE_ACCESS : `LSU_STATE_IDLE;
            end
        end

        assign busy_o = (lsu_state_q != `LSU_STATE_IDLE);

        ////////////////   LSU start and finish signals ////////////////////
        logic [1:0] p_elw_start_o, p_elw_finish_o;

        always_comb begin
            p_elw_start_o = {1'b0, lsu_state_d[0]};
            p_elw_finish_o = {1'b0, lsu_state_q[0]};
        end

        //////////////////////////   LSU memory //////////////////////////
        logic [31:0] mem [0:`MEM_SIZE];

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            mem <= '{default:32'hxxxx_xxxx};
            end
            else begin
            if (addr_aligend) begin
                if (trans.data_we_ex_i) mem[addr_ex_q] <= trans.data_wdata_ex_i;
                rdata_q <= mem[addr_ex_q];
            end
            else begin
                if (trans.data_we_ex_i) mem[addr_ex_q] <= '{default:32'hxxxx_xxxx};
                rdata_q <= '0;
            end
            end
        end

        //////////////////////////   LSU output ///////////////////////////
        logic [31:0] rdata_p, rdata_n;
        logic [2:0] resp_ex;
        logic [2:0] resp_rdata;
        logic [1:0] misaligned_st;

        assign rdata_p = (data_type_q == 2'b00) ? {16'hxxxx, mem[addr_ex_q][15:0]} : mem[addr_ex_q];
        assign rdata_n = (data_type_q == 2'b00) ? {16'hxxxx, mem[addr_ex_q + 4'h4][15:0]} : mem[addr_ex_q + 4'h4];

        // response generation
        always_comb begin
            if (addr_aligend) begin
            if (trans.trans.data_rvalid_i && !trans.data_err_i) resp_ex = `RESP_OKAY;
            else if (trans.trans.data_rvalid_i && trans.data_err_i) resp_ex = `RESP_ERROR;
            else resp_ex = `RESP_DV;
            end
            else begin
            if (trans.trans.data_rvalid_i && !trans.data_err_i && !trans.data_misaligned_ex_i) resp_ex = `RESP_ERROR;
            else if (trans.trans.data_rvalid_i && trans.data_err_i && !trans.data_misaligned_ex_i) resp_ex = `RESP_ERROR;
            else if (trans.trans.data_rvalid_i && !trans.data_err_i && trans.data_misaligned_ex_i) resp_ex = `RESP_MISALIGN;
            else resp_ex = `RESP_DV;
            end
        end

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            misaligned_st <= 2'b0;
            end
            else if (trans.data_misaligned_ex_i) begin
            if (trans.addr_useincr_ex_i) misaligned_st <= 2'b1;
            else misaligned_st <= 2'b0;
            end
        end

        always_comb begin
            if (misaligned_st == 2'b00) resp_rdata = resp_ex;
            else if (misaligned_st == 2'b01) resp_rdata = `RESP_OKAY;
            else if (misaligned_st == 2'b10) resp_rdata = `RESP_MISALIGN;
            else resp_rdata = `RESP_DV;
        end

        // final output mux
        always_comb begin
            case (lsu_state_q)
            `LSU_STATE_IDLE: begin
                p_err_o = 1'b0;
                p_err_type_o = 1'b0;
                p_rdata_o = '0;
            end

            `LSU_STATE_ACCESS: begin
                p_err_o = trans.data_err_i;
                p_err_type_o = data_err_type_i;
                p_rdata_o = (addr_aligend) ? rdata_q : '0;
            end
            endcase
        end

        /////////////////////   LSU read data path ///////////////////////
        logic [1:0] rdata_offset_q, rdata_offset_d;
        logic [1:0] data_sign_ext_q, data_sign_ext_d;
        logic [31:0] rdata_w_ext, rdata_h_ext, rdata_b_ext;

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            rdata_offset_q <= '0;
            rdata_offset_d <= '0;
            data_sign_ext_q <= '0;
            data_sign_ext_d <= '0;
            end
            else begin
            rdata_offset_q <= rdata_offset_d;
            rdata_offset_d <= addr_ex_q[1:0];
            data_sign_ext_q <= data_sign_ext_d;
            data_sign_ext_d <= trans.data_sign_ext_ex_i;
            end
        end

        // sign extension for words
        always_comb begin
            case (rdata_offset_q)
            2'b00: begin
                if (data_sign_ext_q == 2'b0) rdata_w_ext = {16'h0000, resp_rdata[15:0]};
                else if (data_sign_ext_q == 2'b10) rdata_w_ext = {16'hffff, resp_rdata[15:0]};
                else rdata_w_ext = {{16{resp_rdata[15]}}, resp_rdata[15:0]};
            end

            2'b01: begin
                if (data_sign_ext_q == 2'b0) rdata_w_ext = {16'h0000, resp_rdata[31:16]};
                else if (data_sign_ext_q == 2'b10) rdata_w_ext = {16'hffff, resp_rdata[31:16]};
                else rdata_w_ext = {{16{resp_rdata[31]}}, resp_rdata[31:16]};
            end
            endcase  // case (rdata_offset_q)
        end

        // sign extension for half-words
        always_comb begin
            case (rdata_offset_q)
            2'b00: begin
                if (data_sign_ext_q == 2'b00) rdata_h_ext = {24'h00_0000, resp_rdata[7:0]};
                else if (data_sign_ext_q == 2'b10) rdata_h_ext = {24'hff_ffff, resp_rdata[7:0]};
                else rdata_h_ext = {{24{resp_rdata[7]}}, resp_rdata[7:0]};
            end

            2'b01: begin
                if (data_sign_ext_q == 2'b00) rdata_h_ext = {24'h00_0000, resp_rdata[15:8]};
                else if (data_sign_ext_q == 2'b10) rdata_h_ext = {24'hff_ffff, resp_rdata[15:8]};
                else rdata_h_ext = {{24{resp_rdata[15]}}, resp_rdata[15:8]};
            end

            2'b10: begin
                if (data_sign_ext_q == 2'b00) rdata_h_ext = {24'h00_0000, resp_rdata[23:16]};
                else if (data_sign_ext_q == 2'b10) rdata_h_ext = {24'hff_ffff, resp_rdata[23:16]};
                else rdata_h_ext = {{24{resp_rdata[23]}}, resp_rdata[23:16]};
            end

            2'b11: begin
                if (data_sign_ext_q == 2'b00) rdata_h_ext = {24'h00_0000, resp_rdata[31:24]};
                else if (data_sign_ext_q == 2'b10) rdata_h_ext = {24'hff_ffff, resp_rdata[31:24]};
                else rdata_h_ext = {{24{resp_rdata[31]}}, resp_rdata[31:24]};
            end
            endcase  // case (rdata_offset_q)
        end

        // sign extension for bytes
        always_comb begin
            case (rdata_offset_q)
            2'b00: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[7:0]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[7:0]};
                else rdata_b_ext = {{24{resp_rdata[7]}}, resp_rdata[7:0]};
            end

            2'b01: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[15:8]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[15:8]};
                else rdata_b_ext = {{24{resp_rdata[15]}}, resp_rdata[15:8]};
            end

            2'b10: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[23:16]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[23:16]};
                else rdata_b_ext = {{24{resp_rdata[23]}}, resp_rdata[23:16]};
            end

            2'b11: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[31:24]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[31:24]};
                else rdata_b_ext = {{24{resp_rdata[31]}}, resp_rdata[31:24]};
            end
            endcase  // case (rdata_offset_q)
        end

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            rdata_q <= '0;
            end
            else if (trans.trans.data_rvalid_i) begin
            case (data_type_q)
                2'b00: rdata_q <= rdata_w_ext[31:0];
                2'b01: rdata_q <= rdata_h_ext[31:0];
                2'b10, 2'b11: rdata_q <= rdata_b_ext[31:0];
            endcase
            end
        end

        ////////////////////////   LSU control ///////////////////////////
        logic ena_load, ena_store;
        logic rvalid_p, rvalid_n;

        always_comb begin
            ena_load = (data_type_q != 2'b00) || (trans.data_req_ex_i && !trans.data_we_ex_i && !trans.addr_useincr_ex_i);
            ena_store = (data_type_q != 2'b00) || (trans.data_req_ex_i && trans.data_we_ex_i && !trans.addr_useincr_ex_i);
            rvalid_p = trans.trans.data_rvalid_i && !trans.data_err_i && !trans.data_misaligned_ex_i;
            rvalid_n = trans.trans.data_rvalid_i && !trans.data_err_i && trans.data_misaligned_ex_i;
        end

        ////////////////////   LSU states ///////////////////////////
        logic [1:0] lsu_state_q, lsu_state_d;
        logic busy_o;
        logic [31:0] rdata_q;

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            lsu_state_q <= `LSU_STATE_IDLE;
            lsu_state_d <= `LSU_STATE_IDLE;
            end
            else begin
            lsu_state_q <= lsu_state_d;
            lsu_state_d <= (lsu_state_q == `LSU_STATE_IDLE && (ena_load || ena_store)) ? `LSU_STATE_ACCESS : `LSU_STATE_IDLE;
            end
        end

        assign busy_o = (lsu_state_q != `LSU_STATE_IDLE);

        ////////////////   LSU start and finish signals ////////////////////
        logic [1:0] p_elw_start_o, p_elw_finish_o;

        always_comb begin
            p_elw_start_o = {1'b0, lsu_state_d[0]};
            p_elw_finish_o = {1'b0, lsu_state_q[0]};
        end

        //////////////////////////   LSU memory //////////////////////////
        logic [31:0] mem [0:`MEM_SIZE];

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            mem <= '{default:32'hxxxx_xxxx};
            end
            else begin
            if (addr_aligend) begin
                if (trans.data_we_ex_i) mem[addr_ex_q] <= trans.data_wdata_ex_i;
                rdata_q <= mem[addr_ex_q];
            end
            else begin
                if (trans.data_we_ex_i) mem[addr_ex_q] <= '{default:32'hxxxx_xxxx};
                rdata_q <= '0;
            end
            end
        end

        //////////////////////////   LSU output ///////////////////////////
        logic [31:0] rdata_p, rdata_n;
        logic [2:0] resp_ex;
        logic [2:0] resp_rdata;
        logic [1:0] misaligned_st;

        assign rdata_p = (data_type_q == 2'b00) ? {16'hxxxx, mem[addr_ex_q][15:0]} : mem[addr_ex_q];
        assign rdata_n = (data_type_q == 2'b00) ? {16'hxxxx, mem[addr_ex_q + 4'h4][15:0]} : mem[addr_ex_q + 4'h4];

        // response generation
        always_comb begin
            if (addr_aligend) begin
            if (trans.trans.data_rvalid_i && !trans.data_err_i) resp_ex = `RESP_OKAY;
            else if (trans.trans.data_rvalid_i && trans.data_err_i) resp_ex = `RESP_ERROR;
            else resp_ex = `RESP_DV;
            end
            else begin
            if (trans.trans.data_rvalid_i && !trans.data_err_i && !trans.data_misaligned_ex_i) resp_ex = `RESP_ERROR;
            else if (trans.trans.data_rvalid_i && trans.data_err_i && !trans.data_misaligned_ex_i) resp_ex = `RESP_ERROR;
            else if (trans.trans.data_rvalid_i && !trans.data_err_i && trans.data_misaligned_ex_i) resp_ex = `RESP_MISALIGN;
            else if (trans.trans.data_rvalid_i && trans.data_err_i && trans.data_misaligned_ex_i) resp_ex = `RESP_MISALIGN;
            else resp_ex = `RESP_DV;
            end
        end

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            misaligned_st <= 2'b0;
            end
            else if (trans.data_misaligned_ex_i) begin
            if (trans.addr_useincr_ex_i) misaligned_st <= 2'b1;
            else misaligned_st <= 2'b0;
            end
        end

        always_comb begin
            if (misaligned_st == 2'b00) resp_rdata = resp_ex;
            else if (misaligned_st == 2'b01) resp_rdata = `RESP_OKAY;
            else if (misaligned_st == 2'b10) resp_rdata = `RESP_MISALIGN;
            else resp_rdata = `RESP_DV;
        end

        // final output mux
        always_comb begin
            case (lsu_state_q)
            `LSU_STATE_IDLE: begin
                p_err_o = 1'b0;
                p_err_type_o = 1'b0;
                p_rdata_o = '0;
            end

            `LSU_STATE_ACCESS: begin
                p_err_o = trans.data_err_i;
                p_err_type_o = data_err_type_i;
                p_rdata_o = (addr_aligend) ? rdata_q : '0;
            end
            endcase
        end

        /////////////////////   LSU read data path ///////////////////////
        logic [1:0] rdata_offset_q, rdata_offset_d;
        logic [1:0] data_sign_ext_q, data_sign_ext_d;
        logic [31:0] rdata_w_ext, rdata_h_ext, rdata_b_ext;

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            rdata_offset_q <= '0;
            rdata_offset_d <= '0;
            data_sign_ext_q <= '0;
            data_sign_ext_d <= '0;
            end
            else begin
            rdata_offset_q <= rdata_offset_d;
            rdata_offset_d <= addr_ex_q[1:0];
            data_sign_ext_q <= data_sign_ext_d;
            data_sign_ext_d <= trans.data_sign_ext_ex_i;
            end
        end

        // sign extension for words
        always_comb begin
            case (rdata_offset_q)
            2'b00: begin
                if (data_sign_ext_q == 2'b0) rdata_w_ext = {16'h0000, resp_rdata[15:0]};
                else if (data_sign_ext_q == 2'b10) rdata_w_ext = {16'hffff, resp_rdata[15:0]};
                else rdata_w_ext = {{16{resp_rdata[15]}}, resp_rdata[15:0]};
            end

            2'b01: begin
                if (data_sign_ext_q == 2'b0) rdata_w_ext = {16'h0000, resp_rdata[31:16]};
                else if (data_sign_ext_q == 2'b10) rdata_w_ext = {16'hffff, resp_rdata[31:16]};
                else rdata_w_ext = {{16{resp_rdata[31]}}, resp_rdata[31:16]};
            end
            endcase  // case (rdata_offset_q)
        end

        // sign extension for half-words
        always_comb begin
            case (rdata_offset_q)
            2'b00: begin
                if (data_sign_ext_q == 2'b00) rdata_h_ext = {24'h00_0000, resp_rdata[7:0]};
                else if (data_sign_ext_q == 2'b10) rdata_h_ext = {24'hff_ffff, resp_rdata[7:0]};
                else rdata_h_ext = {{24{resp_rdata[7]}}, resp_rdata[7:0]};
            end

            2'b01: begin
                if (data_sign_ext_q == 2'b00) rdata_h_ext = {24'h00_0000, resp_rdata[15:8]};
                else if (data_sign_ext_q == 2'b10) rdata_h_ext = {24'hff_ffff, resp_rdata[15:8]};
                else rdata_h_ext = {{24{resp_rdata[15]}}, resp_rdata[15:8]};
            end

            2'b10: begin
                if (data_sign_ext_q == 2'b00) rdata_h_ext = {24'h00_0000, resp_rdata[23:16]};
                else if (data_sign_ext_q == 2'b10) rdata_h_ext = {24'hff_ffff, resp_rdata[23:16]};
                else rdata_h_ext = {{24{resp_rdata[23]}}, resp_rdata[23:16]};
            end

            2'b11: begin
                if (data_sign_ext_q == 2'b00) rdata_h_ext = {24'h00_0000, resp_rdata[31:24]};
                else if (data_sign_ext_q == 2'b10) rdata_h_ext = {24'hff_ffff, resp_rdata[31:24]};
                else rdata_h_ext = {{24{resp_rdata[31]}}, resp_rdata[31:24]};
            end
            endcase  // case (rdata_offset_q)
        end

        // sign extension for bytes
        always_comb begin
            case (rdata_offset_q)
            2'b00: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[7:0]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[7:0]};
                else rdata_b_ext = {{24{resp_rdata[7]}}, resp_rdata[7:0]};
            end

            2'b01: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[15:8]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[15:8]};
                else rdata_b_ext = {{24{resp_rdata[15]}}, resp_rdata[15:8]};
            end

            2'b10: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[23:16]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[23:16]};
                else rdata_b_ext = {{24{resp_rdata[23]}}, resp_rdata[23:16]};
            end

            2'b11: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[31:24]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[31:24]};
                else rdata_b_ext = {{24{resp_rdata[31]}}, resp_rdata[31:24]};
            end
            endcase  // case (rdata_offset_q)
        end

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            rdata_q <= '0;
            end
            else if (trans.trans.data_rvalid_i) begin
            case (data_type_q)
                2'b00: rdata_q <= rdata_w_ext[31:0];
                2'b01: rdata_q <= rdata_h_ext[31:0];
                2'b10, 2'b11: rdata_q <= rdata_b_ext[31:0];
            endcase
            end
        end

        ////////////////////////   LSU control ///////////////////////////
        logic ena_load, ena_store;
        logic rvalid_p, rvalid_n;

        always_comb begin
            ena_load = (data_type_q != 2'b00) || (trans.data_req_ex_i && !trans.data_we_ex_i && !trans.addr_useincr_ex_i);
            ena_store = (data_type_q != 2'b00) || (trans.data_req_ex_i && trans.data_we_ex_i && !trans.addr_useincr_ex_i);
            rvalid_p = trans.data_rvalid_i && !trans.data_err_i && !trans.data_misaligned_ex_i;
            rvalid_n = trans.data_rvalid_i && !trans.data_err_i && trans.data_misaligned_ex_i;
        end

        ////////////////////   LSU states ///////////////////////////
        logic [1:0] lsu_state_q, lsu_state_d;
        logic busy_o;
        logic [31:0] rdata_q;

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            lsu_state_q <= `LSU_STATE_IDLE;
            lsu_state_d <= `LSU_STATE_IDLE;
            end
            else begin
            lsu_state_q <= lsu_state_d;
            lsu_state_d <= (lsu_state_q == `LSU_STATE_IDLE && (ena_load || ena_store)) ? `LSU_STATE_ACCESS : `LSU_STATE_IDLE;
            end
        end

        assign busy_o = (lsu_state_q != `LSU_STATE_IDLE);

        ////////////////   LSU start and finish signals ////////////////////
        logic [1:0] p_elw_start_o, p_elw_finish_o;

        always_comb begin
            p_elw_start_o = {1'b0, lsu_state_d[0]};
            p_elw_finish_o = {1'b0, lsu_state_q[0]};
        end

        //////////////////////////   LSU memory //////////////////////////
        logic [31:0] mem [0:`MEM_SIZE];

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            mem <= '{default:32'hxxxx_xxxx};
            end
            else begin
            if (addr_aligned) begin
                if (trans.data_we_ex_i) mem[addr_ex_q] <= trans.data_wdata_ex_i;
                rdata_q <= mem[addr_ex_q];
            end
            else begin
                if (trans.data_we_ex_i) mem[addr_ex_q] <= '{default:32'hxxxx_xxxx};
                rdata_q <= '0;
            end
            end
        end

        //////////////////////////   LSU output ///////////////////////////
        logic [31:0] rdata_p, rdata_n;
        logic [2:0] resp_ex;
        logic [2:0] resp_rdata;
        logic [1:0] misaligned_st;

        assign rdata_p = (data_type_q == 2'b00) ? {16'hxxxx, mem[addr_ex_q][15:0]} : mem[addr_ex_q];
        assign rdata_n = (data_type_q == 2'b00) ? {16'hxxxx, mem[addr_ex_q + 4'h4][15:0]} : mem[addr_ex_q + 4'h4];

        // response generation
        always_comb begin
            if (addr_aligned) begin
            if (trans.data_rvalid_i && !trans.data_err_i) resp_ex = `RESP_OKAY;
            else if (trans.data_rvalid_i && trans.data_err_i) resp_ex = `RESP_ERROR;
            else resp_ex = `RESP_DV;
            end
            else begin
            if (trans.data_rvalid_i && !trans.data_err_i && !trans.data_misaligned_ex_i) resp_ex = `RESP_ERROR;
            else if (trans.data_rvalid_i && trans.data_err_i && !trans.data_misaligned_ex_i) resp_ex = `RESP_ERROR;
            else if (trans.data_rvalid_i && !trans.data_err_i && trans.data_misaligned_ex_i) resp_ex = `RESP_MISALIGN;
            else if (trans.data_rvalid_i && trans.data_err_i && trans.data_misaligned_ex_i) resp_ex = `RESP_MISALIGN;
            else resp_ex = `RESP_DV;
            end
        end

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            misaligned_st <= 2'b0;
            end
            else if (trans.data_misaligned_ex_i) begin
            if (trans.addr_useincr_ex_i) misaligned_st <= 2'b1;
            else misaligned_st <= 2'b0;
            end
        end

        always_comb begin
            if (misaligned_st == 2'b00) resp_rdata = resp_ex;
            else if (misaligned_st == 2'b01) resp_rdata = `RESP_OKAY;
            else if (misaligned_st == 2'b10) resp_rdata = `RESP_MISALIGN;
            else resp_rdata = `RESP_DV;
        end

        // final output mux
        always_comb begin
            case (lsu_state_q)
            `LSU_STATE_IDLE: begin
                p_err_o = 1'b0;
                p_err_type_o = 1'b0;
                p_rdata_o = '0;
            end

            `LSU_STATE_ACCESS: begin
                p_err_o = trans.data_err_i;
                p_err_type_o = data_err_type_i;
                p_rdata_o = (addr_aligned) ? rdata_q : '0;
            end
            endcase
        end

        /////////////////////   LSU read data path ///////////////////////
        logic [1:0] rdata_offset_q, rdata_offset_d;
        logic [1:0] data_sign_ext_q, data_sign_ext_d;
        logic [31:0] rdata_w_ext, rdata_h_ext, rdata_b_ext;

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
            rdata_offset_q <= '0;
            rdata_offset_d <= '0;
            data_sign_ext_q <= '0;
            data_sign_ext_d <= '0;
            end
            else begin
            rdata_offset_q <= rdata_offset_d;
            rdata_offset_d <= addr_ex_q[1:0];
            data_sign_ext_q <= data_sign_ext_d;
            data_sign_ext_d <= trans.data_sign_ext_ex_i;
            end
        end

        // sign extension for words
        always_comb begin
            case (rdata_offset_q)
            2'b00: begin
                if (data_sign_ext_q == 2'b0) rdata_w_ext = {16'h0000, resp_rdata[15:0]};
                else if (data_sign_ext_q == 2'b10) rdata_w_ext = {16'hffff, resp_rdata[15:0]};
                else rdata_w_ext = {{16{resp_rdata[15]}}, resp_rdata[15:0]};
            end

            2'b01: begin
                if (data_sign_ext_q == 2'b0) rdata_w_ext = {16'h0000, resp_rdata[31:16]};
                else if (data_sign_ext_q == 2'b10) rdata_w_ext = {16'hffff, resp_rdata[31:16]};
                else rdata_w_ext = {{16{resp_rdata[31]}}, resp_rdata[31:16]};
            end
            endcase  // case (rdata_offset_q)
        end

        // sign extension for half-words
        always_comb begin
            case (rdata_offset_q)
            2'b00: begin
                if (data_sign_ext_q == 2'b00) rdata_h_ext = {24'h00_0000, resp_rdata[7:0]};
                else if (data_sign_ext_q == 2'b10) rdata_h_ext = {24'hff_ffff, resp_rdata[7:0]};
                else rdata_h_ext = {{24{resp_rdata[7]}}, resp_rdata[7:0]};
            end

            2'b01: begin
                if (data_sign_ext_q == 2'b00) rdata_h_ext = {24'h00_0000, resp_rdata[15:8]};
                else if (data_sign_ext_q == 2'b10) rdata_h_ext = {24'hff_ffff, resp_rdata[15:8]};
                else rdata_h_ext = {{24{resp_rdata[15]}}, resp_rdata[15:8]};
            end

            2'b10: begin
                if (data_sign_ext_q == 2'b00) rdata_h_ext = {24'h00_0000, resp_rdata[23:16]};
                else if (data_sign_ext_q == 2'b10) rdata_h_ext = {24'hff_ffff, resp_rdata[23:16]};
                else rdata_h_ext = {{24{resp_rdata[23]}}, resp_rdata[23:16]};
            end

            2'b11: begin
                if (data_sign_ext_q == 2'b00) rdata_h_ext = {24'h00_0000, resp_rdata[31:24]};
                else if (data_sign_ext_q == 2'b10) rdata_h_ext = {24'hff_ffff, resp_rdata[31:24]};
                else rdata_h_ext = {{24{resp_rdata[31]}}, resp_rdata[31:24]};
            end
            endcase  // case (rdata_offset_q)
        end

        // sign extension for bytes
        always_comb begin
            case (rdata_offset_q)
            2'b00: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[7:0]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[7:0]};
                else rdata_b_ext = {{24{resp_rdata[7]}}, resp_rdata[7:0]};
            end

            2'b01: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[15:8]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[15:8]};
                else rdata_b_ext = {{24{resp_rdata[15]}}, resp_rdata[15:8]};
                end
            2'b10: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[23:16]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[23:16]};
                else rdata_b_ext = {{24{resp_rdata[23]}}, resp_rdata[23:16]};
            end

            2'b11: begin
                if (data_sign_ext_q == 2'b00) rdata_b_ext = {24'h00_0000, resp_rdata[31:24]};
                else if (data_sign_ext_q == 2'b10) rdata_b_ext = {24'hff_ffff, resp_rdata[31:24]};
                else rdata_b_ext = {{24{resp_rdata[31]}}, resp_rdata[31:24]};
            end
            endcase  // case (rdata_offset_q)
            end

        always_ff @(posedge clk, negedge rst_n) begin
            if (rst_n == 1'b0) begin
                rdata_q <= '0;
            end
            else if (trans.data_rvalid_i) begin
                case (data_type_q)
                2'b00: rdata_q <= rdata_w_ext[31:0];
                2'b01: rdata_q <= rdata_h_ext[31:0];
                2'b10, 2'b11: rdata_q <= rdata_b_ext[31:0];
                endcase
            end
        end

            if (trans.data_gnt_i == 1'b1)
            begin
                if (addr_valid_checker(trans.data_rdata_i) == TRUE )
                begin 
                    $display("time = %0d, SCOREBOARD : Testcase Passed - data_rdata_i is validated", $time);
                    if (trans.data_rvalid_i == 1'b1)
                    begin
                        $display("time = %0d, SCOREBOARD : Testcase Passed - data_rvalid_i is validated", $time);
                    end
                        if (flag == 0) // LOAD OPCODE
                        begin
                            if (addr_valid_checker(trans.data_addr_o) == TRUE && be_gen_checker(trans.data_be_o) == TRUE && trans.data_we_o == 1'b0)
                            begin
                                $display("time = %0d, SCOREBOARD : Testcase Passed - data_addr_o, trans.data_be_o, data_we_o is validated", $time);
                                if (trans.data_req_o == 1'b1)
                                begin
                                    $display("time = %0d, SCOREBOARD : Testcase Passed - data_req_o is validated", $time);
                                end
                                else
                                begin
                                    $display("time = %0d, SCOREBOARD : Testcase Failed - data_req_o should be 1'b1", $time)
                                end
                            end
                            else
                            begin
                                $display("time = %0d, SCOREBOARD : Testcase Falied - data_addr_o, trans.data_be_o, data_we_o did not validate", $time);
                                if (trans.data_req_o != 1'b1)
                                begin
                                    $display("time = %0d, SCOREBOARD : Testcase Passed - data_req_o is validated", $time);
                                end
                                else
                                begin
                                    $display("time = %0d, SCOREBOARD : Testcase Failed - data_req_o should be 1'b0", $time)
                                end
                            end
                        end

                        else if (flag == 1) // STORE opcode
                        begin
                            if (addr_valid_checker(trans.data_addr_o) == TRUE && be_gen_checker(trans.data_be_o) == TRUE && trans.data_we_o == 1'b1 && addr_valid_checker(trans.data_wdata_o) == TRUE )
                            begin
                                $display("time = %0d, SCOREBOARD : Testcase Passed - data_addr_o, trans.data_be_o, data_we_o, data_wdata_o is validated", $time);
                                if (trans.data_req_o == 1'b1)
                                begin
                                    $display("time = %0d, SCOREBOARD : Testcase Passed - data_req_o is validated", $time);
                                end
                                else
                                begin
                                    $display("time = %0d, SCOREBOARD : Testcase Failed - data_req_o should be 1'b1", $time)
                                end
                            end
                            else
                            begin
                                $display("time = %0d, SCOREBOARD : Testcase Falied - data_addr_o, trans.data_be_o, data_we_o, data_wdata_o did not validate", $time);
                                if (trans.data_req_o != 1'b1)
                                begin
                                    $display("time = %0d, SCOREBOARD : Testcase Passed - data_req_o is validated", $time);
                                end
                                else
                                begin
                                    $display("time = %0d, SCOREBOARD : Testcase Failed - data_req_o should be 1'b0", $time)
                                end
                            end
                        end

                    else
                    begin
                        $display("time = %0d, SCOREBOARD : Testcase Failed - data_rvalid_i should be 1'b1", $time);
                    end    
                end
                else
                begin 
                    $display("time = %0d, SCOREBOARD : Testcase Failed - data_rdata_i did not validate", $time);
                end
            
            end


            if (trans.rst_n == 0) 
            begin
                if(trans.data_we_ex_o != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Testcase Failed - data_we_ex_o when rst", $time);
                end
                if(trans.data_type_ex_o != 2'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Testcase Failed - data_type_ex_o when rst", $time);
                end
                if(trans.data_sign_ext_ex_o != 2'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Testcase Failed - data_sign_ext_ex_o when rst", $time);
                end
                if(trans.data_reg_offset_ex_o != 2'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Testcase Failed - data_reg_offset_ex_o when rst", $time);
                end
                if(trans.data_req_ex_o != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Testcase Failed - data_req_ex_o when rst", $time);
                end
                if(trans.data_load_event_ex_o != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Testcase Failed - data_load_event_ex_o when rst", $time);
                end
                if(trans.atop_ex_o != 5'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Testcase Failed - atop_ex_o when rst", $time);
                end
                if(trans.data_misaligned_ex_o != 1'b0)
                begin
                    $display("time = %0d, SCOREBOARD : Testcase Failed - data_misaligned_ex_o when rst", $time);
                end

            end
                        
            numTransactions++;

        end

    endtask


endclass