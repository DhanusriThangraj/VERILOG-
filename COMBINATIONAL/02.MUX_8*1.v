\module mux #(parameter n=3,m=8) (input [(n-1):0]sel, input [(m-1):0]in,
           output reg out);

  //GATE LEVEL
  wire [7:0]w;
  and(w[0],(~sel[0]),(~sel[1]),(~sel[2]),in[0]);
  and(w[1],(~sel[0]),(~sel[1]),(sel[2]),in[1]);
  and(w[2],(~sel[0]),(sel[1]),(~sel[2]),in[2]);
  and(w[3],(~sel[0]),(sel[1]),(sel[2]),in[3]);
  and(w[4],(sel[0]),(~sel[1]),(~sel[2]),in[4]);
  and(w[5],(sel[0]),(~sel[1]),(sel[2]),in[5]);
  and(w[6],(sel[0]),(sel[1]),(~sel[2]),in[6]);
  and(w[7],(sel[0]),(sel[1]),(sel[2]),in[7]);
  or(out,w[7:0]);

  
  //DATAFLOW
 assign out =in[sel];

 //USING TERNARY OPERATOR 
assign out=(sel==0)?in[0]:(sel==1)?in[1]:(sel==2)?in[2]:(sel==3)?in[3]:(sel==4)?in[4]:(sel==5)?in[5]:(sel==6)?in[6]:in[7];
  
endmodule

//TESTBENCH
module mux_tb;
  parameter n=3;
  parameter m=8;
  reg[(n-1):0]sel;
  reg [(m-1):0]in;
  wire out;
  
  mux  #(.n(n),.m(m)) uut (.sel(sel),.in(in),.out(out));
  
  initial begin
    $display("TIME\tSEL\tIn\t\t\tout\t");
    $monitor("%0t\t\t%b\t%b\t%b\t",$time,sel,in,out);
end
  initial begin
    in=8'b11101001;
    #5;sel=3'b000;
    #5;sel=3'b001;
    #5;sel=3'b010;
    #5;sel=3'b011;
    #5;sel=3'b100;
    #5;sel=3'b101;
    #5;sel=3'b110;
    #5;sel=3'b111;
    #5;$finish;
    end
endmodule
   
//OUTPUT
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Sep 13 03:39 2025
TIME	SEL	In			out	
0		  xxx	11101001	x	
5		  000	11101001	1	
10		001	11101001	0	
15		010	11101001	0	
20		011	11101001	1	
25		100	11101001	0	
30		101	11101001	1	
35		110	11101001	1	
40		111	11101001	1	
$finish called from file "testbench.sv", line 48.
$finish at simulation time                   45
           V C S   S i m u l a t i o n   R e p o r t 
Time: 45 ns
CPU Time:      0.430 seconds;       Data structure size:   0.0Mb
Sat Sep 13 03:39:26 2025
Done
