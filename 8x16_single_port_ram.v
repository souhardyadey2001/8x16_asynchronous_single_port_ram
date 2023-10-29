module single_port (re,we,data,addr);
input we,re;
inout [15:0] data;
input [2:0] addr;

reg [15:0] memory [7:0];
integer i;

always @(*)
begin
if (we && ~re)
memory[addr] = data;
end
assign data = (re && !we) ? memory [addr] :16'bz;
endmodule
