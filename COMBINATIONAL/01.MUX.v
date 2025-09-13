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
