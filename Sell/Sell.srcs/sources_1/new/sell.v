`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/07/31 22:54:50
// Design Name: 
// Module Name: sell
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


module sell(
    input clk,
    input rst,
    input a,
    input b,
    output y,
    output z
    );
    
    reg y,z;
    parameter s0=0,s1=1;
    reg state,next_state;
    always@(posedge clk)
    begin
    if(!rst)
    state<=s0;
    else
    state<=next_state;
    end
    always@(a or b or state)
    begin
    y=0;z=0;
    case(state)
    s0: if(a==1&&b==0)next_state=s1;
    else if(a==0&&b==1)
    begin
    next_state=s0;y=1;
    end
    else
    next_state=s0;
    s1: if(a==1&&b==0)
    begin
    next_state=s0;y=1;
    end
    else if(a==0&&b==1)
    begin
    next_state=s0;y=1;z=1;
    end
    else
    next_state=s0;
    default: next_state=s0;
    endcase
    end
    
    
endmodule
