//design code
module des(
		input	clk	,
		input	rst	,
		input	in	,
		output	out	
			
);

parameter [1:0] S0  = 0, S1 = 1, S2 = 2, S3 = 3;

reg [1:0] ps, ns;

always @(posedge clk) begin 
if(rst)
ps <= S0;
else 
ps <= ns;
end


always @(*) begin 
case (ps)
S0: ns <= in ? S1 : S0;
S1: ns <= in ? S2 : S0;
S2: ns <= in ? S3 : S0;
S3: ns <= in ? S3 : S0;
endcase
end

assign out = ((ps == S3) && (!in));

endmodule

//testbench
module tb;
 reg 	clk;
 reg 	rst;
 reg 	in ;
wire	 out;


des dut(
	.clk(	clk)	,
	.rst(	rst)	,
	.in (	in )    ,
	.out(	out)	
);

initial begin
clk = 1'b0;
forever #5 clk = !clk;
end

initial begin 
$dumpfile("dump.vcd");
$dumpvars();
end

initial begin
rst = 1'b1;
#20;
rst = 1'b0;
repeat(100) begin 
data();
end
end

initial begin 
#1000;
$finish();
end

task data; begin 
@(posedge clk) begin 
in = $random;
end
end
endtask

endmodule

