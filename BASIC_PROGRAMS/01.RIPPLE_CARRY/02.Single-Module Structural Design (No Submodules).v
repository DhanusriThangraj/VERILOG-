module ripple_carry(
             input [3:0]a,b,
             input cin,
             output wire [3:0]sum,
             output carry);
  wire [0:2]c;
  
  assign sum[0]=a[0]^b[0]^cin;
  assign c[0]=(a[0]&b[0]) | (b[0]&cin) | (cin&a[0]);
  
  assign sum[1]=a[1]^b[1]^c[0];
  assign c[1]=(a[1]&b[1]) | (b[1]&c[0]) | (c[0]&a[1]);
  
  assign sum[2]=a[2]^b[2]^c[1];
  assign c[2]=(a[2]&b[2]) | (b[2]&c[1]) | (c[1]&a[2]);
  
  assign sum[3]=a[3]^b[3]^c[2];
  assign carry=(a[3]&b[3]) | (b[3]&c[2]) | (c[2]&a[3]);

endmodule

//testbench
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


//output
[2025-11-06 02:18:24 UTC] iverilog '-Wall' '-g2012' design.sv testbench.sv  && unbuffer vvp a.out  
Time=0 | a=0011 b=0001 cin=0 -> sum=0100 cin=0
Time=10 | a=1111 b=0000 cin=0 -> sum=1111 cin=0
Time=20 | a=1001 b=0111 cin=1 -> sum=0001 cin=1
testbench.sv:26: $finish called at 30 (1s)
Done
