
// Code your design here
module odd_frequency#(parameter N=9)(input clk,reset,
                   output out);
  
  reg [$clog2(N-1):0]count;
  
  reg q;
  always @(posedge clk)begin
    if (reset)begin
      count<=0;
    end
    else begin
      if(count==(N-1))
        count<=0;
      else
        count<=count+1;
      
  end
  end
    always @(negedge clk)begin
      if(reset)begin
        q<=0;end
        else 
          q<=count[$clog2(N-1)-1];
    end   
      
  assign out= q|count[($clog2(N-1))-1];
endmodule
      
//testbench

module tb;
  reg clk,reset;
  wire out;
  
  odd_frequency  #(.N()) uut (.clk(clk),.reset(reset),.out(out));
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
  initial begin
    clk=1;
    forever #10 clk=~clk;
  end
  
  initial begin
    reset=1;
    #20; reset=0;
    #1000;
    $finish;
  end
endmodule
