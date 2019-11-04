module control(i_reg0, i_reg1, i_val_reg0, i_val_reg1, i_pc_inc, i_inst, i_clk,
    i_run, i_ir, o_ram_addr, o_wb_reg, o_wb_val, i_alu_out, o_alu_action, o_ram_in, o_ram_action, 
    o_do_jump, o_run, o_pc_jump, o_wb_type);

   input [31:0] i_alu_out;
   input [31:0] i_val_reg0, i_val_reg1, i_pc_inc;
   input [15:0] i_ir;
   input [ 4:0] i_reg0, i_reg1;
   input [ 3:0] i_inst;
   input        i_clk, i_run;

   output [31:0] o_ram_in, o_ram_addr, o_wb_val, o_pc_jump;
   output [ 4:0] o_wb_reg;
   output [ 3:0] o_alu_action;
   output [ 1:0] o_ram_action, o_wb_type;
   output        o_do_jump, o_run;

   wire   [1:0]  actions[0:15];


   assign o_do_jump = (i_inst == `OP_CBR && i_val_reg0 != 32'd0) ||
                          (i_inst == `OP_LDA);
   assign o_pc_jump = (i_inst == `OP_CBR ? i_val_reg1 : i_pc_inc + 4);

   assign o_ram_action = ((i_inst == `OP_LD || i_inst == `OP_LDA) ? `RAM_READ :
                           (i_inst == `OP_ST) ? `RAM_WRITE :
                            `RAM_NONE);
   assign o_ram_addr = ((i_inst == `OP_LD) ? i_val_reg0 :
                         (i_inst == `OP_LDA) ? i_pc_inc :
                          (i_inst == `OP_ST) ? i_val_reg1 :
                            i_pc_inc);
   assign o_wb_reg = ((i_inst == `OP_CBR) ? i_reg0 : i_reg1);
   assign o_wb_type = ((i_inst == `OP_LDA || i_inst == `OP_LD) ? `WB_RAM :
                        (i_inst == `OP_CBR) ? `WB_PC :
                         (o_alu_action != `ALU_NOP) ? `WB_ALU :
                          `WB_NONE);

   assign o_run = (!i_run ? i_run : (i_ir != 32'b0));

   assign o_alu_action = actions[i_inst];

   assign actions[`OP_SPEC]= `ALU_NOP;
   assign actions[`OP_LD]  = `ALU_NOP;
   assign actions[`OP_LDA] = `ALU_NOP;
   assign actions[`OP_ST]  = `ALU_NOP;
   assign actions[`OP_MOV] = `ALU_MOV;
   assign actions[`OP_ADD] = `ALU_ADD;
   assign actions[`OP_SUB] = `ALU_SUB;
   assign actions[`OP_ASR] = `ALU_ASR;
   assign actions[`OP_ASL] = `ALU_ASL;
   assign actions[`OP_OR ] = `ALU_OR;
   assign actions[`OP_AND] = `ALU_AND;
   assign actions[`OP_XOR] = `ALU_XOR;
   assign actions[`OP_LSL] = `ALU_LSL;
   assign actions[`OP_LSR] = `ALU_LSR;
   assign actions[`OP_CND] = `ALU_CND;
   assign actions[`OP_CBR] = `ALU_NOP;

   always @ (posedge i_clk && i_run) begin
      $display("inst 0x%02x r0 = 0x%05x r1 = 0x%05x ir = 0x%04x pc_inc 0x%04x pc_jump 0x%04x do_jump %d", i_inst, i_reg0, i_reg1, i_ir, i_pc_inc, o_pc_jump, o_do_jump);
   end

endmodule

