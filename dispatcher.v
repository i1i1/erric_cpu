module dispatcher(i_ir, o_fmt, o_inst, o_reg0, o_reg1);
    input [15:0] i_ir;

    output [4:0] o_reg0, o_reg1;
    output [3:0] o_inst;
    output [1:0] o_fmt;

    assign o_fmt  = i_ir[15:14];
    assign o_inst = i_ir[13:10];
    assign o_reg0 = i_ir[ 9: 5];
    assign o_reg1 = i_ir[ 4: 0];

endmodule

