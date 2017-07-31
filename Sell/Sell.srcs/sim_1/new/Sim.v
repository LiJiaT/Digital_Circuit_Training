`timescale 1ns/1ns
module Sim();

reg clk, rst, a, b;
wire y, z;

sell T(.clk(clk),.rst(rst),.a(a),.b(b),.y(y),.z(z));

initial 
begin 
clk =0;
rst =1;
a =0;
b =0;
end

always #10 clk =~clk;

initial begin 
#5 rst =0;
#20 rst =1;
#600 $finish;
end

always #20
begin 
    a = {$random%2};
    b = {$random%2};
end

endmodule