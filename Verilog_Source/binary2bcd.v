`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2023 10:18:26 PM
// Design Name: 
// Module Name: binary2bcd
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module binary2bcd(
    input wire clk, reset,
    input wire start,
    input wire [13:0] in,
    output wire [3:0] bcd3, bcd2, bcd1, bcd0,
    output wire [3:0] count,
    output wire [1:0] state
    );
    reg [5:0] add;
    reg [15:0] bcd_total;
    reg [10:0] bcd_state;
    reg [20:0] shift_count;
    reg [3:0] bcd3_reg;
    reg [3:0] bcd2_reg;
    reg [3:0] bcd1_reg;
    reg [3:0] bcd0_reg;
    always@(posedge clk) begin
    case (bcd_state)
    0: begin
    bcd_total <= 0;
    shift_count <= 0;
    bcd_state<=bcd_state + 1; 
    end
    
    1: begin
    bcd_state<=bcd_state + 1;
    end
    
    2: begin
    case(add)
    0: begin
    if(bcd_total[3:0] > 4) begin
        bcd_total <= bcd_total + 3;
    end 
    add <= add + 1;
    end
    
    1: begin
    if(bcd_total[7:4] > 4) begin
        bcd_total[15:4] <= bcd_total[15:4] + 3;
    end 
    add <= add + 1;    
    end
    
    2: begin
    if(bcd_total[11:8] > 4) begin
        bcd_total[15:8] <= bcd_total[15:8] + 3;
    end 
    add <= add + 1;    
    end
    
    3: begin
    if(bcd_total[15:12] > 4) begin
        bcd_total[15:12] <= bcd_total[15:12] + 3;
    end 
    add <= 0;
    bcd_state<=bcd_state + 1;
    end
    endcase 
    end
    
    3: begin
    bcd_total <= (bcd_total << 1) + in[14-shift_count];
    if(shift_count == 14) begin
        bcd_state <= bcd_state + 1;
    end
    else begin
        bcd_state <= 2;
        shift_count <= shift_count + 1;
    end
    end
    
    4: begin
        bcd3_reg <= bcd_total[15:12];
        bcd2_reg <= bcd_total[11:8];
        bcd1_reg <= bcd_total[7:4];
        bcd0_reg <= bcd_total[3:0];
        bcd_state <= 0;
    end
    endcase
    end

  assign bcd3 = bcd3_reg;
  assign bcd2 = bcd2_reg;
  assign bcd1 = bcd1_reg;
  assign bcd0 = bcd0_reg;
endmodule
