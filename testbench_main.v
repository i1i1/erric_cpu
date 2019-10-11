module testbench_main();
    reg clk;

    cpu cpu(clk);


    initial begin
        $display("Initializing...");
        clk = 0;
    end

    always
        #10 clk = ~clk;

endmodule

