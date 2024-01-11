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

`include "log_param.vh"

module log #(parameter N_STAGE = 2) (
    input CLK, RST,
    input wire [15:0] data, //1 has to be subtracted to work properly
    output reg signed [15:0] output_data
    );
    
  reg signed [31:0] pipe_reg[0:N_STAGE-1][0:`PIPE_NREG-1];
  reg signed [15:0] coeff[0:N_STAGE-1];
  integer i, j;
  
  //https://stackoverflow.com/questions/61541044/i-am-new-to-verilog-if-initial-block-can-not-be-synthesized-then-how-to-initial
  initial begin
    $readmemh(`COEFF_FILE,coeff); //https://docs.xilinx.com/r/en-US/ug901-vivado-synthesis/Initializing-Block-RAM-From-an-External-Data-File-Verilog

    for(j=0; j<N_STAGE; j=j+1) begin
        for(i=0; i<`PIPE_NREG; i = i+1) begin
            pipe_reg[j][i] <= 32'h0;
        end
    end
    output_data <= 16'h0;
  end

  always @(posedge CLK or negedge RST) begin
    if (RST) begin
        for(j=0; j<N_STAGE; j=j+1) begin
            for(i=0; i<`PIPE_NREG; i = i+1) begin
                pipe_reg[j][i] <= 32'h0;
            end
        end
        output_data <= 16'h0;

    end else begin
        //Stage 0
        pipe_reg[0][0] <= data;
        pipe_reg[0][1] <= (data*data); //implements the computation of the power of the input (x^power) through stages
        pipe_reg[0][2] <= data - ((data*data) / coeff[0]);
        
        //Following stages
        for(i=1; i<N_STAGE; i = i+1) begin
            pipe_reg[i][0] <= pipe_reg[i-1][0];
            pipe_reg[i][1] <= ((pipe_reg[i-1][1] >> `DECIMAL_BITS) * pipe_reg[i-1][0]); //need to rescale otherwise it scales up at each stage
            pipe_reg[i][2] <= pipe_reg[i-1][2] + (((pipe_reg[i-1][1] >> `DECIMAL_BITS) * pipe_reg[i-1][0]) / coeff[i]);
        end
        
        output_data <= pipe_reg[N_STAGE-1][2];
    end
  end
endmodule