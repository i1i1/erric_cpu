module regf(i_clk, i_rst, i_reg0, i_reg1, i_wb_reg, i_wb_val, o_reg0, o_reg1);
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

   reg [31:0] regfile[0:31];

   assign o_reg0 = regfile[i_reg0];
   assign o_reg1 = regfile[i_reg1];

   always @ (posedge i_clk) begin
      regfile[i_wb_reg] <= i_wb_val;
      $display("Writing to reg[0x%02x] = %04x", i_wb_reg, i_wb_val);
   end

   initial begin
      regfile[4'h0] = 0; regfile[4'h1] = 0; regfile[4'h2] = 0; regfile[4'h3] = 0;
      regfile[4'h4] = 0; regfile[4'h5] = 0; regfile[4'h6] = 0; regfile[4'h7] = 0;
      regfile[4'h8] = 0; regfile[4'h9] = 0; regfile[4'hA] = 0; regfile[4'hB] = 0;
      regfile[4'hC] = 0; regfile[4'hD] = 0; regfile[4'hE] = 0; regfile[4'hF] = 0;
   end

endmodule

