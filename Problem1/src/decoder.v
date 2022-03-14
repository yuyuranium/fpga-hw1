/* decoder.v
 * The decoder for Problem 1. The spec:
 * | sw | color  |
 * |----|--------|
 * | 00 | white  |
 * | 01 | red    |
 * | 10 | green  |
 * | 11 | yellow |
 */

`include "def.v"

module decoder (
  input      [1:0] sw_i,
  output reg [2:0] rgb_o
);

always @(*) begin
  case (sw_i)
    2'b00:   rgb_o = `WHITE;
    2'b01:   rgb_o = `RED;
    2'b10:   rgb_o = `GREEN;
    2'b11:   rgb_o = `YELLOW;
    default: rgb_o = 3'bxx;
  endcase
end

endmodule
