`timescale 1ns/1ps
`include "debouncer.v"

module debouncer_tb;

  reg clk;
  reg rst_n;
  reg btn;
  wire debounced;

  debouncer u_debouncer(
    .clk_i      (clk),
    .rst_ni     (rst_n),
    .btn_i      (btn),
    .debounced_o(debounced)
  );

  initial begin
    clk = 0;
    rst_n = 0;
    btn = 0;
    #15;
    rst_n = 1;
    #17;
    btn = #32 ~btn;
    btn = #20 ~btn;
    btn = #29 ~btn;
    btn = #20 ~btn;
    btn = #29 ~btn;
    btn = #10 ~btn;
    btn = #34 ~btn;
    btn = #10 ~btn;
    btn = #10 ~btn;
    btn = 1;
    #200;
    $finish;
  end

  always begin
    clk = #4 ~clk;
  end

  initial begin
    $dumpfile("debouncer.vcd");
    $dumpvars;
  end

endmodule
