module freq_divider (
    input  wire clk,      
    input  wire reset,    
  output reg  [10:0] out  
);
  reg [10:0]count;
  always @(posedge clk or negedge reset) begin
    if (!reset)begin
          count<=0;
          out<=0;end
        else begin
           count<=count+1;
    out[0]  <= count[0];   // f/2     = 50.000000 MHz   | Period = 20.000 ns
    out[1]  <= count[1];   // f/4     = 25.000000 MHz   | Period = 40.000 ns
    out[2]  <= count[2];   // f/8     = 12.500000 MHz   | Period = 80.000 ns
    out[3]  <= count[3];   // f/16    = 6.250000 MHz    | Period = 160.000 ns
    out[4]  <= count[4];   // f/32    = 3.125000 MHz    | Period = 320.000 ns
    out[5]  <= count[5];   // f/64    = 1.562500 MHz    | Period = 640.000 ns
    out[6]  <= count[6];   // f/128   = 781.250 kHz     | Period = 1280.000 ns  (1.28 µs)
    out[7]  <= count[7];   // f/256   = 390.625 kHz     | Period = 2560.000 ns  (2.56 µs)
    out[8]  <= count[8];   // f/512   = 195.3125 kHz    | Period = 5120.000 ns  (5.12 µs)
    out[9]  <= count[9];   // f/1024  = 97.65625 kHz    | Period = 10240.000 ns (10.24 µs)
    out[10] <= count[10];  // f/2048  = 48.828125 kHz   | Period = 20480.000 ns (20.48 µs)<

    end
  end
// Input clock = 100 MHz (10 ns period)

endmodule


// testbench
module freq_divider_tb;

    reg clk;
    reg reset;
  wire [10:0] out;

    freq_divider dut (
        .clk(clk),
        .reset(reset),
        .out(out)
    );

    // 100 MHz input clock → 10 ns period
    always #5 clk = ~clk;
    initial begin
        clk   = 0;
        reset = 0;
        #15 reset = 1;
    end

    initial begin
        #500 $finish;   
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, freq_divider_tb);
    end

endmodule
