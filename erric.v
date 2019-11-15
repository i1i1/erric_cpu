module proc(i_clk, i_rst, o_run);
    input    i_clk, i_rst;
    output    o_run;

    wire [31:0] pc, pc_inc, pc_next, pc_jump, val_reg0, val_reg1,
                         ram_addr, ram_out, wb_val, alu_out;
    wire [15:0] ir;
    wire [ 4:0] reg0, reg1, wb_reg;
    wire [ 3:0] inst, alu_action;
    wire [ 1:0] fmt, ram_action, wb_type;
    wire        do_jump, run, run_next;

    assign o_run = run;
 
    pc        pc_(.i_clk(i_clk),
                  .i_rst(i_rst),
                  .i_run(run_next),
                  .i_pc(pc_next),
                  .o_pc(pc),
                  .o_run(run));

    assign pc_inc = pc + 32'd2;
 
    /* TODO: there should be no ROM, instead only one RAM module */
    rom        rom(.i_addr(pc),
                   .o_data(ir));

    dispatcher dispatcher(.i_ir(ir),
                          .o_fmt(fmt),
                          .o_inst(inst),
                          .o_reg0(reg0),
                          .o_reg1(reg1));

    regf        regf(.i_clk(i_clk),
                     .i_reg0(reg0),
                     .i_reg1(reg1),
                     .i_wb_reg(wb_reg),
                     .i_wb_val(wb_val),
                     .o_reg0(val_reg0),
                     .o_reg1(val_reg1));

    control     control(.i_clk(i_clk),
                        .i_run(run),
                        .i_ir(ir),
                        .i_inst(inst),
                        .i_reg0(reg0),
                        .i_reg1(reg1),
                        .i_val_reg0(val_reg0),
                        .i_val_reg1(val_reg1),
                        .i_pc_inc(pc_inc),
                        .o_wb_type(wb_type),
                        .o_run(run_next),
                        .o_ram_action(ram_action),
                        .o_ram_addr(ram_addr),
                        .o_do_jump(do_jump),
                        .o_pc_jump(pc_jump),
                        .o_alu_action(alu_action),
                        .o_wb_reg(wb_reg),
                        .o_wb_val(wb_val));

    alu_total   alu(.i_reg0(val_reg0),
                    .i_reg1(val_reg1),
                    .i_alu_action(alu_action),
                    .i_fmt(fmt),
                    .o_alu_out(alu_out));

    ram      ram(.i_clk(i_clk),
                 .i_action(ram_action),
                 .i_addr(ram_addr),
                 .i_val(val_reg0),
                 .o_val(ram_out));

   assign pc_next = (do_jump ? pc_jump : pc_inc);
   assign wb_val  = ((wb_type == `WB_ALU) ? alu_out :
                      (wb_type == `WB_RAM) ? ram_out :
                       (wb_type == `WB_PC) ? pc_inc :
                        val_reg1);

endmodule

