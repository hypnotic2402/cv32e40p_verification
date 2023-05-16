// package pkg1;
// `include "transaction.sv"
// endpackage

import pkg1::*;

class scoreboard;

    mailbox mon2scb;

    int numTransactions;
    transaction trans;

    // Constructor
    function new(mailbox mon2scb);
        this.mon2scb = mon2scb;
    endfunction

    task main;

        forever begin

            mon2scb.get(trans);

            // write logic here
            if (trans.rst_n == 1'b0 & trans.we_a_i == 1'b1) // Write from WP1
            begin
                if(trans.raddr_a_i == trans.waddr_a_i) // Write from port WP1 and Read from port RP1
                begin
                    if(trans.raddr_a_i[5] == 1'b0)
                    begin
                        if(trans.rdata_a_o != trans.wdata_a_i)
                        begin
                            $display("time = %0d, SCOREBOARD : Error in Write Port 1 -> Read Port 1 operation" , $time);
                        end
                    end
                end

                else if(trans.raddr_b_i == trans.waddr_a_i) // Write from port WP1 and Read from port RP2
                begin
                    if(trans.raddr_b_i[5] == 1'b0)
                    begin
                        if(trans.rdata_b_o != trans.wdata_a_i)
                        begin
                            $display("time = %0d, SCOREBOARD : Error in Write Port 1 -> Read Port 2 operation" , $time);
                        end
                    end
                end

                else if(trans.raddr_c_i == trans.waddr_a_i) // Write from port WP1 and Read from port RP3
                begin
                    if(trans.raddr_c_i[5] == 1'b0)
                    begin
                        if(trans.rdata_c_o != trans.wdata_a_i)
                        begin
                            $display("time = %0d, SCOREBOARD : Error in Write Port 1 -> Read Port 3 operation" , $time);
                        end
                    end
                end
            end


            else if (trans.rst_n == 1'b0 &  trans.we_b_i == 1'b1) // Write from WP2
            begin
                if(trans.raddr_a_i == trans.waddr_b_i) // Write from port WP2 and Read from port RP1
                begin
                    if(trans.raddr_a_i[5] == 1'b0)
                    begin
                        if(trans.rdata_a_o != trans.wdata_b_i)
                        begin
                            $display("time = %0d, SCOREBOARD : Error in Write Port 2 -> Read Port 1 operation" , $time);
                        end
                    end
                end

                else if(trans.raddr_b_i == trans.waddr_b_i) // Write from port WP2 and Read from port RP2
                begin
                    if(trans.raddr_b_i[5] == 1'b0)
                    begin
                        if(trans.rdata_b_o != trans.wdata_b_i)
                        begin
                            $display("time = %0d, SCOREBOARD : Error in Write Port 2 -> Read Port 2 operation" , $time);
                        end
                    end
                end

                else if(trans.raddr_c_i == trans.waddr_b_i) // Write from port WP2 and Read from port RP3
                begin
                    if(trans.raddr_c_i[5] == 1'b0)
                    begin
                        if(trans.rdata_c_o != trans.wdata_b_i)
                        begin
                            $display("time = %0d, SCOREBOARD : Error in Write Port 2 -> Read Port 3 operation" , $time);
                        end
                    end
                end
            end

            else if(trans.rst_n == 1'b1)
            begin
                if(trans.raddr_a_i[5] == 1'b0 && trans.rdata_a_o != 5'b0) // Read from port RP3
                begin
                    $display("time = %0d, SCOREBOARD : Error Read Port 1 operation when reset" , $time);
                end

                if(trans.raddr_b_i[5] == 1'b0 && trans.rdata_b_o != 5'b0) // Read from port RP3
                begin
                    $display("time = %0d, SCOREBOARD : Error Read Port 2 operation when reset" , $time);
                end

                if(trans.raddr_c_i[5] == 1'b0 && trans.rdata_c_o != 5'b0) // Read from port RP3
                begin
                    $display("time = %0d, SCOREBOARD : Error Read Port 3 operation when reset" , $time);
                end

            end

            numTransactions++;

        end

    endtask

endclass