module tb_single_port();
reg we,re;
reg [2:0] addr;
wire [15:0] data;
reg [15:0] temp;
integer i;

single_port DUT (re,we,data,addr);

task initialize();
begin
we = 1'b0;
re = 1'b0;
addr = 3'b0;
temp = 16'b0;
end
endtask

assign data = (we && !re) ? temp : 16'bz;

task write_memory ();
begin
we = 1'b1;
re = 1'b0;
end
endtask

task read_memory ();
begin
we = 1'b0;
re = 1'b1;
end
endtask

task stimulus_w (input [2:0]a , input [15:0]d);
begin
addr = a;
temp = d;
end
endtask

task stimulus_r (input [2:0]ad);
begin
addr = ad;
end
endtask

initial
begin
initialize;
#10;
write_memory;
for (i=0;i<8;i=i+1)
begin
stimulus_w(i, {$random}%100);
#10;
end
read_memory;
for (i=0;i<8;i=i+1)
begin
stimulus_r(i);
#10;
end
#100;
$finish;
end
endmodule

