module pc(i_clk, i_rst, i_pc, o_pc, o_pc_inc);
   input         i_clk, i_rst;
   input  [31:0] i_pc;

   output [31:0] o_pc, o_pc_inc;

   reg    [31:0] pc;

   assign o_pc = pc;
   assign o_pc_inc = o_pc + 32'd2;

   always @ (posedge i_clk) begin
      if (!i_rst) begin
         pc <= 32'b0;
      end else begin
         pc <= i_pc;
      end
   end

endmodule

