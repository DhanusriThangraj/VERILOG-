// Code your design here
module asynchronous_fifo #(
  parameter data_width=4,
  parameter addr_width=3,
  parameter depth=1<<addr_width )//2^addr_width;
  ( input wr_clk,
    input wr_en,
    input wr_reset,
    input [data_width-1:0] data_in,
    
    input rd_clk,
    input rd_en,
    input rd_reset,
    output reg [data_width-1:0]data_out,
    output reg empty,
    output reg full,
    output reg overflow,
    output reg underflow);
  
 
  
  wire wfull,rempty;
  
  reg [data_width-1:0]ram[depth-1:0];

  reg [addr_width:0]wr_ptr,wr_next,wr_ptr_gray;
  reg [addr_width:0]rd_ptr,rd_next,rd_ptr_gray;

  reg [addr_width:0] rd_gray_syn_wr1,rd_gray_syn_wr2;
  reg [addr_width:0] wr_gray_syn_rd1,wr_gray_syn_rd2;
  
  
  always @(posedge wr_clk or posedge wr_reset) begin
    if(wr_reset)begin
     
      wr_ptr<=0;
      wr_next<=0;
      wr_ptr_gray<=0;
      rd_gray_syn_wr1<=0;
      rd_gray_syn_wr2<=0;
    end
    else begin
      if(!full&&wr_en)begin
        ram[wr_ptr[addr_width-1:0]]<=data_in;
        wr_next = wr_ptr + 1;       // blocking
        wr_ptr <= wr_next;          // nonblocking
        wr_ptr_gray<=(wr_next)^(wr_next>>1);
      end
       rd_gray_syn_wr1<=rd_ptr_gray;
       rd_gray_syn_wr2<=rd_gray_syn_wr1;
      
    end
  end
  
  always @(posedge wr_clk or posedge wr_reset)begin
    if(wr_reset)begin
      overflow<=0;
    end
    else if(wr_en&&full)begin
      overflow<=1;
    end
  end
  
  
  always @(posedge rd_clk or posedge rd_reset)begin
    if(rd_reset)begin
    
      rd_ptr<=0;
      rd_ptr_gray<=0;
      rd_next <=0;
      wr_gray_syn_rd1<=0;
      wr_gray_syn_rd2<=0;
      data_out<=0;
    end
   else begin
     if(!empty&& rd_en)begin
       data_out<=ram[rd_ptr[addr_width-1:0]];
       rd_next = rd_ptr + 1;       // blocking
       rd_ptr <= rd_next;          // nonblocking
       rd_ptr_gray<=(rd_next)^(rd_next>>1);
     end
      wr_gray_syn_rd1<=wr_ptr_gray;
      wr_gray_syn_rd2<=wr_gray_syn_rd1; 
   end
  end
  
  
  always @(posedge rd_clk or posedge rd_reset)begin
    if(rd_reset)begin
      underflow<=0;
    end
    else if(rd_en&&empty)begin
      underflow<=1;
    end
  end
  
 always @(posedge wr_clk or posedge wr_reset)begin
    if(wr_reset)begin
      full<=0;
    end
  else
    full<=wfull;
  end
  
  assign wfull=(wr_ptr_gray=={~rd_gray_syn_wr2[addr_width:addr_width-1],rd_gray_syn_wr2[addr_width-2:0]});
  
  always @(posedge rd_clk or posedge rd_reset)begin
    if(rd_reset)begin
      empty<=1;
  end
    else 
      empty<=rempty;
  end
  
  assign rempty = (rd_ptr_gray == wr_gray_syn_rd2 );
  
endmodule
