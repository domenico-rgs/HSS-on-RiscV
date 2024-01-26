`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: MCLab (UniPV)
// Engineer: D. Ragusa
// 
// Create Date: 11/29/2023 05:41:42 PM
// Module Name: exp
// Project Name: HSS on AIRISC
// Target Devices: Nexys4 DDR, NexysVideo
// Tool Versions: Vivado 2023.2
//
// Description: 
// Exp(x) implemented through Taylor series centered in 0. Coefficients use a 3.12 fixed point representation and are stored in a .hex file.
// Each term of the exponential is computed in pipeline.
//
// Revision:
// Revision 0.01 - File Created
//
//////////////////////////////////////////////////////////////////////////////////

`include "system_defines.vh"

module exp #(parameter N_STAGE = 2)(
        input aclk, aresetn,
        input signed [31:0] s_axis_data_tdata,
        input s_axis_data_tvalid,
        output s_axis_data_tready,
        output signed [31:0] m_axis_data_tdata,
        output m_axis_data_tvalid,
        input m_axis_data_tready
);
  
  localparam PIPE_NREG = 3;
  
  reg signed [31:0] pipe_reg[0:N_STAGE-1][0:PIPE_NREG-1];
  reg signed [31:0] coeff[0:N_STAGE-1];

  reg tready_internal;
  reg validity[0:N_STAGE-1];
  
  integer i, j;
  
  initial begin
    $readmemh(`EXP_COEFF_FILE,coeff);

    for(j=0; j<N_STAGE; j=j+1) begin
        for(i=0; i<PIPE_NREG; i = i+1) begin
            pipe_reg[j][i] <= 32'h0;
        end
        
        validity[j] <= 1'b0;
    end
    
    tready_internal <= 1'b1;
  end
  
  always @(posedge aclk) begin
    if (aresetn) begin
        for(j=0; j<N_STAGE; j=j+1) begin
            for(i=0; i<PIPE_NREG; i = i+1) begin
                pipe_reg[j][i] <= 32'h0;
            end
            validity[j] <= 1'b0;
        end
        
        tready_internal <= 1'b1;
    end else if (m_axis_data_tready) begin
        if(s_axis_data_tvalid) begin
            //Stage 0
            validity[0] <= 1'b1;
            pipe_reg[0][0] <= s_axis_data_tdata;
            pipe_reg[0][1] <= (s_axis_data_tdata*s_axis_data_tdata); //implements the computation of the power of the input (x^power) through stages
            pipe_reg[0][2] <= s_axis_data_tdata + ((s_axis_data_tdata*s_axis_data_tdata)/coeff[0]);
            
            //Following stages
            for(i=1; i<N_STAGE; i = i+1) begin
                validity[i] <= validity[i-1];
                pipe_reg[i][0] <= pipe_reg[i-1][0];
                pipe_reg[i][1] <= ((pipe_reg[i-1][1] >>> `H_FXP_DECIMAL_BITS) * pipe_reg[i-1][0]); //need to rescale otherwise it scales up at each stage
                pipe_reg[i][2] <= pipe_reg[i-1][2] + (((pipe_reg[i-1][1] >>> `H_FXP_DECIMAL_BITS) * pipe_reg[i-1][0]) / coeff[i]);
            end
            
        end else begin
            validity[0] <= 1'b0;
        end
        
        tready_internal <= 1'b1;
    end else begin
        tready_internal <= 1'b0;
    end
  end
  
    assign m_axis_data_tdata = pipe_reg[N_STAGE-1][2] + `H_ONE;
    assign m_axis_data_tvalid = validity[N_STAGE-1];
    assign s_axis_data_tready = tready_internal;
endmodule