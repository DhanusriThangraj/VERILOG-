module ripple_carry  #(parameter N=4)(
             input [N-1:0]a,b,
             input cin,
             output  [N-1:0]sum,
             output  carry);

  wire [N:0]c;
  assign c[0]=cin;
  assign carry=c[N];
  
  
  genvar i;
  generate
    for(i=0;i<N;i++)begin
      assign sum[i]=a[i]^b[i]^c[i];
      assign c[i+1]=(a[i]&b[i]) | (b[i]&c[i]) | (a[i]&c[i]);
  end
   endgenerate
  
  
endmodule
  
  
endmodule

//testbench
module ripple_tb #(N=4);
  reg [N-1:0]a;
  reg [N-1:0]b;
  reg cin;
  wire [N-1:0]sum;
  wire carry;
  
  
  ripple_carry  #(.N(N)) dut (.a(a),
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
[2025-11-06 02:09:51 UTC] iverilog '-Wall' '-g2012' design.sv testbench.sv  && unbuffer vvp a.out  
Time=0 | a=0011 b=0001 cin=1 -> sum=0101 cin=0
Time=10 | a=1111 b=0000 cin=0 -> sum=1111 cin=0
Time=20 | a=1001 b=0111 cin=1 -> sum=0001 cin=1
testbench.sv:26: $finish called at 30 (1s)
Done

