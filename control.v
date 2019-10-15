module control(i_reg0, i_reg1, i_val_reg0, i_val_reg1, i_pc_inc, i_inst, i_clk, i_alu_out,
	       o_ram_addr, o_wb_reg, o_wb_val, o_alu_action, o_ram_action, o_do_jump);

   input  [31:0] i_val_reg0, i_val_reg1, i_pc_inc, i_alu_out;
   input  [ 4:0] i_reg0, i_reg1;
   input  [ 3:0] i_inst;
   input         i_clk;

   output [31:0]    o_ram_addr, o_wb_val;
   output [ 4:0]    o_wb_reg;
   output reg [3:0] o_alu_action;
   output [ 1:0]    o_ram_action;
   output           o_do_jump;


   assign o_do_jump = (i_inst == `OP_CBR && i_val_reg0 != 32'd0);

   assign o_ram_action = ((i_inst == `OP_LD || i_inst == `OP_LDA) ? `RAM_READ :
                       (i_inst == `OP_ST) ? `RAM_WRITE :
                        `RAM_NONE);
   assign o_ram_addr = ((i_inst == `OP_LD) ? i_val_reg0 :
                         (i_inst == `OP_LDA) ? i_pc_inc :
                          (i_inst == `OP_ST) ? i_val_reg1 :
                            i_pc_inc);
   assign o_wb_reg = ((i_inst == `OP_CBR) ? i_reg0 : i_reg1);
   assign o_wb_val = ((i_inst == `OP_CBR) ? i_pc_inc : i_alu_out);


   always @ (*) begin
      case (i_inst)
        `OP_MOV: o_alu_action = `ALU_MOV;
        `OP_ADD: o_alu_action = `ALU_ADD;
        `OP_SUB: o_alu_action = `ALU_SUB;
        `OP_ASR: o_alu_action = `ALU_ASR;
        `OP_ASL: o_alu_action = `ALU_ASL;
        `OP_OR:  o_alu_action = `ALU_OR;
        `OP_AND: o_alu_action = `ALU_AND;
        `OP_XOR: o_alu_action = `ALU_XOR;
        `OP_LSL: o_alu_action = `ALU_LSL;
        `OP_LSR: o_alu_action = `ALU_LSR;
        `OP_CND: o_alu_action = `ALU_CND;
        default: o_alu_action = `ALU_NOP;
      endcase
   end

endmodule

