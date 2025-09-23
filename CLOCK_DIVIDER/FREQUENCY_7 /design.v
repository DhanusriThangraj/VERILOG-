// Code your design here
module frequency_7(input clk,reset,
                   output out);
  
  reg [2:0]count;
  reg q;
  always @(posedge clk)begin
    if (reset)begin
      count<=0;
    end
    else begin
      if(count==6)
        count<=0;
      else
        count<=count+1;
      
  end
  end
    always @(negedge clk)begin
      if(reset)begin
        q<=0;end
        else 
          q<=count[2];
    end   
      
      assign out=q|count[2];
endmodule
      
  
