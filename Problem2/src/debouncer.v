module debouncer (
  input      clk_i,
  input      rst_i,
  input      btn_i,
  output reg debounced_o
);

  reg [23:0] cnt;

  always @(posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
      debounced_o <= btn_i;
      cnt         <= 24'hffffff;
    end else begin
      if (&cnt) begin
        if (btn_i != debounced_o) begin
          debounced_o <= btn_i;
          cnt         <= 24'd0;
        end else begin
          debounced_o <= debounced_o;
          cnt         <= cnt;
        end
      end else begin
        debounced_o <= debounced_o;
        cnt         <= cnt + 24'd1;
      end
    end
  end

endmodule
