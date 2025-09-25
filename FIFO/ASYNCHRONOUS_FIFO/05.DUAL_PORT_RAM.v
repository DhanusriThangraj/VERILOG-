module asyn_fifo #(parameter N=3,M=7,O=8)(input w_clk,r_clk,
                                          input r_en,w_en,
                                          input full,empty,
                                          input [M:0]din,
                                          input [N:0]bwptr,brptr,
                                          output reg [M:0]dout);
  
  reg [M:0]asynfifo[0:O-1];
  
  always @ (posedge w_clk )begin
    if(w_en & !full)begin  
      asynfifo[bwptr[N-1:0]]<=din;
    end
  end
  
  always @ (posedge r_clk) begin
    if(r_en & !empty)begin
      dout<=asynfifo[brptr[N-1:0]];
    end
  end
  
  
   //assign dout= asynfifo[brptr[N-1:0]];
endmodule
        
