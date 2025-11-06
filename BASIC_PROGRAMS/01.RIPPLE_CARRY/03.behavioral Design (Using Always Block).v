module ripple_carry(
             input [3:0]a,b,
             input cin,
             output reg [3:0]sum,
             output reg carry);

  always @(*)begin
    {carry,sum} = a + b + cin;
  end
  
endmodule

module ripple_tb;
  reg [3:0]a;
  reg [3:0]b;
  reg cin;
  wire [3:0]sum;
  wire carry;
  
  
  ripple_carry dut (.a(a),
                   .b(b),
                   .cin(cin),
                   .carry(carry),
                   .sum(sum));
  
 initial begin
   $monitor("Time=%0t | a=%b b=%b cin=%b -> sum=%b cin=%b",
                 $time, a, b, cin, sum, carry);

        a=4'b0011; b=4'b01; cin=0; #10;
        a=4'b1111; b=4'b0000; cin=0; #10;
        a=4'b1001; b=4'b0111; cin=1; #10;
        $finish;
    end

endmodule

Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Nov  4 20:56 2025
Time=0 | a=0011 b=0001 cin=0 -> sum=0100 cin=0
Time=10 | a=1111 b=0000 cin=0 -> sum=1111 cin=0
Time=20 | a=1001 b=0111 cin=1 -> sum=0001 cin=1
$finish called from file "testbench.sv", line 26.
$finish at simulation time                   30
           V C S   S i m u l a t i o n   R e p o r t 
Time: 30 ns
CPU Time:      0.470 seconds;       Data structure size:   0.0Mb
Tue Nov  4 20:56:23 2025
Done
