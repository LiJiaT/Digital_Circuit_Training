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
// GRAYSTYLE2 pointer: gray�����ַָ��
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

// gray������߼�
assign rbinnext = !rempty ? (rbin + rinc) : rbin;
assign rgraynext = (rbinnext>>1) ^ rbinnext;
assign raddr = rbin[ADDRSIZE-1:0];

//---------------------------------------------------------------
// FIFO empty when the next rptr == synchronized wptr or on reset
//---------------------------------------------------------------
/*
*   ��ָ����һ��nλ��gray�����������FIFOѰַ�����λ���һλ
*   ����ָ���ͬ��������дָ����ȫ���ʱ(����MSB)��˵�������ۻش���һ��,FIFOΪ��
*     
*/

assign rempty_val = {rgraynext == rq2_wptr};

always @(posedge rclk, negedge rrst_n)
if(!rrst_n)
    rempty <= 1'b1;
else 
    rempty <= rempty_val;

endmodule