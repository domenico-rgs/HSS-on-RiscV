`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: MCLab (UniPV)
// Engineer: D. Ragusa
// 
// Create Date: 12/20/2023 09:46:36 AM
// Module Name: convolution2
// Project Name: HSS on AIRISC
// Target Devices: Nexys4 DDR, NexysVideo
// Tool Versions: Vivado 2023.2
//
// Description: 
// Implementation of a 1D convolution with the (20) coefficients for the Daubechies 10 taken from Matlab R2023b - wfilters() and formatted as 1.14 fixed point data.
// The convolution is implemented as a reduction in pipeline. The module can be used to compute both the low and high pass filter according to parameter MODE.
// In order to perform a downsampling, a the end a parity signal is output to indicate wether the sample index is odd or even and eventually letting the following module to discard it.
//
// Revision:a
// Revision 0.01 - File Created
//
//////////////////////////////////////////////////////////////////////////////////

`include "system_defines.vh"

module convolution #(parameter MODE = 0) //0 = low pass filter, 1 = high pass filter
    ( 
    input CLK, RST, in_parity,
    input wire signed [31:0] input_data,
    output reg signed [31:0] output_data,
    output reg parity
    );
    
  localparam WIDTH = 20;
  localparam N_STAGES = 5;
    
  reg signed [63:0] pipeline_reg_stage0[0:WIDTH-1];
  reg signed [63:0] pipeline_reg_stage1[0:WIDTH/2-1];
  reg signed [63:0] pipeline_reg_stage2[0:WIDTH/4-1];
  reg signed [63:0] pipeline_reg_stage3[0:1];
  reg signed [63:0] pipeline_reg_stage4;
  
  reg signed [31:0] buffer[0:WIDTH-1]; //buffer[19] seams unused because coeff[19] for hi-pass is 0, check fixed point representation
  reg signed [31:0] coeff[0:WIDTH-1];
  reg [4:0] sample_index;
  reg [2:0] current_stage;
  integer i;
  
  initial begin
    parity <= 1'b0;
    sample_index <= 5'b0;
    current_stage <= 3'b0;
    
    if (MODE) begin
        $readmemh(`HI_COEFF_FILE,coeff);
    end else begin
        $readmemh(`LO_COEFF_FILE,coeff);
    end
    
    for(i = 0; i<WIDTH; i=i+1) begin
        buffer[i] <= 32'h0;
        pipeline_reg_stage0[i] <= 64'h0;
    end
    for(i = 0; i<WIDTH/2; i=i+1) begin
        pipeline_reg_stage1[i] <= 64'h0;
    end
    for(i = 0; i<WIDTH/4; i=i+1) begin
        pipeline_reg_stage2[i] <= 64'h0;
    end
    pipeline_reg_stage3[0] <= 64'h0;
    pipeline_reg_stage3[1] <= 64'h0;
    pipeline_reg_stage4 <= 64'h0;
    
    output_data <= 32'h0;
  end
    
  always @(posedge CLK) begin        
    if (RST) begin  
        parity <= 1'b0;
        sample_index <= 5'b0;
        current_stage <= 3'b0;
        
        for(i = 0; i<WIDTH; i=i+1) begin
            buffer[i] <= 32'h0;
            pipeline_reg_stage0[i] <= 64'h0;
        end
        for(i = 0; i<WIDTH/2; i=i+1) begin
            pipeline_reg_stage1[i] <= 64'h0;
        end
        for(i = 0; i<WIDTH/4; i=i+1) begin
            pipeline_reg_stage2[i] <= 64'h0;
        end
        pipeline_reg_stage3[0] <= 64'h0;
        pipeline_reg_stage3[1] <= 64'h0;
        pipeline_reg_stage4 <= 64'h0;
        
        output_data <= 32'h0;
  
    end else if (in_parity) begin
        // At each clock the buffer is filled with the new data so a 20 samples window is obtained for convolution
        for(i = 1; i<WIDTH; i=i+1) begin
            buffer[i] <= buffer[i-1];
        end
        buffer[0]<=input_data;
        
        //Stage 0
        for(i = 0; i<WIDTH; i=i+1) begin
            pipeline_reg_stage0[i] <= (buffer[i] * coeff[i]);
        end

        //Stage 1
        for(i = 0; i<WIDTH/2; i=i+1) begin
            pipeline_reg_stage1[i] <= pipeline_reg_stage0[2*i] + pipeline_reg_stage0[2*i+1];
        end

        //Stage 2
        for(i = 0; i<WIDTH/4; i=i+1) begin
            pipeline_reg_stage2[i] <= pipeline_reg_stage1[2*i] + pipeline_reg_stage1[2*i+1];
        end

        //Stage 3
        pipeline_reg_stage3[0] <= pipeline_reg_stage2[0] + pipeline_reg_stage2[1];
        pipeline_reg_stage3[1] <= pipeline_reg_stage2[2] + pipeline_reg_stage2[3]+ pipeline_reg_stage2[4];

        //Stage 4
        pipeline_reg_stage4 <= pipeline_reg_stage3[0] + pipeline_reg_stage3[1];
        
        //Stage 5
        output_data <= pipeline_reg_stage4 >>> `WAVE_FXP_DECIMAL_BITS; //the number of stage is odd so, pipeline_reg_stage2 is forwarded
 
        if (current_stage <= N_STAGES) begin
            current_stage <= current_stage + 1;
        end else begin
            parity <= sample_index % 2 != 0 ? 1 : 0;
        end
        
        sample_index <= sample_index + 1;
    end else begin
        parity <= 0;
    end
  end
endmodule