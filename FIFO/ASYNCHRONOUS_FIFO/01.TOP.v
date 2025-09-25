// Code your design here

`include "synchronizer.v"
`include "write_handler.v"
`include "read_handler.v"
`include "asynchronous_fifo.v"

module top #(parameter M=7,N=3,O=7)(input w_clk, r_clk,
                                    input r_en,w_en,
           input r_reset,w_reset,
           input [M:0]din,
           output [M:0]dout,
           output full,empty);
  
  wire [N:0] brptr,bwptr;
  wire [N:0] grptr,gwptr;
  wire [N:0] grptrsyn,gwptrsyn;
  
  wire [N:0]raddr,waddr;
  
  synchronizer #(.M(M)) s1 (
    .clk(w_clk),
    .reset(w_reset),
    .din(gwptr),
    .dout(gwptrsyn));
  
  synchronizer #(.M(M)) s2 (
    .clk(r_clk),
    .reset(r_reset),
    .din(grptr),
    .dout(grptrsyn));
  
  write_handler #(.N(N)) Write (.w_clk(w_clk),
                                .w_en(w_en),
                                .w_reset(w_reset),
                                .full(full),.gwptr(gwptr),.bwptr(bwptr),
                                .grptrsyn(grptrsyn));
  
  read_handler #(.N(N)) read (.r_clk(r_clk),
                              .r_en(r_en),
                              .r_reset(r_reset),
                              .empty(empty),
                              .grptr(grptr),
                              .brptr(brptr),
                              .gwptrsyn(gwptrsyn));
  
  
  asyn_fifo #(.N(N),.M(M),.O(O)) asyn (.w_clk(w_clk),
             .r_clk(r_clk),
             .w_en(w_en),
             .r_en(r_en),
             .din(din),
             .dout(dout),
             .full(full),
             .empty(empty),
             .bwptr(bwptr),
             .brptr(brptr));
  
endmodule
  
  
  
  
