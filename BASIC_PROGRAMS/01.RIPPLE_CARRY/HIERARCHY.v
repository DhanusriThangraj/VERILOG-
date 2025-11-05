// design code
// Code your design here
module half_adder(
     input a,b,
     output sum,carry);  
  assign sum= a^b;
  assign carry=a&b;
  
endmodule

module full_adder(
     input a,b,cin,
     output sum,carry);
  
  wire s1,c1,c2;
  half_adder h1 (.a(a),.b(b),.sum(s1),.carry(c1));
  half_adder h2 (.a(s1),.b(cin),.sum(sum),.carry(c2));
  
  assign carry=c1|c2;
   
endmodule

module ripple_carry(
             input [3:0]a,b,
             input cin,
             output wire [3:0]sum,
             output carry);
  wire [0:2]c;
  
  full_adder f1 (.a(a[0]),.b(b[0]),.cin(cin),. sum(sum[0]),.carry(c[0]));
  full_adder f2 (.a(a[1]),.b(b[1]),.cin(c[0]),.sum(sum[1]),.carry(c[1]));
  full_adder f3 (.a(a[2]),.b(b[2]),.cin(c[1]),.sum(sum[2]),.carry(c[2]));
  full_adder f4 (.a(a[3]),.b(b[3]),.cin(c[2]),.sum(sum[3]),.carry(carry));

endmodule

// testbench
// Code your testbench here
// or browse Examples

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

// output
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Nov  4 20:37 2025
Time=0 | a=0011 b=0001 cin=0 -> sum=0100 cin=0
Time=10 | a=1111 b=0000 cin=0 -> sum=1111 cin=0
Time=20 | a=1001 b=0111 cin=1 -> sum=0001 cin=1
$finish called from file "testbench.sv", line 26.
$finish at simulation time                   30
           V C S   S i m u l a t i o n   R e p o r t 
Time: 30 ns
CPU Time:      0.400 seconds;       Data structure size:   0.0Mb
Tue Nov  4 20:37:21 2025
Done
