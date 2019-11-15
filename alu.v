`include "defs.v"

module alu_total(i_reg0, i_reg1, i_alu_action, i_fmt, o_alu_out);
    input [31:0] i_reg0, i_reg1;
    input [ 3:0] i_alu_action;
    input [ 1:0] i_fmt;

    output reg [31:0] o_alu_out;

    wire [31:0] alu32_out;
    wire [15:0] alu16_out;
    wire [ 7:0] alu8_out;

    alu #(8) alu8(.i_action(i_alu_action),
                  .i_reg0(i_reg0[7:0]),
                  .i_reg1(i_reg1[7:0]),
                  .o_out(alu8_out));

    alu #(16) alu16(.i_action(i_alu_action),
                    .i_reg0(i_reg0[15:0]),
                    .i_reg1(i_reg1[15:0]),
                    .o_out(alu16_out));

    alu #(32) alu32(.i_action(i_alu_action),
                    .i_reg0(i_reg0),
                    .i_reg1(i_reg1),
                    .o_out(alu32_out));

    always @(*) begin
//        $display("Updating ALU %04x: %08x %08x -> %08x", i_alu_action, i_reg0, i_reg1, o_alu_out);
        case (i_fmt)
            `FMT_1B: o_alu_out = { i_reg0[31:8], alu8_out };
            `FMT_2B: o_alu_out = { i_reg0[31:16], alu16_out };
            `FMT_4B: o_alu_out = alu32_out;
        endcase
//        $display("Updated ALU %04x: %08x %08x -> %08x", i_alu_action, i_reg0, i_reg1, o_alu_out);
    end


//assign o_alu_out = ((i_fmt == `FMT_1B) ? { i_reg0[31:8], alu8_out } :
//                        (i_fmt == `FMT_2B) ? { i_reg0[31:16], alu16_out } :
//                         alu32_out);

endmodule

module alu(i_action, i_reg0, i_reg1, o_out);
   parameter SIZE=8;

   input [SIZE-1:0] i_reg0, i_reg1;
   input [ 3:0] i_action;

   output [SIZE-1:0] o_out;

   wire [SIZE-1:0] res[0:15];

   assign o_out = res[i_action];

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

