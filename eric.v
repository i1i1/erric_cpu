module proc(i_clk, i_rst);
   input	i_clk, i_rst;

   wire [31:0] 	pc, pc_inc, pc_next, val_reg0, val_reg1, read_addr;
   wire [15:0] 	ir;
   wire [ 4:0] 	reg0, reg1;
   wire [ 3:0] 	inst;
   wire [ 1:0] 	fmt;
   wire 	read_ram, do_jump;
   

   pc		pc_(.i_clk(i_clk),
		    .i_rst(i_rst),
		    .i_pc(pc_next),
		    .o_pc(pc));

   adder	pc_inc(.i_op1(pc),
		       .i_op2(32'd2),
		       .o_res(pc_inc));

   rom		rom(.i_addr(pc),
		    .o_data(ir));

   assign fmt  = ir[15:14];
   assign inst = ir[13:10];
   assign reg0 = ir[ 9: 5];
   assign reg1 = ir[ 4: 0];

   assign read_ram  = (fmt == `OP_LD || fmt == `OP_LDA);
   assign read_addr = (fmt == `OP_LD ? val_reg0 : pc_inc);

`ifdef DEBUG
   regf		regf(.i_clk(i_clk),
		     .i_reg0(reg0), /* index */
		     .i_reg1(reg1), /* index */
		     .i_val_reg0(...), /* value for writing */
		     .o_reg0(val_reg0),
		     .o_reg1(val_reg1));

   /* TODO: opcode decoding and handling */
   alu		alu(.i_clk(i_clk), ...);

   /* TODO: */
   ram          ram(.i_addr(...),
		    .i_val(...));
`endif

   assign do_jump = (fmt == `OP_CBR && val_reg0 != 32'd0);
   assign pc_next = (do_jump ? pc_inc : val_reg1);


endmodule
