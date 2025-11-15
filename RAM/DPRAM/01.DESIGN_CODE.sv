
module simple_dual_port_ram_memory #(
    parameter DATA_WIDTH = 4,
    parameter ADDR_WIDTH = 4
)(
    input  clk1,clk2,
    input  reset,
    input  we,
    input  re,
    input  [ADDR_WIDTH-1:0] waddr, 
    input  [ADDR_WIDTH-1:0] raddr, 
    input  [DATA_WIDTH-1:0] din,
    output reg [DATA_WIDTH-1:0] dout

);

localparam DEPTH = 1 << ADDR_WIDTH;
reg [DATA_WIDTH-1:0] ram [0:DEPTH-1];
  always @(posedge clk1) begin  
    if (we) begin
      ram[waddr]<=din;
    end
  end

  always @(posedge clk2 or posedge reset) begin
    if (reset)begin
      dout<=0;
    end
    else begin
      if(re)
      dout<=ram[raddr];
      end
  end
endmodule

Here are **five sharp, clean points** explaining **Simple Dual-Port RAM (Simple DPRAM)**:

1. **It has two ports but each port serves a fixed purpose — Port A is write-only, Port B is read-only.**

2. Both ports use the same RAM, so one port can write while the other reads at the same time without any conflict.

3. **Each port has its own independent clock, so read and write can occur in different clock domains.**

4. **Only the read side typically uses reset (to reset `dout`), because real RAM arrays cannot be reset — only registers can.**

5. **It is simpler and cheaper than true dual-port RAM since it supports only 1 write + 1 read, not two full read/write ports.**
    


