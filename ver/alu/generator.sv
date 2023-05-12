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

    // Constructor
    function new(mailbox gen2driv);
        this.gen2driv = gen2driv;
        trans = new;
    endfunction
    
    task main();
        repeat(repeat_count) begin

            if (x == 0) begin
                x = 1;
                if(!trans.randomize()) $fatal("Gen :: trans randomisation failed");
                trans.$display("Generator");
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