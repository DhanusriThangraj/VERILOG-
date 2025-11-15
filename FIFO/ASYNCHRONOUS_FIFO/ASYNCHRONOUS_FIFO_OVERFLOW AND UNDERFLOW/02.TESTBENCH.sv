// Code your testbench here
// or browse Examples
module asyn_tb #( parameter data_width=4,
                 parameter addr_width=3,
                parameter depth=1<<addr_width);
  
reg   wr_clk;
reg  wr_en;
reg  wr_reset;
reg [data_width-1:0] data_in;
reg  rd_clk;
reg  rd_en;
reg   rd_reset;
wire [data_width-1:0]data_out;
wire empty;
wire full;
wire overflow;
wire underflow;
  
  asynchronous_fifo   #(.data_width( data_width),
                        .addr_width(addr_width),
                        .depth(depth)) dut (.wr_clk(wr_clk),
                                                      .wr_en(wr_en),
                                                      .wr_reset(wr_reset),
                                                      .data_in(data_in),
                                                      .rd_clk(rd_clk),
                                                      .rd_en(rd_en),
                                                      .rd_reset(rd_reset),
                                                      .data_out(data_out),
                                                      .empty(empty),
                                                      .full(full),
                                                      .overflow(overflow),
                                                      .underflow(underflow));
                                                      
                                                      
  
  initial begin
    wr_clk=0;
    rd_clk=0;
end
    always #5 wr_clk=~wr_clk;
    
    always #7 rd_clk=~rd_clk;
    

  initial begin
    wr_reset = 1;
    rd_reset = 1;
    wr_en = 0;
    rd_en = 0;
    data_in = 0;
    #50;
    wr_reset = 0;
    rd_reset = 0;
  end

 
  initial begin
    repeat (16)begin
      @(posedge wr_clk);
      if (!full) begin
        wr_en <= 1;
        data_in <= $random;
      end else
        wr_en <= 0;
    end
    wr_en <= 0;
  end


  initial begin
    #150;
    repeat (16)begin
      @(posedge rd_clk);
      if (!empty) begin
        rd_en <= 1;
      end 
    end
    rd_en<=0;
  end

  
  initial begin
    #2000 $finish;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
 
endmodule
