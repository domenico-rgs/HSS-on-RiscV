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
// Ln(x) implemented through Taylor series centered in 1. Coefficients use a 5.10 fixed point representation and are stored in a .hex file.
// Each term of the logarithm is computed in pipeline.
//
// Revision:
// Revision 0.01 - File Created
//
//////////////////////////////////////////////////////////////////////////////////

`include "system_defines.vh"

module log #(parameter N_STAGE = 2) (
    input CLK, RST,
    input wire signed [31:0] data, //1 has to be subtracted to work properly
    output reg signed [31:0] output_data
    );
    
  localparam PIPE_NREG = 3;
  
  reg signed [31:0] pipe_reg[0:N_STAGE-1][0:PIPE_NREG-1];
  reg signed [31:0] coeff[0:N_STAGE-1];
  integer i, j;
  
  //https://stackoverflow.com/questions/61541044/i-am-new-to-verilog-if-initial-block-can-not-be-synthesized-then-how-to-initial
  initial begin
    $readmemh(`LOG_COEFF_FILE,coeff); //https://docs.xilinx.com/r/en-US/ug901-vivado-synthesis/Initializing-Block-RAM-From-an-External-Data-File-Verilog

    for(i=0; i<N_STAGE; i = i+1) begin
        for(j=0; j<PIPE_NREG; j = j+1) begin
            pipe_reg[i][j] <= 32'h0;
        end
    end
    
    output_data <= 32'h0;
  end

  always @(posedge CLK) begin
    if (RST) begin
        for(i=0; i<N_STAGE; i = i+1) begin
            for(j=0; j<PIPE_NREG; j = j+1) begin
                pipe_reg[i][j] <= 32'h0;
            end
        end
        
        output_data <= 32'h0;
    end else begin
        //Stage 0
        pipe_reg[0][0] <= data;
        pipe_reg[0][1] <= (data*data); //implements the computation of the power of the input (x^power) through stages
        pipe_reg[0][2] <= data - ((data*data) / coeff[0]);
        
        //Following stages
        for(i=1; i<N_STAGE; i = i+1) begin
            pipe_reg[i][0] <= pipe_reg[i-1][0];
            pipe_reg[i][1] <= ((pipe_reg[i-1][1] >>> `H_FXP_DECIMAL_BITS) * pipe_reg[i-1][0]); //need to rescale otherwise it scales up at each stage
            pipe_reg[i][2] <= pipe_reg[i-1][2] + (((pipe_reg[i-1][1] >>> `H_FXP_DECIMAL_BITS) * pipe_reg[i-1][0]) / coeff[i]);
        end
        
        output_data <= pipe_reg[N_STAGE-1][2];
    end
  end
endmodule