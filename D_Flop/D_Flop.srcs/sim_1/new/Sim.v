module Sim();
reg clk, D, rst;
wire Q;

D_Flop T(.clk(clk),.Q(Q),.rst(rst),.D(D));

initial 
begin 
    rst =1;
    clk =0;
    D = 0;
end

always #10 clk =~clk;

initial 
begin 
#20 rst = 0;
#20 rst =1;
#600 $finish;
end 

always #20 D = {$random%2};

endmodule 