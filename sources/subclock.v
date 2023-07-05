`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2023 12:05:56
// Design Name: 
// Module Name: subclock
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


module subclock(
    input wire clk_sys,
    input wire clk_40,
    
    output wire clk_10,
    output reg clk_5,
    output reg cpu_clk,
    output reg sound_clk
    );
    
    reg [3:0] cnt1;
    always @(posedge clk_sys) begin
      cnt1 <= cnt1 + 5'd1;
      if (cnt1 == 5'd9) begin
        cnt1 <= 5'd0;
        cpu_clk <= 1'b1;
      end
      else cpu_clk <= 1'b0;
    end
    
    // derive sound clock from clk_sys
    reg [5:0] cnt2;
    always @(posedge clk_sys) begin
      cnt2 <= cnt2 + 6'd1;
      sound_clk <= 1'b0;
      if (cnt2 == 6'd55) begin
        cnt2 <= 6'd0;
        sound_clk <= 1'b1;
      end
    end
    
    reg [1:0] cnt3;
    always @(posedge clk_40)
      cnt3 <= cnt3 + 2'd1;
    
    assign clk_10 = cnt3[1];
    
    always @(posedge clk_10)
      clk_5 <= ~clk_5;
    
endmodule
