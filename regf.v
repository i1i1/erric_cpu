module regf(i_clk, i_reg0, i_reg1, i_wb_reg, i_wb_val, o_reg0, o_reg1);
   /*
    * i_clk    - clock
    * i_rst    - reset
    * i_reg0   - index of first register to read
    * i_reg1   - index of second register to read
    * i_wb_reg - index of register to write back
    * i_wb_val - value to write back
    */
   input        i_clk, i_rst;
   input  [4:0] i_reg0, i_reg1, i_wb_reg;
   input [31:0] i_wb_val;

   /*
    * o_reg0 - value of first register to read
    * o_reg1 - value of second register to read
    */
   output [31:0] o_reg0, o_reg1;

   reg [31:0] 	 reg0, reg1;

   reg [31:0] 	 regfile[0:31];

   assign o_reg0 = reg0;
   assign o_reg1 = reg1;

   always @ (posedge i_clk) begin
      reg0 <= regfile[i_reg0];
      reg1 <= regfile[i_reg1];

      /* TODO: this won't work :( */
      regfile[i_wb_reg] <= i_wb_val;
   end

endmodule

