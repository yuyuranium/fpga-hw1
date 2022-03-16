`include "divider.v"
`include "debouncer.v"

module Controller ( input clk,
                    input rst,
                    input [1:0] SW,
                    input [2:0] BTN,
                    output reg [2:0] led4,
                    output reg [2:0] led5,
                    output reg [3:0] led
                  );

parameter IDLE = 3'd0,
          T1G_T2R = 3'd1,
          T1Y_T2R = 3'd2,
          T1R_T2R = 3'd3,
          T2G_T1R = 3'd4,
          T2Y_T1R = 3'd5,
          T2R_T1R = 3'd6,
          CHANGE_SEC = 3'd7;
          
wire div_clk;
wire [2:0] debouncer_BTN;
wire zero;
reg [3:0] changed_light, new_light;
reg [2:0] state, n_state;
reg [3:0] sec_cnt, n_sec_cnt;
reg [3:0] rg_length, n_rg_length;
reg [3:0] yellow_length, n_yellow_length;
reg [3:0] rr_length, n_rr_length;

divider divider(.clk_i(clk), .rst_ni(rst), .clk_div_o(div_clk));
debouncer debouncer0 (.clk_i(clk),.rst_ni(rst),.btn_i(BTN[0]),.debounced_o(debouncer_BTN[0]));
debouncer debouncer1 (.clk_i(clk),.rst_ni(rst),.btn_i(BTN[1]),.debounced_o(debouncer_BTN[1]));
debouncer debouncer2 (.clk_i(clk),.rst_ni(rst),.btn_i(BTN[2]),.debounced_o(debouncer_BTN[2]));

assign zero = ~|sec_cnt;


/* traffic light counter */
always@(posedge div_clk or negedge rst)begin
  if(!rst)begin
    sec_cnt <= 4'd0;
  end
  else begin
    sec_cnt <= n_sec_cnt;
  end
end
always@(*)begin
  if( SW==2'b00 )begin
    if(state != n_state)begin
      case(n_state)
        T1G_T2R: n_sec_cnt = rg_length;
        T1Y_T2R: n_sec_cnt = yellow_length;
        T1R_T2R: n_sec_cnt = rr_length;
        T2G_T1R: n_sec_cnt = rg_length;
        T2Y_T1R: n_sec_cnt = yellow_length;
        T2R_T1R: n_sec_cnt = rr_length;
        default: n_sec_cnt = sec_cnt;
      endcase
    end
    else begin
      n_sec_cnt = sec_cnt - 4'd1;
    end
  end
  else begin
      n_sec_cnt = sec_cnt;
  end
end

/* FSM */
always@(posedge clk or negedge rst)begin
  if(!rst)begin
    state <= IDLE;
  end
  else begin
    state <= n_state;
  end
end
always@(*)begin
  case(SW)
    2'b00:begin
      case(state)
        IDLE: n_state = T1G_T2R;
        T1G_T2R: begin
          if(zero)begin
            n_state = T1Y_T2R;
          end else begin
            n_state = state;
          end
        end
        T1Y_T2R: begin
          if(zero)begin
            n_state = T1R_T2R;
          end else begin
            n_state = state;
          end
        end
        T1R_T2R: begin
          if(zero)begin
            n_state = T2G_T1R;
          end else begin
            n_state = state;
          end
        end
        T2G_T1R: begin
          if(zero)begin
            n_state = T2Y_T1R;
          end else begin
            n_state = state;
          end
        end
        T2Y_T1R: begin
          if(zero)begin
            n_state = T2R_T1R;
          end else begin
            n_state = state;
          end
        end
        T2R_T1R: begin
          if(zero)begin
            n_state = T1G_T2R;
          end else begin
            n_state = state;
          end
        end
        default:begin
          n_state = T1G_T2R;
        end
      endcase
    end
    default: n_state = CHANGE_SEC;
  endcase
end

/* set light count */
always@(posedge clk or negedge rst)begin
  if(!rst)begin
    rg_length <= 4'd5;
    yellow_length <= 4'd1;
    rr_length <= 4'd1;
  end
  else begin
    rg_length <= n_rg_length;
    yellow_length <= n_yellow_length;
    rr_length <= n_rr_length;
  end
end

always@(*)begin
  n_rg_length = rg_length;
  n_yellow_length = yellow_length;
  n_rr_length = rr_length;
  case(SW)
    2'b01:n_rg_length = new_light;
    2'b10:n_yellow_length = new_light;
    2'b11:n_rr_length = new_light;
  endcase
end

always@(*)begin
  case(SW)
    2'b01:changed_light = rg_length;
    2'b10:changed_light = yellow_length;
    2'b11:changed_light = rr_length;
    default:changed_light = 4'd0;
  endcase
end

/* modify light sec */
always@(*)begin  
  if(debouncer_BTN[1])begin // sec +1
    if(&changed_light)begin
      new_light = changed_light;
    end else begin
      new_light = changed_light + 4'd1;
    end
  end  
  else if(debouncer_BTN[2])begin //sec -1
    if(~|changed_light)begin
      new_light = changed_light;
    end else begin
      new_light = changed_light - 4'd1;
    end
  end  
  else if(debouncer_BTN[0])begin //do reset
    case(changed_light)
      rg_length:new_light = 4'd5;
      yellow_length:new_light = 4'd1;
      rr_length:new_light = 4'd1;
      default: new_light = changed_light;
    endcase
  end 
  else begin
    new_light = changed_light;
  end
end

/* led control */
always@(*)begin
  case(SW)
    2'b00:begin
      case(state)
        T1G_T2R:begin
          led4 = 3'b010;
          led5 = 3'b100;
        end
        T1Y_T2R:begin
          led4 = 3'b011;
          led5 = 3'b100;
        end
        T1R_T2R:begin
          led4 = 3'b100;
          led5 = 3'b100;
        end
        T2G_T1R:begin
          led4 = 3'b100;
          led5 = 3'b010;
        end
        T2Y_T1R:begin
          led4 = 3'b100;
          led5 = 3'b011;
        end
        T2R_T1R:begin
          led4 = 3'b100;
          led5 = 3'b100;
        end
        default:begin
          led4 = 3'b001;
          led5 = 3'b001;
        end
      endcase
    end
    2'b01:begin
      led4 = 3'b100; //R
      led5 = 3'b010; //G
    end
    2'b10:begin
      led4 = 3'b011; // Y
      led5 = 3'b011; // Y
    end
    2'b11:begin
      led4 = 3'b000; // White
      led5 = 3'b000; // White
    end
    default:begin
      led4 = 3'b001;
      led5 = 3'b001;
    end
  endcase
end

/* LED display */
always@(*)begin
  case(SW)
    2'b00: led = sec_cnt;
    2'b01: led = rg_length;
    2'b10: led = yellow_length;
    2'b11: led = rr_length;
    default: led = sec_cnt;
  endcase
end


endmodule