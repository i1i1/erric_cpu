module control(i_clk, i_inst, o_alu_do);
   input  [3:0] i_inst;
   input        i_clk;

   output reg [3:0] o_alu_do;

   always @ (*) begin
      case (i_inst)
        `OP_MOV: o_alu_do = `ALU_MOV;
        `OP_ADD: o_alu_do = `ALU_ADD;
        `OP_SUB: o_alu_do = `ALU_SUB;
        `OP_ASR: o_alu_do = `ALU_ASR;
        `OP_ASL: o_alu_do = `ALU_ASL;
        `OP_OR:  o_alu_do = `ALU_OR;
        `OP_AND: o_alu_do = `ALU_AND;
        `OP_XOR: o_alu_do = `ALU_XOR;
        `OP_LSL: o_alu_do = `ALU_LSL;
        `OP_LSR: o_alu_do = `ALU_LSR;
        `OP_CND: o_alu_do = `ALU_CND;
        default: o_alu_do = `ALU_NOP;
      endcase
   end

endmodule

