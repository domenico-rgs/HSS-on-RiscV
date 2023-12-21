`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: MCLab (UniPV)
// Engineer: D. Ragusa
// 
// Create Date: 12/01/2023 01:03:57 PM
// Module Name: Butterworth_LP
// Project Name: HSS on AIRISC
// Target Devices: Nexys4 DDR, NexysVideo
// Tool Versions: Vivado 2023.2
// 
// Description: 
// The module is used to apply a low pass filtering to the signal in input.
// This digital implementation is based on the bilinear transform: https://en.wikipedia.org/wiki/Bilinear_transform
// Coefficients for each term are obtained by using a and b values from Matlab R2023b (see butter() function) and applying the equation as before.
// They are represented as 5.10 fixed point.
//
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module Butterworth_LP(
  input CLK, RST,
  input wire signed [15:0] data,
  output wire signed [15:0] out
);

  reg signed [15:0] x_past, y_past;
  reg signed [31:0] y_out; //32 bits to avoid overflow in the following
  reg signed [15:0] coeff[0:2];

  //!! Check whether coeff is initilized after synthesis
  initial begin
    $readmemh("butter_coeff.hex",coeff);
    
    x_past <= 16'h0;
    y_past <= 16'h0;
    y_out <= 16'h0;
  end

  always @(posedge CLK or posedge RST) begin
    if (RST) begin
      x_past <= 16'h0;
      y_past <= 16'h0;
      y_out <= 16'h0;
      
    end else begin
      y_out = (coeff[0] * data + coeff[1] * x_past + coeff[2] * y_past) >> 10;
      
      x_past = data;
      y_past = y_out;
    end
  end

  assign out = y_out;
endmodule