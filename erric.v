
// The core modude of the CPU
//   i_clk - clock register
//   i_rst - reset register
module proc(i_clk, i_rst);
    input    i_clk, i_rst;

    /*
         pc - program counter register
         pc_inc -
         pc_next - 
         val_reg0 - value stored in the first register
         val_reg1 - value stored in the second register
         read_addr -
         ram_addr - 
         ram_out - 
    */
    wire [31:0] pc, pc_inc, pc_next, val_reg0, val_reg1, read_addr, ram_addr, ram_out;
    // ir - instruction register
    wire [15:0] ir;
    // reg0, reg1 - indices of first and second registers
    wire [ 4:0] reg0, reg1;
    // inst - instruction index
    wire [ 3:0] inst;
    // fmt - 
    // ram_do - 
    wire [ 1:0] fmt, ram_do;
    // do_jump - 
    wire        do_jump;
 
    // Instance of program counter module
    pc        pc_(.i_clk(i_clk),
                  .i_rst(i_rst),
                  .i_pc(pc_next),
                  .o_pc(pc));
    assign pc_inc = pc + 32'd2;
 
    // Instance of rom module
    rom        rom(.i_addr(pc),
                   .o_data(ir));
 
    assign fmt  = ir[15:14];
    assign inst = ir[13:10];
    assign reg0 = ir[ 9: 5];
    assign reg1 = ir[ 4: 0];
 
    /* TODO: may be those 2 should be in ALU module */
    // 
    assign ram_do = ((fmt == `OP_LD || fmt == `OP_LDA) ? `RAM_READ :
                      (fmt == `OP_ST) ? `RAM_WRITE : `RAM_NONE);
    // 
    assign ram_addr = ((fmt == `OP_LD) ? val_reg0 :
                        (fmt == `OP_ST) ? val_reg1 : pc_inc);

`ifdef DEBUG
    regf        regf(.i_clk(i_clk),
                     .i_reg0(reg0),
                     .i_reg1(reg1),
                     .i_wb_reg(...), /* idx of reg for write back */
                     .i_wb_val(...),
                     .o_reg0(val_reg0),
                     .o_reg1(val_reg1));
 
    /* TODO: opcode decoding and handling */
    alu alu(.i_clk(i_clk),
        .i_fmt(fmt),
        .i_inst(inst),
        ...);
`endif

   /* TODO: maybe there should be no ROM, instead only one RAM module */
   ram      ram(.i_clk(i_clk),
                .i_do(ram_do),
                .i_addr(ram_addr),
                .i_val(val_reg0),
                .o_val(ram_out));

   assign do_jump = (fmt == `OP_CBR && val_reg0 != 32'd0);
   assign pc_next = (do_jump ? pc_inc : val_reg1);


endmodule

// 
module regf(i_clk, i_reg0, i_reg1, i_wb_reg, i_wb_val, o_reg0, o_reg1);
   input        i_clk, i_rst;
   input  [4:0] i_reg0, i_reg1, i_wb_reg;
   input [31:0] i_wb_val;

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

