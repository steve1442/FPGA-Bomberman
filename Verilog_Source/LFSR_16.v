`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2023 06:06:38 PM
// Design Name: 
// Module Name: LFSR_16
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


module LFSR_16(
    input wire clk, rst, w_en,
    input wire [15:0] w_in,
    output wire [15:0] out
    );
    
    wire XNOR;
    reg [15:0] data = 16'h5EED;
    always @(posedge clk) begin
    if(rst !=1) begin
       if(w_en == 1) begin
       data <= w_in;
       end 
       else begin
       data <= {data[14:0], XNOR};
       end
    end
    end
    

        assign XNOR = data[1] ^ data[2] ^ data[4] ^ data[15];

    
    
    assign out = data[15:0];
    
    
    
    
endmodule
