
module dual_port_ram_memory #(
    parameter DATA_WIDTH = 4,
    parameter ADDR_WIDTH = 4
)(
    input  clk1,clk2,
    input  reset,
    input  we1,
    input  re1,
  
    input  we2,
    input  re2,
    input  [ADDR_WIDTH-1:0] addr1, 
    input  [ADDR_WIDTH-1:0] addr2, 
    input  [DATA_WIDTH-1:0] din1,
    input  [DATA_WIDTH-1:0]din2,
    output reg [DATA_WIDTH-1:0] dout1,
    output reg [DATA_WIDTH-1:0] dout2
);

localparam DEPTH = 1 << ADDR_WIDTH;
reg [DATA_WIDTH-1:0] ram [0:DEPTH-1];
  
  always @(posedge clk1 ) begin  
  if (reset)
        dout1 <= 0;
    else begin
      if (we1)begin
        ram[addr1] <= din1;
      end
      if(re1)
        dout1 <= ram[addr1];
    end   
   end


  always @(posedge clk2 ) begin  
    if(reset)
      dout2<=0;
    else begin
      if (we2) begin
        ram[addr2]<=din2; 
      end
      if(re2)
      dout2<=ram[addr2];     
  end
  end
endmodule


