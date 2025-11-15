// Code your testbench here
// or browse Examples
module simple_dual_port_ram_memory_tb;
  parameter DATA_WIDTH =4;
  parameter ADDR_WIDTH =4;

  reg clk1,clk2;
  reg reset;
  reg we;
  reg re;
  reg  [ADDR_WIDTH-1:0]waddr;
  reg  [ADDR_WIDTH-1:0]raddr;
  reg  [DATA_WIDTH-1:0]din;
  wire [DATA_WIDTH-1:0]dout;
  
 localparam DEPTH = 1 << ADDR_WIDTH;
  reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
  
  simple_dual_port_ram_memory #(DATA_WIDTH, ADDR_WIDTH) dut (.clk1(clk1),
                                                             .clk2(clk2),
                                                             .reset(reset),
                                                             .we(we),
                                                             .re(re),
                                                             .waddr(waddr),
                                                             .raddr(raddr),
                                                             .din(din),
                                                             .dout(dout));
  initial begin
    $dumpfile("single_port_ram_memory.vcd");
    $dumpvars();
  end
  
  initial begin
    reset=1;
    clk1=0;
    forever #5 clk1=~clk1;end
    initial begin
     clk2=0;
    forever #7 clk2=~clk2;
  end
  
  
  initial begin
     #25 we=1;   re=0; #50 reset=0;
  end
  
  initial begin
    for(int i=0;i<16;i++)begin // write
      @(posedge clk1)
        if(we)begin
          din=$random;
          waddr=$urandom_range(0,15);
          mem[i]=waddr;  
      end
  end
    we=0;
  end
  
  initial begin
    #250;re=1;
    for(int i=0;i<16;i++)begin //read
      @(posedge clk2)
        raddr=mem[i];
    end
  end
  
  
  
  initial begin
       #1000; $finish;
  end
endmodule
