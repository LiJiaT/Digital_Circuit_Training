`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/08/01 16:22:33
// Design Name: 
// Module Name: wptr_full
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


module wptr_full

#(
parameter ADDRSIZE = 4
)

(
output  reg                 wfull,
output      [ADDRSIZE-1:0]  waddr,
output reg  [ADDRSIZE-1:0]  wptr,
input       [ADDRSIZE:0]    wq2_rptr,
input                       winc, wclk, wrst_n
);

reg [ADDRSIZE:0]    wbin;
wire [ADDRSIZE:0]   wgraynext, wbinnext;
wire wfull_val;

// GRAYSTYLE2 pointer

always @(posedge wclk , negedge wrst_n)
if (!wrst_n)
begin 
    wbin <= 0;
    wptr <= 0;
end
else 
begin 
    wbin <= wbinnext;
    wptr <= wgraynext;
end
    
//gray 码计数逻辑    
assign wbinnext = !wfull ? wbin + winc : wbin;
assign wgraynext = (wbinnext >> 1) ^ wbinnext;
assign waddr = wbin[ADDRSIZE-1:0];

 /*由于满标志在写时钟域产生，因此比较安全的做法是将读指针同步到写时钟域*/
/**/
//------------------------------------------------------------------
// Simplified version of the three necessary full-tests:
// assign wfull_val=((wgnext[ADDRSIZE] !=wq2_rptr[ADDRSIZE] ) &&
// (wgnext[ADDRSIZE-1] !=wq2_rptr[ADDRSIZE-1]) &&
// (wgnext[ADDRSIZE-2:0]==wq2_rptr[ADDRSIZE-2:0]));
//------------------------------------------------------------------

assign wfull_cal = (wgraynext == {~wq2_rptr[ADDRSIZE:ADDRSIZE-1], wq2_rptr[ADDRSIZE-2:0]});

always @(posedge wclk, negedge wrst_n)
if(wrst_n)
    wfull <= 1'b0;
else 
    wfull <=  wfull_val;

endmodule
