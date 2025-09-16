//10001 moore overlapping
output in the next clock because,it depends only state

module moore(input clk,reset,in,
             output out);
  
  parameter [2:0] s0=3'b000,
                  s1=3'b001,
                  s2=3'b010,
                  s3=3'b011,
                  s4=3'b100,
                  s5=3'b101;
  
  reg[2:0] state,next_state;
  
  always @ (posedge clk)begin
    if(reset)begin
      state<=s0;
    end
    else
      state<=next_state;
  end
  
  always @ (*)begin
    case(state)
      s0:next_state<=in?s1:s0;
      s1:next_state<=in?s1:s2;
      s2:next_state<=in?s1:s3;
      s3:next_state<=in?s1:s4;
      s4:next_state<=in?s5:s0;
      s5:next_state<=in?s1:s2;
      default:begin
        next_state<=s0;
      end
    endcase
  end
  assign out=(state==s5);

endmodule

//testbench
// Code your testbench here
// or browse Examples
module mealy_tb;
  reg clk,reset,in;
  wire out;
  
  moore uut (.clk(clk),
             .reset(reset),
             .in(in),
             .out(out));
  
initial begin
  $dumpfile("dumpfile.vcd");
  $dumpvars();
end
  
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin
    #10;reset=1;
    #10;reset=0;
    repeat(150)begin
      din();
    end
    #10; $finish;
  end
  
  
  task din();
    begin
      @(posedge clk) in=$random;
    end
  endtask
endmodule
