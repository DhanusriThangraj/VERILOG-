// // Code your testbench here
// // or browse Examples
module dual_port_ram_memory_tb;
  parameter DATA_WIDTH =4;
  parameter ADDR_WIDTH =4;

  reg clk1,clk2;
  reg reset;
  reg we1;
  reg we2;
  reg re1,re2;
  reg  [ADDR_WIDTH-1:0]addr1;
  reg  [ADDR_WIDTH-1:0]addr2;
  reg  [DATA_WIDTH-1:0]din1,din2;
  wire [DATA_WIDTH-1:0]dout1,dout2;
  
   localparam DEPTH = 1 << ADDR_WIDTH;
  reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
  
  dual_port_ram_memory #(DATA_WIDTH, ADDR_WIDTH) dut (.clk1(clk1),
                                                      .clk2(clk2),
                                                      .reset(reset),
                                                      .we1(we1),
                                                      .we2(we2),
                                                      .re1(re1),
                                                      .re2(re2),
                                                      .addr1(addr1),
                                                      .addr2(addr2),
                                                      .din1(din1),
                                                      .din2(din2),
                                                      .dout1(dout1),
                                                   .dout2(dout2));
  
   integer i;     
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
  
  initial begin
   
    clk1=0;
    forever #5 clk1=~clk1;end
    initial begin
     clk2=0;
    forever #7 clk2=~clk2;
  end
  
  
  initial begin
    we1 = 0; we2 = 0;
    re1=0;  re2=0;
    addr1 = 0; addr2 = 0;
    din1 = 0;  din2 = 0;
    reset = 1;

    #10 reset = 0;
    
  end
  
// initial begin
//     // Write sequential values on port1
//     we1 = 1;re1=0;
//     for ( i=0; i<16; i++) begin
//         @(posedge clk1);
//         addr1 = i;
//         din1  = i;
//     end
//     we1 = 0;
// end
  
// initial begin
//     // Read back using port1
//     #200;  re1=1;
//     for (integer j=0; j<16; j++) begin
//       @(posedge clk1);
//         addr1 = j;
//     end
// end
  
// initial begin
//     // Write sequential values on port2
//    we2 = 1; 
//   for ( i=0; i<16; i++) begin
//     @(posedge clk2);
//         addr2 = $urandom_range(0, 15);
//         din2 =$urandom_range(0, 15);
//         mem[i]= addr2 ;
//     end
//   we2= 0;
// end
  
  
//   initial begin
//     // Read back using port2
// #300; re2=1;
//     for (i=0; i<16; i++) begin
//         @(posedge clk2);
//         addr2 =mem[i];
//     end 

// end

// initial begin
//     // Write sequential values on port1
//     we1 = 1;re1=0;
//     for ( i=0; i<16; i++) begin
//         @(posedge clk1);
//         addr1 = i;
//         din1  = i;
//     end
//     we1 = 0;
// end
  
// initial begin
//     // Read back using port2
//     #200;  re2=1;
//     for (integer j=0; j<16; j++) begin
//       @(posedge clk2);
//         addr2 = j;
//     end
// end
 
//   initial begin
//     // Write sequential values on port2
//     we2= 1;re2=0;
//     for ( i=0; i<16; i++) begin
//       @(posedge clk2);
//         addr2 = i;
//         din2  = i;
//     end
//     we1 = 0;
// end
  
// initial begin
//     // Read back using port1
//     #200;  re1=1;
//     for (integer j=0; j<16; j++) begin
//       @(posedge clk1);
//         addr1 = j;
//     end
// end
  
initial begin
    // Write sequential values on port2
   we2 = 1; 
  for ( i=0; i<16; i++) begin
    @(posedge clk2);
        addr2 = $urandom_range(0, 15);
        din2 =$urandom_range(0, 15);
        mem[i]= addr2 ;
    end
  we2= 0;
end
  
  
  initial begin
    // Read back using port1
#300; re1=1;
    for (i=0; i<16; i++) begin
      @(posedge clk1);
        addr1 =mem[i];
    end 
  end
  
  initial begin
       #2000; $finish;
  end
endmodule

