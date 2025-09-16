//1111 overlaping
module mealy(input clk,reset,in,
             output out);
  
  parameter [1:0] s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011;
  reg [1:0]state,next_state;
  
  always @(posedge clk)begin
    if(reset)begin
      state<=s0;
    end
    else
      state<=next_state;
  end
  
  always @(*)begin
    
    case (state)
      s0:begin 
        next_state = in?s1:s0;
      end
      s1:begin
         next_state = in?s2:s0;
      end
       s2:begin
         next_state = in?s3:s0;
      end
       s3:begin
        next_state = in?s3:s0;
       end
       default:begin
         next_state = s0;
       end
    endcase
  end
  assign out=(state==s3 && in==1);
  endmodule

//testbench
// Code your testbench here
// or browse Examples
module mealy_tb;
  reg clk,reset,in;
  wire out;
  mealy uut (.clk(clk),.reset(reset),.in(in),.out(out));
  
  initial begin
    $display("TIME\tCLK\tRESET\tIN\tOUT\t");
    $monitor("%0t\t\t%0b\t%0b\t%0b\t%0b\t",$time,clk,reset,in,out);
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    clk=1;
    forever #5 clk=~clk;

  end
  initial begin
    #10;
    reset=1;
    #10; reset=0;
    repeat (100)begin
      din();
    end
    #20;$finish;
  end
  
  task din();
    begin
      @(posedge clk)in=$random;
    end  
  endtask
endmodule
  
