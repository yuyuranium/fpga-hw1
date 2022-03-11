/* tb.v
 * This is the testbench module to test the decoder for Problem 1.
 */

`include "decoder.v"
`timescale 10ns/10ns

module tb;

reg  [1:0] sw;
wire [2:0] rgb;

decoder u_decoder(
  .sw_i (sw),
  .rgb_o(rgb)
);

initial begin
  sw = 0; #10;
  sw = 1; #10;
  sw = 2; #10;
  sw = 3; #10;
end

initial begin
  $dumpfile("decoder.vcd");
  $dumpvars;
end

endmodule
