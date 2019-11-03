module testbench_main();
    reg clk;
    reg rst;

    wire run;

    proc proc(.i_clk(clk),
              .i_rst(rst),
              .o_run(run));

    parameter period = 100;

    initial begin
        $display("Initializing...");
        rst = 0;
        rst = 1;
        #70 clk = 0;
        while (run) begin
            $display("updating");
           #(period/2) clk = ~clk;
        end
    end

endmodule

