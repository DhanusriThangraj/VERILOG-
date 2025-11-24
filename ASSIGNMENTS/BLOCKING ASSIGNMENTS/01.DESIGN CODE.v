module blocking(clk,reset,a,e);
input clk,reset;
input a;
output reg e;
  
reg b,c,d;
  always @(posedge clk)begin
    if (reset)begin
     b=0;
     c=0;
     d=0;
     e=0;
    end
   else begin
     b=a;
     c=b;
     d=c;
     e=d;
   end
   
  end
endmodule

//testbench
module blocking_tb;
reg clk;
reg reset;
reg a;
wire e;

  blocking dut (.clk(clk),
                    .reset(reset),
                    .a(a),.e(e));
initial clk=0;
  always #5 clk=~clk;
  
initial begin
  $dumpfile("dump.vcd");
  $dumpvars();end
initial begin
  #5; reset=1; a=0;

  #10;reset=0;
  #5 a=1;
 #100 $finish;
end
endmodule
