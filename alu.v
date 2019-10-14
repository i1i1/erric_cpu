`include "defs.v"

module alu(i_do, i_reg0, i_reg1, o_out);
   parameter SIZE=8;

   input [SIZE-1:0] i_reg0, i_reg1;
   input [ 3:0] i_do;

   output [SIZE-1:0] o_out;

   wire [SIZE-1:0] res[0:15];

   assign o_out = res[i_do];

   assign res[`ALU_MOV] = i_reg0;
   assign res[`ALU_LSR] = i_reg0 << 1;
   assign res[`ALU_LSL] = i_reg0 >> 1;
   assign res[`ALU_ASR] = i_reg0 <<< 1;
   assign res[`ALU_ASL] = i_reg0 >>> 1;
   assign res[`ALU_ADD] = i_reg0 + i_reg1;
   assign res[`ALU_SUB] = i_reg0 - i_reg1;
   assign res[`ALU_OR]  = i_reg0 | i_reg1;
   assign res[`ALU_AND] = i_reg0 & i_reg1;
   assign res[`ALU_XOR] = i_reg0 ^ i_reg1;
   assign res[`ALU_CND] = ((res[`ALU_SUB] == 0) ? `CND_EQ :
               ((res[`ALU_SUB][SIZE-1] == 0) ? `CND_MORE :
                `CND_LESS));
   assign res[`ALU_NOP] = i_reg1;

endmodule

