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
// They are represented as 3.12 fixed point.
//
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////

`include "system_defines.vh"

module butterworth_LP(
      input aclk, aresetn,
      input signed [31:0] s_axis_data_tdata,
      input s_axis_data_tvalid,
      output s_axis_data_tready,
      output signed [31:0] m_axis_data_tdata,
      output m_axis_data_tvalid,
      input m_axis_data_tready
);
    
  localparam N_COEFF = 3;
  
  reg signed [31:0] x_past;
  reg signed [127:0] y_out;
  reg signed [31:0] y_past;
  reg signed [31:0] coeff[0:N_COEFF-1];
  reg tready_internal, validity;
  
  initial begin
    $readmemh(`BUTTER_COEFF_FILE,coeff);
    y_past <= 0;
    x_past <= 32'h0;
    y_out <= 32'h0;
  end

  always @(posedge aclk) begin
    if (aresetn) begin
      x_past <= 32'h0;
      y_out <= 32'h0;

    end else if (m_axis_data_tready) begin
        if(s_axis_data_tvalid) begin
            x_past <= s_axis_data_tdata;
            y_out <= (coeff[0] * s_axis_data_tdata + coeff[1] * x_past + coeff[2] * y_out) >>> `H_FXP_DECIMAL_BITS;
            
            validity <= 1'b1;
        end else begin
            validity <= 1'b0;
        end
        
        tready_internal <= 1'b1;    
    end else begin
        tready_internal <= 1'b0;
    end
  end
  
  assign m_axis_data_tdata = y_out;
  assign s_axis_data_tready = tready_internal;
  assign m_axis_data_tvalid = validity;
endmodule