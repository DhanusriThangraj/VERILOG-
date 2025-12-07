module freq_divider (
    input  wire clk,      
    input  wire reset,    
  output reg  [10:0] out  
);
  reg [10:0]count;
    always @(posedge clk or posedge reset) begin
        if (reset)
          count<=0;
        else
           count<=count+1;
    end
// Input clock = 100 MHz (10 ns period)

assign out[0]  = count[0];   // f/2     = 50.000000 MHz   | Period = 20.000 ns
assign out[1]  = count[1];   // f/4     = 25.000000 MHz   | Period = 40.000 ns
assign out[2]  = count[2];   // f/8     = 12.500000 MHz   | Period = 80.000 ns
assign out[3]  = count[3];   // f/16    = 6.250000 MHz    | Period = 160.000 ns
assign out[4]  = count[4];   // f/32    = 3.125000 MHz    | Period = 320.000 ns
assign out[5]  = count[5];   // f/64    = 1.562500 MHz    | Period = 640.000 ns
assign out[6]  = count[6];   // f/128   = 781.250 kHz     | Period = 1280.000 ns  (1.28 µs)
assign out[7]  = count[7];   // f/256   = 390.625 kHz     | Period = 2560.000 ns  (2.56 µs)
assign out[8]  = count[8];   // f/512   = 195.3125 kHz    | Period = 5120.000 ns  (5.12 µs)
assign out[9]  = count[9];   // f/1024  = 97.65625 kHz    | Period = 10240.000 ns (10.24 µs)
assign out[10] = count[10];  // f/2048  = 48.828125 kHz   | Period = 20480.000 ns (20.48 µs) 
endmodule

//testbench
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
        reset = 1;
        #20 reset = 0;
    end

    initial begin
        #1000 $finish;   
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, freq_divider_tb);
    end

endmodule

