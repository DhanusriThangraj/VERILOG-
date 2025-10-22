
module syn_fifo_tb;
  reg clk;
  reg reset;
  reg[7:0]data_in;
  reg write_en,read_en;
  wire [7:0]data_out;
  wire full,empty;
  syn_fifo dut ( .clk(clk),
                .reset(reset),
                .data_in(data_in),
                .write_en(write_en),
                .data_out(data_out),
                .full(full),
                .empty(empty),
                .read_en(read_en)
                    );
  
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin
    $display("TIME\t clk\t reset\t data_in\t write_en\t data_out\t full\t empty\tread_en");
    $monitor("%0t\t\t %0b\t\t %0b\t\t \t\t%0h \t\t%0b\t\t %0h\t\t\t%0b\t\t\t%0b\t%0b",$time,clk,reset,data_in,write_en,data_out,full,empty,read_en);
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
    
    #200 $finish;
  end 
  
  initial begin
  #10 reset=1;
  
  #10 reset =0;
  #10 write_en=1;
    //read_en=1;               //simultanous read and write

    repeat (8)begin
      @(posedge clk);
      data_in=$random;
    end
  #10 read_en=1; 
  end
   
endmodule

//output
xcelium> run
TIME	 clk	 reset	 data_in	 write_en	 data_out	 full	 empty	read_en
0		 0		 x		 		x 		x		 x			x			x	x
5		 1		 x		 		x 		x		 x			x			x	x
10		 0		 1		 		x 		x		 x			x			x	x
15		 1		 1		 		x 		x		 0			0			1	x
20		 0		 0		 		x 		x		 0			0			1	x
25		 1		 0		 		x 		x		 0			0			1	x
30		 0		 0		 		x 		1		 0			0			1	x
35		 1		 0		 		24 		1		 0			0			0	x
40		 0		 0		 		24 		1		 0			0			0	x
45		 1		 0		 		81 		1		 0			0			0	x
50		 0		 0		 		81 		1		 0			0			0	x
55		 1		 0		 		9 		1		 0			0			0	x
60		 0		 0		 		9 		1		 0			0			0	x
65		 1		 0		 		63 		1		 0			0			0	x
70		 0		 0		 		63 		1		 0			0			0	x
75		 1		 0		 		d 		1		 0			0			0	x
80		 0		 0		 		d 		1		 0			0			0	x
85		 1		 0		 		8d 		1		 0			0			0	x
90		 0		 0		 		8d 		1		 0			0			0	x
95		 1		 0		 		65 		1		 0			1			0	x
100		 0		 0		 		65 		1		 0			1			0	x
105		 1		 0		 		12 		1		 0			1			0	x
110		 0		 0		 		12 		1		 0			1			0	x
115		 1		 0		 		12 		1		 24			0			0	1
120		 0		 0		 		12 		1		 24			0			0	1
125		 1		 0		 		12 		1		 81			0			0	1
130		 0		 0		 		12 		1		 81			0			0	1
135		 1		 0		 		12 		1		 9			0			0	1
140		 0		 0		 		12 		1		 9			0			0	1
145		 1		 0		 		12 		1		 63			0			0	1
150		 0		 0		 		12 		1		 63			0			0	1
155		 1		 0		 		12 		1		 d			0			0	1
160		 0		 0		 		12 		1		 d			0			0	1
165		 1		 0		 		12 		1		 8d			0			0	1
170		 0		 0		 		12 		1		 8d			0			0	1
175		 1		 0		 		12 		1		 65			0			0	1
180		 0		 0		 		12 		1		 65			0			0	1
185		 1		 0		 		12 		1		 12			0			0	1
190		 0		 0		 		12 		1		 12			0			0	1
195		 1		 0		 		12 		1		 12			0			0	1
Simulation complete via $finish(1) at time 200 NS + 0
./testbench.sv:36     #200 $finish;
xcelium> exit
TOOL:	xrun	23.09-s001: Exiting on Oct 19, 2025 at 13:58:16 EDT  (total: 00:00:01)
Finding VCD file...
./dump.vcd
[2025-10-19 17:58:16 UTC] Opening EPWave...
Done

