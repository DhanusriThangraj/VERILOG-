module synchronizer #(parameter M=7) (
  input clk,reset,
  input [M:0]din,
  output reg [M:0]dout);
  
  reg [M:0]q1; 
  always @(posedge clk or negedge reset)begin
    if(!reset)begin
      q1<=0;
      dout<=0;end
    else begin
      q1<=din;
      dout<=q1; end
  end
endmodule
