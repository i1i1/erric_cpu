`ifndef _DEFS_V_
 `define _DEFS_V_

 `define MEM_SIZE       (1 << 11)

 `define OP_SPEC        4'h0
 `define OP_LD          4'h1
 `define OP_LDA         4'h2
 `define OP_ST          4'h3
 `define OP_MOV         4'h4
 `define OP_ADD         4'h5
 `define OP_SUB         4'h6
 `define OP_ASR         4'h7
 `define OP_ASL         4'h8
 `define OP_OR          4'h9
 `define OP_AND         4'hA
 `define OP_XOR         4'hB
 `define OP_LSL         4'hC
 `define OP_LSR         4'hD
 `define OP_CND         4'hE
 `define OP_CBR         4'hF

 `define RAM_NONE       2'b00
 `define RAM_READ       2'b01
 `define RAM_WRITE      2'b10

 `define FMT_1B         2'b00
 `define FMT_2B         2'b01
 `define FMT_4B         2'b11

 `define CND_MORE       31'b001
 `define CND_LESS       31'b010
 `define CND_EQ         31'b100

 `define ALU_NOP         4'h0
 `define ALU_MOV         4'h1
 `define ALU_LSR         4'h2
 `define ALU_LSL         4'h3
 `define ALU_ASR         4'h4
 `define ALU_ASL         4'h5
 `define ALU_ADD         4'h6
 `define ALU_SUB         4'h7
 `define ALU_OR          4'h8
 `define ALU_AND         4'h9
 `define ALU_XOR         4'hA
 `define ALU_CND         4'hB

`endif /* _DEFS_V_ */

