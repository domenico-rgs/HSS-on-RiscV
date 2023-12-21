`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: MCLab (UniPV)
// Engineer: D. Ragusa
// 
// Create Date: 11/29/2023 04:44:47 PM
// Module Name: log
// Project Name: HSS on AIRISC
// Target Devices: Nexys4 DDR, NexysVideo
// Tool Versions: Vivado 2023.2
//
// Description: 
// Ln(x) implemented through Taylor series centered in 0. Coefficients use a 5.10 fixed point representation and are stored in a .hex file.
// Each term of the logarithm is computed in pipeline.
//
// Revision:
// Revision 0.01 - File Created
//
//////////////////////////////////////////////////////////////////////////////////

module log #(parameter N_STAGE = 2) (
    input CLK, RST,
    input wire [15:0] data,
    output wire signed [15:0] output_data
    );
    
  reg signed [31:0] pipeline_output[0:N_STAGE-1];
  reg signed [31:0] pipe_power_reg[0:N_STAGE-1];
  reg signed [15:0] coeff[0:N_STAGE-1];
  integer i;
  
  //!! Check whether coeff is initilized after synthesis
  initial begin
    $readmemh("log_coeff.hex",coeff);
    
    for(i=0; i<N_STAGE; i = i+1) begin
        pipe_power_reg[i] <= 32'h0;
        pipeline_output[i] <= 32'h0;
    end
  end

  always @(posedge CLK or posedge RST) begin
    if (RST) begin
        for(i=0; i<N_STAGE; i = i+1) begin
            pipe_power_reg[i] <= 32'h0;
            pipeline_output[i] <= 32'h0;
        end

    end else begin
        pipe_power_reg[0] = (data * data); //used to compute data^power
        pipeline_output[0] = data - (pipe_power_reg[0] / coeff[0]);
        
        for(i=1; i<N_STAGE; i=i+1) begin
            pipe_power_reg[i] = ((pipe_power_reg[i-1] >> 10) * data); //right shift used to rescale to 5.10 representation
            pipeline_output[i] = pipeline_output[i-1] + (pipe_power_reg[i] / coeff[i]);
        end
    end
  end
  
  assign output_data = pipeline_output[i];
endmodule