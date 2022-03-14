module debouncer (
  input      clk_i,
  input      rst_ni,
  input      btn_i,
  output reg debounced_o
);

  reg [23:0] cnt;

  always @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      cnt <= 24'hffffff;
      debounced_o <= 1'b0;
    end else begin
      if (cnt == 24'hffffff) begin
        if (btn_i != debounced_o) begin
          debounced_o <= btn_i;
          cnt <= 24'd0;
        end
      end else begin
        cnt <= cnt + 24'd1;
      end
    end
  end

endmodule
