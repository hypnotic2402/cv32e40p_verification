// package pkg2;
// `include "transaction.sv"
// endpackage

import pkg1::*;

`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;

    generator gen;
    driver driv;
    monitor mon;
    scoreboard scb;

    mailbox gen2driv;
    mailbox mon2scb;

    virtual intf vif;

    // Constructor
  function new(virtual intf vif);

        this.vif = vif;
        gen2driv = new();
        mon2scb = new();

        gen = new(gen2driv);
        driv = new(vif , gen2driv);
        mon = new(vif, mon2scb);
        scb = new(mon2scb);

    endfunction

    task test();

        fork
            gen.main();
            gen.displaycoverage();
            driv.main();
            mon.main();
            scb.main();

        join_any

    endtask

    task after_test();

        wait(gen.transactionGenEnd.triggered);
        wait(gen.repeat_count == driv.numTransactions);
        wait(gen.repeat_count == scb.numTransactions);

    endtask

    task run();
        test();
        after_test();
        $display("DONE");
        $finish;
    endtask

endclass