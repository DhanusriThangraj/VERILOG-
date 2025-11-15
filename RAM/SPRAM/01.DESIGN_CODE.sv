// Code your design here
module single_port_ram_memory #(
    parameter DATA_WIDTH = 4,
    parameter ADDR_WIDTH = 16
)(
    input  clk,
    input  reset,
    input  we,
    input  [ADDR_WIDTH-1:0] addr, 
    input  [DATA_WIDTH-1:0] din,
    output reg [DATA_WIDTH-1:0] dout

);
  
  reg [DATA_WIDTH-1:0]ram [ADDR_WIDTH-1:0];
  always @(posedge clk or posedge reset) begin
    
    if (reset)begin
      dout<=0;
      ram[addr]<=0;
    end
    else begin
    if (we) begin
      ram[addr]<=din;
    end
      else begin 
        dout<=ram[addr];
      end
  end
  end
      endmodule
