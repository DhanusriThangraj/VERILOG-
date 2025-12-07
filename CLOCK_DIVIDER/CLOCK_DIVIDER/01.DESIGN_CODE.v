// Code your design here

module clock_divider #(parameter system_freq=100_000_000,required_freq=50_000)//50kilohz
(input clk,reset,
 output reg out);
  
  localparam divider=(system_freq/(required_freq*2));
  reg [$clog2(divider)-1:0]count;

  always @(posedge clk)begin
    if(reset)begin
      out<=0;
      count<=0;
    end
   else begin
     if(count==divider-1)begin
       count<=0;
       out<=~out;
     end
else begin
   count<=count+1;

end
   end
  end
endmodule
