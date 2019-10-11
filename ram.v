module ram(i_clk, i_do, i_addr, i_val, o_val);
    // clock register
    input          i_clk;
    // action to do with input data, one of `RAM_*
    input   [1:0]  i_do;
    input  [31:0]  i_addr;
    // value to write to specified address, if i_do == `RAM_WRITE
    input  [31:0]  i_val;
 
    // value at i_addr if i_do == `RAM_READ
    output [31:0]  o_val;
 

    reg    [31:0]  val;
 
    reg     [7:0]  mem[0:`MEM_SIZE - 1];

//   initial
//     $readmemh("v.out", mem);

    assign o_data = {
        mem[i_addr],
        mem[i_addr+1],
        mem[i_addr+2], mem[i_addr+3]
    };
 
    always @ (posedge i_clk) begin
        if (i_do == `RAM_WRITE) begin 
            {   mem [i_addr],
                mem [i_addr+1],
                mem [i_addr+2],
                mem [i_addr+3]
            } <= i_val;
        end
    end

endmodule

