// Code your testbench here
// or browse Examples
module single_port_ram_memory_tb;
  parameter DATA_WIDTH =4;
  parameter ADDR_WIDTH =16;

  reg clk;
  reg reset;
  reg we;
  reg  [ADDR_WIDTH-1:0]addr;
  reg  [DATA_WIDTH-1:0]din;
  wire [DATA_WIDTH-1:0]dout;
  
  reg [DATA_WIDTH-1:0]mem[ADDR_WIDTH-1:0];
  
  single_port_ram_memory #(DATA_WIDTH, ADDR_WIDTH) dut (.clk(clk),
                                                        .reset(reset),
                                                        .we(we),
                                                        .addr(addr),
                                                        .din(din),
                                                        .dout(dout));
  initial begin
    $dumpfile("single_port_ram_memory.vcd");
    $dumpvars();
  end
  
  initial begin
    reset=1;
    clk=0;
    forever #5 clk=~clk;
  end
  initial begin
     #25 we=1; #50 reset=0;
  end
  
  initial begin
    for(int i=0;i<16;i++)begin // write
           @(posedge clk)
        if(we)begin
          din=$random;
          addr=$urandom_range(0,15);
          mem[i]=addr;  
      end
  end
    we=0;
  end
  
  initial begin
    #250;
    we=0;
    for(int i=0;i<16;i++)begin //read
      @(posedge clk)
        addr=mem[i];
    end
  end
  
  
  
  initial begin
    $monitor("TIME = %0t clk = %b we = %b addr = %d din = %d dout= %d",$time, clk,we,addr,din,dout);
       #1000; $finish;
  end
endmodule
