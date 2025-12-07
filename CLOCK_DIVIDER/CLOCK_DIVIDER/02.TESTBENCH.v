// Code your testbench here
// or browse Examples
module clock_divder_tb #(parameter system_freq=100_000_000,//100mhz
required_freq=50_000);
 reg clk,reset;
 wire out;

  clock_divider #(.system_freq(system_freq),
                  .required_freq(required_freq))dut(.clk(clk),
                                                    .reset(reset),
                                                    .out(out));

real t;
initial begin
  $dumpfile("dump.vcd");
  $dumpvars();
end
initial begin
 t = (1.0/system_freq) * 1e9;
  clk=0;
  forever #(t/2) clk=~clk;  //10ns
end


initial begin
        reset = 1;
        #20;
        reset = 0;
    end

    initial begin
      #50000 $finish;   
    end

endmodule
