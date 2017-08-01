module DualRAM
#(
    parameter DATA_SIZE = 8,
    parameter ADDR_SIZE = 4
)
(
    input                       wclken, wclk,
    input   [ADDR_SIZE-1:0]   raddr,
    input   [ADDR_SIZE-1:0]   waddr,
    input   [DATA_SIZE-1:0]   wdata,
    output  [DATA_SIZE-1:0]   rdata
);

localparam RAM_DEPTH = 1 << ADDR_SIZE;
reg [DATA_SIZE-1:0] Men [RAM_DEPTH-1:0];
    
always @(posedge wclk)
begin 
    if(wclken)
        Men[waddr] <= wdata;
end

assign rdata = Men[raddr];

endmodule