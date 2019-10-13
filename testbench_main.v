module testbench_main();
    reg clk;
    reg rst;

    proc proc(.i_clk(clk),
              .i_rst(rst));


    initial begin
        $display("Initializing...");
        clk = 0;
    end

    always
        #10 clk = ~clk;

endmodule

