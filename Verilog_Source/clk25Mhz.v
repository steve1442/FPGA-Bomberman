`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2023 02:00:12 PM
// Design Name: 
// Module Name: clk25Mhz
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


module clk25Mhz(
    input clk,
    output reg new_clk_25mhz
    );
    reg [18:0] N;
    always @(posedge clk) begin
    
    if(N==1) begin
        new_clk_25mhz = ~new_clk_25mhz;
        N=0;
    end
    else begin
       N=N+1;
    end
    end
    
endmodule
