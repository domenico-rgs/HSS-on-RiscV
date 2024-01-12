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

`include "butterworth.vh"

module butterworth_LP(
  input CLK, RST,
  input wire signed [31:0] data,
  output wire signed [31:0] output_data
);

  reg signed [31:0] x_past;
  reg signed [31:0] y_out, y_past;
  reg signed [31:0] coeff[0:`N_COEFF-1];
  
  initial begin
    $readmemh(`COEFF_FILE,coeff);
    y_past <= 0;
    x_past <= 32'h0;
    y_out <= 32'h0;
  end

  always @(posedge CLK) begin
    if (RST) begin
      x_past <= 32'h0;
      y_out <= 32'h0;

    end else begin
      x_past <= data;
      y_out <= (coeff[0] * data + coeff[1] * x_past + coeff[2] * y_out) >>> `DECIMAL_BITS;
    end
  end
  
  assign output_data = y_out;
endmodule