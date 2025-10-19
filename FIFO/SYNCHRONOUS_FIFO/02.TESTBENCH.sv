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
