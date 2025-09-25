module write_handler #(parameter N=3)(
  input w_clk,w_reset,w_en,
  input [N:0]grptrsyn,
  output reg full,
  output reg[N:0]gwptr,
  output reg [N:0]bwptr
   );
  
  wire [N:0]gwptr_next, bwptr_next;
  
  wire wfull;
  
  assign bwptr_next= bwptr+(w_en&!full);
  assign gwptr_next= (bwptr_next>>1)^bwptr_next;
  
  always@ (posedge w_clk or negedge w_reset) begin
    if(!w_reset)begin
      gwptr<=0;
      bwptr<=0;
    end
    else begin
      bwptr<= bwptr_next;
      gwptr<=gwptr_next; end    
  end
  
  always @(posedge w_clk or negedge w_reset) begin
    if(!w_reset)begin
      full<=0;
    end
    else
      full<=wfull;
  end
  assign wfull= (gwptr_next == {~grptrsyn[N:N-1],grptrsyn[N-2:0]});
   
endmodule
