module rptr_empty

#(parameter ADDRSIZE =4)

(
output  reg                 rempty,
output      [ADDRSIZE-1:0]  raddr,
output   reg [ADDRSIZE-1:0]  rptr,
input       [ADDRSIZE:0]    rq2_wptr,
input                       rinc, rclk, rrst_n
);

reg [ADDRSIZE:0]    rbin;
wire [ADDRSIZE:0]   rgraynext, rbinnext;
wire rempty_val;

//-------------------
// GRAYSTYLE2 pointer: gray码读地址指针
//-------------------

always @(posedge rclk, negedge rrst_n)
if(!rrst_n)
    begin 
        rbin <= 0;
        rptr <= 0;
    end
else 
    begin 
        rbin <= rbinnext;
        rptr <= rgraynext;
    end

// gray码计数逻辑
assign rbinnext = !rempty ? (rbin + rinc) : rbin;
assign rgraynext = (rbinnext>>1) ^ rbinnext;
assign raddr = rbin[ADDRSIZE-1:0];

//---------------------------------------------------------------
// FIFO empty when the next rptr == synchronized wptr or on reset
//---------------------------------------------------------------
/*
*   读指针是一个n位的gray码计数器，比FIFO寻址所需的位宽大一位
*   当读指针和同步过来的写指针完全相等时(包括MSB)，说明二者折回次数一致,FIFO为空
*     
*/

assign rempty_val = {rgraynext == rq2_wptr};

always @(posedge rclk, negedge rrst_n)
if(!rrst_n)
    rempty <= 1'b1;
else 
    rempty <= rempty_val;

endmodule