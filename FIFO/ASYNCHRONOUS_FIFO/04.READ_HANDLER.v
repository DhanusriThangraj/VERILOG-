module read_handler #(parameter N=3)(
  input r_clk,r_reset,r_en,
  input [N:0]gwptrsyn,
   output reg empty,
  output reg [N:0]brptr,
  output reg [N:0]grptr);
  
  wire [N:0] brptr_next, grptr_next;
  
  wire r_empty;
  
  assign brptr_next= brptr+(r_en & !empty);
  assign grptr_next=(brptr_next>>1)^brptr_next;
  assign r_empty =(gwptrsyn == grptr_next);
  
  always @ (posedge r_clk or negedge r_reset)begin
    if(!r_reset)begin
      brptr<=0;
      grptr<=0;
      empty<=1;
    end
    else
      begin
        brptr<= brptr_next;
        grptr<=grptr_next;
        empty<=r_empty;
      end
  end
endmodule
  

