module logic_gates(input a,b,
                   input control,
                   output reg and1,or1,nand1,nor1,xor1,xnor1,not1,buf1,bufif1_1,bufif0_0,notif1_1,notif0_0);
  
  and  q   (and1,a,b);
  or   p   (or1,a,b);
  nand c   (nand1,a,b);
  nor  d   (nor1,a,b);
  xor  e   (xor1,a,b);
  xnor f   (xnor1,a,b);
  not  g   (not1,a);
  buf  h   (buf1,b);
  
  
  bufif1 i (bufif1_1,a,control);
  bufif0 j (bufif0_0,a,control);
  
//   bufif1 w (out[10],b,control);
//   bufif0 t(out[11],b,control);
  
  notif1 k (notif1_1,a,control);
  notif0 l (notif0_0,a,control);
  
//   notif1 u (out[14],b,control);
//   notif0 y (out[15],b,control);
  
  
endmodule

//TESTBENCH
module logic_gates_tb;
  reg a,b;
  reg control;
  wire and1,or1,nand1,nor1,xor1,xnor1,not1,buf1,bufif1_1,bufif0_0,notif1_1,notif0_0;
  
logic_gates uut (
    .a(a), .b(b), .control(control),
    .and1(and1), .or1(or1), .nand1(nand1), .nor1(nor1),
    .xor1(xor1), .xnor1(xnor1), .not1(not1), .buf1(buf1),
    .bufif1_1(bufif1_1), .bufif0_0(bufif0_0),
  .notif1_1(notif1_1), .notif0_0(notif0_0));
  
  initial begin
    $display("Time\tA\tB\t\tCTRL\tAND\tOR\tNAND\tNOR\tXOR\tXNOR NOT\tBUF\tBUFIF1\tBUFIF0\tNOTIF1\tNOTIF0");

    $monitor("%0t\t%b\t%b\t%b\t%b\t%b\t%b\t\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b",
             $time, a, b, control,
             and1, or1, nand1, nor1, xor1, xnor1,
             not1, buf1, bufif1_1, bufif0_0, notif1_1, notif0_0);
  end
  initial begin
    #10;a=1;
        b=0;
        control=0;
    #10;control=1;
    #1;$finish;
  end
  endmodule

//OUTPUT
Time	A	B		CTRL	AND	OR	NAND	NOR	XOR	XNOR NOT	BUF	BUFIF1	BUFIF0	NOTIF1	NOTIF0
0	   x	x	  x	    x	  x	   x		x	  x    x	  x 	 x	  x	       x	    x	      x
10	 1	0  	0	    0	  1	   1		0	  1	   0	  0	   0	  z	       1	    z      	0
20	 1	0	  1	    0	  1	   1		0	  1	   0	  0	   0	  1	       z	    0	      z
testbench.sv:78: $finish called at 21 (1s)
Done
