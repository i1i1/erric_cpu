`include "defs.v"

module alu(i_clk, i_fmt, i_inst, i_reg0, i_reg1, i_ram, o_wb_val);
   input [31:0] i_reg0, i_reg1, i_ram;
   input [ 3:0] i_inst;
   input [ 1:0] i_fmt;
   input i_clk;

   output reg [31:0] o_wb_val;

   wire [31:0]        diff;

   assign diff = i_reg0 - i_reg1;


   always @ (*) begin
      case (i_inst)
        `OP_SPEC:
           /* TODO */;
        `OP_LD:  o_wb_val = i_ram;
        `OP_LDA: o_wb_val = i_ram;
        `OP_ST:  o_wb_val = i_reg1; /* don't do anything */
        `OP_MOV: begin
           case (i_fmt)
             `FMT_1B: begin
                o_wb_val[31: 8] = i_reg1[31:16];
                o_wb_val[ 7: 0] = i_reg0[ 7: 0];
             end
             `FMT_2B: begin
                o_wb_val[31:16] = i_reg1[31:16];
                o_wb_val[15: 0] = i_reg0[15: 0];
             end
             `FMT_4B: o_wb_val = i_reg0;
           endcase
        end
        `OP_ADD: begin
           case (i_fmt)
             `FMT_1B: begin
                o_wb_val[31: 8] = i_reg1[31:16];
                o_wb_val[ 7: 0] = i_reg1[ 7: 0] + i_reg0[ 7: 0];
             end
             `FMT_2B: begin
                o_wb_val[31:16] = i_reg1[31:16];
                o_wb_val[15: 0] = i_reg1[15: 0] + i_reg0[15: 0];
             end
             `FMT_4B: o_wb_val = i_reg0 + i_reg1;
           endcase
        end
        `OP_SUB: begin
           case (i_fmt)
             `FMT_1B: begin
                o_wb_val[31: 8] = i_reg1[31:16];
                o_wb_val[ 7: 0] = i_reg1[ 7: 0] - i_reg0[ 7: 0];
             end
             `FMT_2B: begin
                o_wb_val[31:16] = i_reg1[31:16];
                o_wb_val[15: 0] = i_reg1[15: 0] - i_reg0[15: 0];
             end
             `FMT_4B: o_wb_val = i_reg0 - i_reg1;
           endcase
        end
        `OP_ASR: begin
           case (i_fmt)
             `FMT_1B: begin
                o_wb_val[31: 8] = i_reg1[31:16];
                o_wb_val[ 7: 0] = i_reg0[ 7: 0] >>> 1;
             end
             `FMT_2B: begin
                o_wb_val[31:16] = i_reg1[31:16];
                o_wb_val[15: 0] = i_reg0[15: 0] >>> 1;
             end
             `FMT_4B: o_wb_val = i_reg0[31: 0] >>> 1;
           endcase
        end
        `OP_ASL: begin
           case (i_fmt)
             `FMT_1B: begin
                o_wb_val[31: 8] = i_reg1[31:16];
                o_wb_val[ 7: 0] = i_reg0[ 7: 0] <<< 1;
             end
             `FMT_2B: begin
                o_wb_val[31:16] = i_reg1[31:16];
                o_wb_val[15: 0] = i_reg0[15: 0] <<< 1;
             end
             `FMT_4B: o_wb_val = i_reg0[31: 0] <<< 1;
           endcase
        end
        `OP_OR: begin
           case (i_fmt)
             `FMT_1B: begin
                o_wb_val[31: 8] = i_reg1[31:16];
                o_wb_val[ 7: 0] = i_reg0[ 7: 0] | i_reg1[ 7: 0];
             end
             `FMT_2B: begin
                o_wb_val[31:16] = i_reg1[31:16];
                o_wb_val[15: 0] = i_reg0[15: 0] | i_reg1[15: 0];
             end
             `FMT_4B: o_wb_val = i_reg0 | i_reg1;
           endcase
        end
        `OP_AND: begin
           case (i_fmt)
             `FMT_1B: begin
                o_wb_val[31: 8] = i_reg1[31:16];
                o_wb_val[ 7: 0] = i_reg0[ 7: 0] & i_reg1[ 7: 0];
             end
             `FMT_2B: begin
                o_wb_val[31:16] = i_reg1[31:16];
                o_wb_val[15: 0] = i_reg0[15: 0] & i_reg1[15: 0];
             end
             `FMT_4B: o_wb_val = i_reg0 & i_reg1;
           endcase
        end
        `OP_XOR: begin
           case (i_fmt)
             `FMT_1B: begin
                o_wb_val[31: 8] = i_reg1[31:16];
                o_wb_val[ 7: 0] = i_reg0[ 7: 0] ^ i_reg1[ 7: 0];
             end
             `FMT_2B: begin
                o_wb_val[31:16] = i_reg1[31:16];
                o_wb_val[15: 0] = i_reg0[15: 0] ^ i_reg1[15: 0];
             end
             `FMT_4B: o_wb_val = i_reg0 ^ i_reg1;
           endcase
        end
        `OP_LSL: begin
           case (i_fmt)
             `FMT_1B: begin
                o_wb_val[31: 8] = i_reg1[31:16];
                o_wb_val[ 7: 0] = i_reg0[ 7: 0] << 1;
             end
             `FMT_2B: begin
                o_wb_val[31:16] = i_reg1[31:16];
                o_wb_val[15: 0] = i_reg0[15: 0] << 1;
             end
             `FMT_4B: o_wb_val = i_reg0[31: 0] << 1;
           endcase
        end
        `OP_LSR: begin
           case (i_fmt)
             `FMT_1B: begin
                o_wb_val[31: 8] = i_reg1[31:16];
                o_wb_val[ 7: 0] = i_reg0[ 7: 0] >> 1;
             end
             `FMT_2B: begin
                o_wb_val[31:16] = i_reg1[31:16];
                o_wb_val[15: 0] = i_reg0[15: 0] >> 1;
             end
             `FMT_4B: o_wb_val = i_reg0[31: 0] >> 1;
           endcase
        end
        `OP_CND: begin
          if (diff == 0)
            o_wb_val = `CBR_EQ;
          else
            o_wb_val = ((diff[31] == 0) ? `CBR_MORE : `CBR_LESS);
        end
        `OP_CBR: /* nothing here */;
      endcase
   end

endmodule

