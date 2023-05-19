// package pkg1;
// `include "transaction.sv"
// endpackage

import pkg1::*;

class scoreboard;

    mailbox mon2scb;
    int numTransactions;
    transaction trans;
    int AND_hits , OR_hits , XOR_hits  ,ABS_hits , SLET_hits , SLETU_hits , MIN_hits, MINU_hits , MAX_hits, MAXU_hits;
    int AND_miss , OR_miss , XOR_miss , ABS_miss , SLET_miss , SLETU_miss , MIN_miss, MINU_miss , MAX_miss, MAXU_miss;
    int flag;

    // Constructor
    function new(mailbox mon2scb);
        this.mon2scb = mon2scb;
    endfunction

    task main;
      	
        AND_hits = 0;
        forever begin

            mon2scb.get(trans);

            // Chekcing AND operation
          if (trans.operator_i == 7'b0010101)
            begin
              
              flag = 1;
              for (int i = 32 ; i > 0 ; i--) begin
                if ((trans.operand_a_i[i-1] & trans.operand_b_i[i-1]) != trans.result_o[i-1]) begin
                  flag = 0;
                  $display("%0d th digit : %0b AND %0b != %0b" , i-1 , trans.operand_a_i[i-1],trans.operand_b_i[i-1] , trans.result_o[i-1]);
                  break;
                  
                end
              end
                
              if (flag == 0)
                begin
                  AND_miss++;
                  $display("time = %0d, SCOREBOARD : Error in AND operation : A = %0b , B = %0b , Y = %0b" , $time , trans.operand_a_i, trans.operand_b_i , trans.result_o);
                end

                else
                  AND_hits++;


            end

            // Checking OR operation
          if (trans.operator_i == 7'b0101110)
            begin
              
              flag = 1;
              for (int i = 32 ; i > 0 ; i--) begin
                if ((trans.operand_a_i[i-1] | trans.operand_b_i[i-1]) != trans.result_o[i-1]) begin
                  flag = 0;
                  $display("%0d th digit : %0b OR %0b != %0b" , i-1 , trans.operand_a_i[i-1],trans.operand_b_i[i-1] , trans.result_o[i-1]);
                  break;
                  
                end
              end
                
              if (flag == 0)
                begin
                  OR_miss++;
                  $display("time = %0d, SCOREBOARD : Error in OR operation : A = %0b , B = %0b , Y = %0b" , $time , trans.operand_a_i, trans.operand_b_i , trans.result_o);
                end

                else
                  OR_hits++;


            end

            // Checking XOR operation
         if (trans.operator_i == 7'b0101111)
            begin
              
              flag = 1;
              for (int i = 32 ; i > 0 ; i--) begin
                if ((trans.operand_a_i[i-1] ^ trans.operand_b_i[i-1]) != trans.result_o[i-1]) begin
                  flag = 0;
                  $display("%0d th digit : %0b XOR %0b != %0b" , i-1 , trans.operand_a_i[i-1],trans.operand_b_i[i-1] , trans.result_o[i-1]);
                  break;
                  
                end
              end
                
              if (flag == 0)
                begin
                  XOR_miss++;
                  $display("time = %0d, SCOREBOARD : Error in XOR operation : A = %0b , B = %0b , Y = %0b" , $time , trans.operand_a_i, trans.operand_b_i , trans.result_o);
                end

                else
                  XOR_hits++;


            end

            // ABS Operation

            if (trans.operator_i == 7'b0010100)
              begin
		
		//bit [31:0] mask , abs;
		//int a_i;
		//a_i =  trans.operand_a_i;
		//mask = ~trans.operand_a_i ;
		//if (trans.operand_a_i[31] == 1) begin
		//	abs = mask + 32'b0000000000000000000000000000001;
			
		//end
		//else begin
		//	abs = trans.operand_a_i;
		//end

		int a , y , yi;
		a = trans.operand_a_i;
		y = trans.result_o;

		//$display("XXXX A = %0d , abs(A) = %0d" ,a , abs(a));

		if (a < 0) begin
			yi = -a;
			if (y == yi) begin
				// $display("A NEG => Correct");
        ABS_hits++;

			end
			else begin
				// $display("A NEG => WRONG : a = %0b , y = %0b , yi = %0b" , a , y , yi);
        ABS_miss++;
			end
		end
		else begin
			if (a == y) begin
				// $display("A POS => Correct");
        ABS_hits++;
			end
			else begin
				// $display("A POS => WRONG : a = %0d , y = %0d" , a , y);
        ABS_miss++;
			end
		end
			

		
                
                //$display("time = %0d , SCOREBOARD : ABS Operation : A = %0d , %0b , Y = %0d , %0b , abs = %0b ; HII : a[0] = %0b , a[31] = %0b , y[0] = %0b , y[31] = %0b , signed = %0d" , $time , trans.operand_a_i, trans.operand_a_i , trans.result_o , trans.result_o , abs , trans.operand_a_i[0] , trans.operand_a_i[31] ,trans.result_o[0] , trans.result_o[31] , a_i);
		
		
		
		

              end

              // SLETS OPN

              if (trans.operator_i == 7'b0000110) begin

                int a,b,y,yi;
                a = trans.operand_a_i;
                b = trans.operand_b_i;
                y = trans.result_o;

                if (a <= b) begin
                  yi= 1;
                end

                else begin
                  yi= 0;
                end

                if (yi == y) begin
                  // $display("SLET : Correct");
                  SLET_hits++;
                end

                else begin 
                  // $display("SLET : WRONG -> y = %0d , yi = %0d" , y, yi);
                  SLET_miss++;
                end


              end

              // SLETU OPN

              if (trans.operator_i == 7'b0000111) begin

                bit [31:0] a,b,y,yi;
                a = trans.operand_a_i;
                b = trans.operand_b_i;
                y = trans.result_o;

                if (a <= b) begin
                  yi= 1;
                end

                else begin
                  yi= 0;
                end

                if (yi == y) begin
                  // $display("SLET : Correct");
                  SLETU_hits++;
                end

                else begin 
                  // $display("SLET : WRONG -> y = %0d , yi = %0d" , y, yi);
                  SLETU_miss++;
                end


              end

              // MINS OPN

              if (trans.operator_i == 7'b0010000) begin

                int a,b,y,yi;
                a = trans.operand_a_i;
                b = trans.operand_b_i;
                y = trans.result_o;

                if (a < b) begin
                  yi= a;
                end

                else begin
                  yi= b;
                end

                if (yi == y) begin
                  // $display("SLET : Correct");
                  MIN_hits++;
                end

                else begin 
                  // $display("MIN : WRONG -> y = %0d , yi = %0d , a = %0d , b = %0d" , y, yi , a , b);
                  MIN_miss++;
                end


              end

              // MINU OPN

              if (trans.operator_i == 7'b0010001) begin

                bit [31:0] a,b,y,yi;
                a = trans.operand_a_i;
                b = trans.operand_b_i;
                y = trans.result_o;

                if (a < b) begin
                  yi= a;
                end

                else begin
                  yi= b;
                end

                if (yi == y) begin
                  // $display("SLET : Correct");
                  MINU_hits++;
                end

                else begin 
                  // $display("MINU : WRONG -> y = %0d , yi = %0d , a = %0d , b = %0d" , y, yi , a , b);
                  MINU_miss++;
                end


              end

              // MAXS OPN

              if (trans.operator_i == 7'b0010010) begin

                int a,b,y,yi;
                a = trans.operand_a_i;
                b = trans.operand_b_i;
                y = trans.result_o;

                if (a < b) begin
                  yi= b;
                end

                else begin
                  yi= a;
                end

                if (yi == y) begin
                  // $display("SLET : Correct");
                  MAX_hits++;
                end

                else begin 
                  // $display("MIN : WRONG -> y = %0d , yi = %0d , a = %0d , b = %0d" , y, yi , a , b);
                  MAX_miss++;
                end


              end

              // MAXU OPN

              if (trans.operator_i == 7'b0010011) begin

                bit [31:0] a,b,y,yi;
                a = trans.operand_a_i;
                b = trans.operand_b_i;
                y = trans.result_o;

                if (a < b) begin
                  yi= b;
                end

                else begin
                  yi= a;
                end

                if (yi == y) begin
                  // $display("SLET : Correct");
                  MAXU_hits++;
                end

                else begin 
                  // $display("MIN : WRONG -> y = %0d , yi = %0d , a = %0d , b = %0d" , y, yi , a , b);
                  MAXU_miss++;
                end


              end

            numTransactions++;

        end

    endtask

    task hitMissDisplay;

        begin

            $display("AND : %0d Hits and %0d Misses" , AND_hits , AND_miss );
            $display("OR : %0d Hits and %0d Misses" , OR_hits , OR_miss );
            $display("XOR : %0d Hits and %0d Misses" , XOR_hits , XOR_miss );
            $display("ABS : %0d Hits and %0d Misses" , ABS_hits , ABS_miss );
            $display("SLETS : %0d Hits and %0d Misses" , SLET_hits , SLET_miss );
            $display("SLETU : %0d Hits and %0d Misses" , SLETU_hits , SLETU_miss );
            $display("MINS : %0d Hits and %0d Misses" , MIN_hits , MIN_miss );
            $display("MINU : %0d Hits and %0d Misses" , MINU_hits , MINU_miss );
            $display("MAXS : %0d Hits and %0d Misses" , MAX_hits , MAX_miss );
            $display("MAXU : %0d Hits and %0d Misses" , MAXU_hits , MAXU_miss );

        end

    endtask


endclass