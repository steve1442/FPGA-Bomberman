`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2023 12:50:19 PM
// Design Name: 
// Module Name: VGA
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


module VGA(
input pix_clk,
input reset,
output display_on,
output p_tick,
output Hsync,
output Vsync,
output [9:0] x_pos,
output [9:0] y_pos
    );
    localparam h_pix = 800;
    localparam h_pulse = 96;
    localparam h_fp = 16;
    localparam h_bp = 48;
    localparam v_pix = 521;
    localparam v_pulse = 2;
    localparam v_fp = 10;
    localparam v_bp = 29;
    
    reg [9:0] row_pix;
    reg [9:0] col_pix;
    
    always@( posedge pix_clk) begin
    if ((row_pix == h_pix -1) && (col_pix < v_pix-1)) begin 
        col_pix = col_pix+1;
        row_pix = 0;
    end
    else if ((row_pix==h_pix) && (col_pix==v_pix-1)) begin
        row_pix = 0;
        col_pix = 0;
    end
    else begin
        row_pix = row_pix+1;
    end
    end
    

    assign display_on = !((row_pix < (h_pulse + h_bp)) || (row_pix > (h_pix - h_bp)) || (col_pix < (v_pulse + v_bp)) || (col_pix > (v_pix /*- v_bp*/)));
    
    assign Hsync = ((row_pix < h_pulse)/* || (row_pix==(h_pix-(h_bp-1)))*/) ? 0:1;
    assign Vsync = ((col_pix < v_pulse)/* || (col_pix==(v_pix-(v_bp-1)))*/) ? 0:1;
    assign x_pos = row_pix - (h_pulse + h_bp);
    assign y_pos = col_pix - (v_pulse + v_bp);
    
    assign p_tick = pix_clk;
endmodule
