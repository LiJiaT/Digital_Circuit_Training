`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/07/31 22:27:16
// Design Name: 
// Module Name: D_Flop
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module D_Flop(
    input D,
    output Q,
    input clk,
    input rst
    );
    reg Q;
    
    always @(posedge clk)
    if(!rst)
        Q <=0;
     else 
        Q <= D;
    
    
endmodule
