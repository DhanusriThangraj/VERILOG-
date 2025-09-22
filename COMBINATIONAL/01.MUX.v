
module mux(input [1:0]sel,
           input a,b,c,d,
           output reg y);
  
  always @ (*)begin
    case(sel)
      2'b00:y=a;
      2'b01:y=b;
      2'b10:y=c;
      2'b11:y=d;
        
     default:y=0; 
    endcase
  end
endmodule

//testbench
module mux_tb;
  reg [1:0]sel;
  reg a,b,c,d;
  wire y;
  
  mux uut (.sel(sel),.a(a),.b(b),.c(c),.d(d),.y(y));
  
  initial begin
    $display("Time\tSEl\tA\tB\tC\tD\tY\t");
    $monitor("%0t\t\t%b\t%0b\t%0b\t%0b\t%0b\t%0b\t",$time,sel,a,b,c,d,y);
  end
  initial begin
    #10;
    sel=11; a=1; b=0; c=1; d=0;
    #5;sel=10;
    #5;sel=00;
    #5;sel=01;
    #5;$finish;
  end
endmodule


//output
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Sep 13 03:37 2025
Time	          SEl	A	B	C	D	Y	
0		xx	x	x	x	x	x	
10		11	1	0	1	0	0	
15		10	1	0	1	0	1	
20		00	1	0	1	0	1	
25		01	1	0	1	0	0	
$finish called from file "testbench.sv", line 20.
$finish at simulation time                   30
           V C S   S i m u l a t i o n   R e p o r t 
Time: 30 ns
CPU Time:      0.430 seconds;       Data structure size:   0.0Mb
Sat Sep 13 03:37:57 2025
Done
