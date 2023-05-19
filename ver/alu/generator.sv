`include "transaction.sv"

class generator;

    // Handle of transaction class
    rand transaction trans;

    // Number of items to generate
    int repeat_count;
    
    // Mailbox : Gen to Driv
    mailbox gen2driv;

    event transactionGenEnd;

    int count = 0;
    int x = 0;
    bit and_mode , or_mode , xor_mode , abs_mode , slet_mode  ,sletu_mode , min_mode , minu_mode , max_mode , maxu_mode;

    // Constructor
    function new(mailbox gen2driv);
        this.gen2driv = gen2driv;
        trans = new;
    endfunction
    
    task main();
        repeat(repeat_count) begin

            if (count < (repeat_count/10)) begin
                
                and_mode = 1;
                or_mode = 0;
                xor_mode = 0;
                abs_mode = 0;
                slet_mode = 0;
                sletu_mode = 0;
                min_mode = 0;
                minu_mode = 0;
                max_mode = 0;
                maxu_mode = 0;

            end

            else if (count < 2*(repeat_count/10)) begin
                
                and_mode = 0;
                or_mode = 1;
                xor_mode = 0;
                abs_mode = 0;
                slet_mode = 0;
                sletu_mode = 0;
                min_mode = 0;
                minu_mode = 0;
                max_mode = 0;
                maxu_mode = 0;

            end

            else if (count < 3*(repeat_count/10)) begin
                
                and_mode = 0;
                or_mode = 0;
                xor_mode = 1;
                abs_mode = 0;
                slet_mode = 0;
                sletu_mode = 0;
                min_mode = 0;
                minu_mode = 0;
                max_mode = 0;
                maxu_mode = 0;
            end
			
            else if (count < 4*(repeat_count/10)) begin
                
                and_mode = 0;
                or_mode = 0;
                xor_mode = 0;
                abs_mode = 1;
                slet_mode = 0;
                sletu_mode = 0;
                min_mode = 0;
                minu_mode = 0;
                max_mode = 0;
                maxu_mode = 0;

            end

            else if (count < 5*(repeat_count/10)) begin
                
                and_mode = 0;
                or_mode = 0;
                xor_mode = 0;
                abs_mode = 0;
                slet_mode = 1;
                sletu_mode = 0;
                min_mode = 0;
                minu_mode = 0;
                max_mode = 0;
                maxu_mode = 0;
            end

            else if (count < 6*(repeat_count/10)) begin
                
                and_mode = 0;
                or_mode = 0;
                xor_mode = 0;
                abs_mode = 0;
                slet_mode = 0;
                sletu_mode = 1;
                min_mode = 0;
                minu_mode = 0;
                max_mode = 0;
                maxu_mode = 0;

            end

            else if (count < 7*(repeat_count/10)) begin
                
                and_mode = 0;
                or_mode = 0;
                xor_mode = 0;
                abs_mode = 0;
                slet_mode = 0;
                sletu_mode = 0;
                min_mode = 1;
                minu_mode = 0;
                max_mode = 0;
                maxu_mode = 0;

            end

            else if (count < 8*(repeat_count/10)) begin
                
                and_mode = 0;
                or_mode = 0;
                xor_mode = 0;
                abs_mode = 0;
                slet_mode = 0;
                sletu_mode = 0;
                min_mode = 0;
                minu_mode = 1;
                max_mode = 0;
                maxu_mode = 0;

            end

            else if (count < 9*(repeat_count/10)) begin
                
                and_mode = 0;
                or_mode = 0;
                xor_mode = 0;
                abs_mode = 0;
                slet_mode = 0;
                sletu_mode = 0;
                min_mode = 0;
                minu_mode = 0;
                max_mode = 1;
                maxu_mode = 0;

            end

            else if (count < 10*(repeat_count/10)) begin
                
                and_mode = 0;
                or_mode = 0;
                xor_mode = 0;
                abs_mode = 0;
                slet_mode = 0;
                sletu_mode = 0;
                min_mode = 0;
                minu_mode = 0;
                max_mode = 0;
                maxu_mode = 1;

            end

          trans.abs_en.constraint_mode(abs_mode);
          trans.and_en.constraint_mode(and_mode);
          trans.or_en.constraint_mode(or_mode);
          trans.xor_en.constraint_mode(xor_mode);
          trans.slet_en.constraint_mode(slet_mode);
          trans.sletu_en.constraint_mode(sletu_mode);
          trans.min_en.constraint_mode(min_mode);
          trans.minu_en.constraint_mode(minu_mode);
          trans.max_en.constraint_mode(max_mode);
          trans.maxu_en.constraint_mode(maxu_mode);
          
            if (x == 0) begin
                x = 1;
                if(!trans.randomize()) $fatal("Gen :: trans randomisation failed");
//               trans.display("Generator : ");
                trans.cg.sample();
                gen2driv.put(trans);
            end
          	else begin
              #30;
              if(!trans.randomize()) $fatal("Gen :: Trans randomisation failed");
//               trans.display("Generator : ");
              trans.cg.sample();
              gen2driv.put(trans);
            end

            count++;

        end

        -> transactionGenEnd;

    endtask

    task displaycoverage();
        wait(transactionGenEnd.triggered);
        $display("Coverage = %f" , trans.cg.get_coverage());
    endtask

endclass