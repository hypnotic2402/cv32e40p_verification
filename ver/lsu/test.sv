`include "environment.sv"

program test(intf i_intf);

    environment env;

    initial begin

        env = new(i_intf);
        env.gen.repeat_count = 15000;
        env.run();

    end

endprogram