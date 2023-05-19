import pkg1::*;
 
class driver;

    int numTransactions;
    virtual intf vif;
    mailbox gen2driv;
    transaction trans;

    //constructor

    function new(virtual intf vif , mailbox gen2driv);
        this.vif = vif;
        this.gen2driv = gen2driv;
    endfunction

    task main;

        forever begin

            gen2driv.get(trans);

            @(posedge vif.clk);
            vif.rst_n <= trans.rst_n;
            vif.hwlp_start_data_i <= trans.hwlp_start_data_i;
            vif.hwlp_end_data_i <= trans.hwlp_end_data_i;
            vif.hwlp_cnt_data_i <= trans.hwlp_cnt_data_i;
            vif.hwlp_we_i <= trans.hwlp_we_i;
            vif.hwlp_regid_i <= trans.hwlp_regid_i;
            vif.valid_i <= trans.valid_i;
            vif.hwlp_dec_cnt_i <= trans.hwlp_dec_cnt_i;
            
            
            
            @(posedge vif.clk);
//             trans.display("Driver :  ");
            numTransactions++;


        end
    endtask

endclass