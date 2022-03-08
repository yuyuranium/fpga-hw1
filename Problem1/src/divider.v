module divider (
  input      clk_i,
  input      rst_ni,  // asynchronous active-low reset
  output reg clk_div_o
);

  reg [25:0] cnt;

  always @(posedge clk_i or posedge rst_ni) begin
    if (rst_ni) begin
      cnt       <= 26'd0;
      clk_div_o <= 'b0;
    end else begin
      if (cnt == 62500000 - 1)
        cnt <= 26'd0;
      else
        cnt <= cnt + 1;

      if (cnt < 31250000 - 1)
        clk_div_o <= 'b0;
      else
        clk_div_o <= 'b1;
    end
  end

endmodule
