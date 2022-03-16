module top(
input [1:0] sw,
output [2:0] rgb
    );
    
   decoder u_decoder(
  .sw_i (sw),
  .rgb_o (rgb)
  );
  
endmodule
