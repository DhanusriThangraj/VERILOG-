// Code your design here
module edge_detector(
     input clk,reset,data,
     output fall_out,rise_out);
  
reg q;
wire not_data,not_q;
  always @ (posedge clk)begin
    if(reset)begin
      q<=0;
    end
else begin
 q<=data;
end
  end
  assign not_data=~data;
  assign not_q=~q;
  assign fall_out=(q == 1'b1) && (not_data == 1'b1);//falling edge
  assign rise_out=(not_q==1'b1) && (data == 1'b1);//rising edge
endmodule

// Code your testbench here
// or browse Examples

module edge_detector_tb;
reg clk,reset,data;
wire fall_out,rise_out;

  edge_detector dut (.clk(clk),
                     .reset(reset),
                     .data(data),
                     .fall_out(fall_out),
                     .rise_out(rise_out));

initial begin
  $dumpfile("dump.vcd");
  $dumpvars();
end
initial begin
  clk=0;
  forever #5 clk=~clk;
end
initial begin
  repeat (20) begin
  data=0;
  #7 data=~data;
  #12 data=1;
  #46  data=0;
  #12 data=1;
  end end
initial begin
  reset=1;
  #20 reset=0;
  #1000 $finish;
end
endmodule
