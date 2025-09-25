module asyn_tb;
  parameter M = 7;   // data width
  parameter N = 3;   // pointer width
  parameter O = 8;   // depth 

  reg r_clk, r_reset, r_en;
  reg w_clk, w_reset, w_en;
  reg [M:0] din;
  wire [M:0] dout;
  wire full, empty;

  
  top #(.N(N), .M(M), .O(O)) uut (
    .w_clk(w_clk),
    .r_clk(r_clk),
    .r_en(r_en),
    .w_en(w_en),
    .r_reset(r_reset),
    .w_reset(w_reset),
    .din(din),
    .dout(dout),
    .full(full),
    .empty(empty)
  );

 
  initial begin
    $dumpfile("asyn_fifo.vcd");
    $dumpvars(0, asyn_tb);
  end

  
  initial begin
    w_clk = 0;
    forever #10 w_clk = ~w_clk; 
  end

 
  initial begin
    r_clk = 0;
    forever #12 r_clk = ~r_clk;  
  end

 
  initial begin
    w_reset = 0;
    r_reset = 0;
    w_en = 0;
    r_en = 0;
    din = 0;
    #50;
    w_reset = 1;
    r_reset = 1;
  end

 
  initial begin
    repeat (10) begin
      @(posedge w_clk);
      if (!full) begin
        w_en <= 1;
        din <= $random;
      end
    end
    w_en <= 0;
  end


  initial begin
    #500; 
    repeat (10) begin
      @(posedge r_clk);
      if (!empty) begin
        r_en <= 1;
      end
    end
    r_en <= 0;
  end

  
  initial begin
    #2000 $finish;
  end

endmodule
