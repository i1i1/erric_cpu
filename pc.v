module pc(i_clk, i_rst, i_pc, i_run, o_pc, o_run);
   input         i_clk, i_rst, i_run;
   input  [31:0] i_pc;

   output [31:0] o_pc;
   output        o_run;

   reg    [31:0] pc;
   reg           run;

   assign o_pc = pc;
   assign o_run = run;

   always @ (posedge i_rst) begin
      run <= 1'b1;
      pc  <= 32'b0;
   end

   always @ (posedge i_clk) begin
      run <= i_run;
      if (i_run) begin
         pc <= i_pc;
      end
   end

endmodule

