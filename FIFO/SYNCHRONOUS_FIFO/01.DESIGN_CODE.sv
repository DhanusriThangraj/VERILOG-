
// Code your design here

module syn_fifo( input clk,reset,
                 input write_en,read_en,
                 input [7:0]data_in,    
                output reg [7:0]data_out,
                output reg full,empty
               );
  
  reg [2:0]write_ptr;
  reg [2:0]read_ptr;
  reg [7:0]ram[7:0];
  
  always @ (posedge clk) begin
    if(reset)begin
      data_out<=0;
      write_ptr<=0;
      read_ptr<=0;
    end
    
    else begin
      if (write_en&&!full)begin
        ram[write_ptr]<=data_in;
         write_ptr<=write_ptr+1;

      end
      if (read_en&&!empty)begin
        data_out<=ram[read_ptr];
        read_ptr<=read_ptr+1;

      end
        
    end
       
  end
  
assign full = ((write_ptr + 1) % 8 == read_ptr);
assign empty=(read_ptr==write_ptr);
  
endmodule
