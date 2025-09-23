module tb;
  reg clk,reset;
  wire out;
  
  frequency_7 uut (.clk(clk),.reset(reset),.out(out));
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
  initial begin
    clk=0;
    forever #10 clk=~clk;
  end
  
  initial begin
    reset=1;
    #20; reset=0;
    #1000;
    $finish;
  end
endmodule
