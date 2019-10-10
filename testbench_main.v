

module testbench_main();
    // Declare clock register
    reg clk;
    // Declare CPU module
    cpu cpu(clk);

    // Initialize state
    initial begin
        $display("Initializing...");
        clk = 0;
    end

    // Every 10 ticks toggle clock
    always
        #10 clk = ~clk;

endmodule





