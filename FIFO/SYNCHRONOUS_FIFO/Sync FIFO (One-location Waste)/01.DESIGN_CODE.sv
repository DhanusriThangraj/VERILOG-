// Code your design here

module syn_fifo #(parameter N=4,M=16,D=$clog2(M))( input clk,reset,
                                      input write_en,read_en,
                                      input [N-1:0]data_in,    
                                      output reg [N-1:0]data_out,
                                      output  full,empty
               );
  
  
  reg [D-1:0]write_ptr;
  reg [D-1:0]read_ptr;
  reg [(N-1):0]ram[(M-1):0];
  
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
  
  assign full = ((write_ptr + 1'b1)== read_ptr); // same as // assign full = ((write_ptr + 1'b1) % M== read_ptr); 

  //assign full=( (write_ptr[D]!=read_ptr[D]) && ((write_ptr[(D-1):0])==(read_ptr[(D-1):0])) );
  
  assign empty=(read_ptr==write_ptr);
  
endmodule
