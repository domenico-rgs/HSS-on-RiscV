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

module convolution2 #(parameter MODE = 0, parameter W_WIDTH = 20) //0 = low pass filter
    ( 
    input CLK, RST, in_parity,
    input wire signed [15:0] input_data,
    output wire signed [15:0] output_data,
    output out_parity,
    output reg write_enable
    );
    
  reg signed [31:0] partial_sum[0:W_WIDTH-1]; //31:0
  reg signed [15:0] buffer[0:W_WIDTH-1]; //buffer[19] seams unused because coeff[19] for hi-pass is 0, check fixed point representation
  reg signed [15:0] coeff[0:W_WIDTH-1];
  reg [4:0] sample_index;
  reg [4:0] current_stage;
  reg parity;
  integer i;
  
  //!! Check whether coeff is initilized after synthesis
  initial begin
    parity <= 1'b1;
    sample_index <= 5'b0;
    write_enable <= 1'b0;
    current_stage <= 5'b0;
    
    if (MODE) begin
        $readmemh("lo_d_coeff.hex",coeff);
    end else begin
        $readmemh("hi_d_coeff.hex",coeff);
    end
    
    for(i = 0; i<W_WIDTH; i=i+1) begin
        buffer[i] <= 16'h0;
        partial_sum[i] <= 16'h0;
    end
  end
    
  always @(posedge CLK) begin        
    if (RST) begin
        write_enable <= 0;
        current_stage <= 5'b0;     
        parity <= 1'b1;
        sample_index <= 5'b0;
        
        for(i = 0; i<W_WIDTH; i=i+1) begin
            buffer[i] <= 16'h0;
            partial_sum[i] <= 16'h0;
        end
  
    end else if (in_parity) begin
        // At each clock the buffer is filled with the new data so a 20 samples window is obtained for convolution
        for(i = 1; i<W_WIDTH; i=i+1) begin
            buffer[i] <= buffer[i-1];
        end
        buffer[0]<=input_data;
        
        partial_sum[0] <= buffer[0] * coeff[0];
        for (i = 1; i < W_WIDTH; i = i + 1) begin
            partial_sum[i] <= partial_sum[i-1] + buffer[i] * coeff[i]; //multiplications require a lot of dsp blocks
        end
        
        parity <= sample_index % 2 == 0 ? 1 : 0;
        
        if(current_stage>=W_WIDTH-1) begin
            write_enable <= parity ? 0 : 1;
        end else begin
            current_stage <= current_stage + 1; //avoid writing zeros in memory at the beginning
        end
        
        sample_index <= sample_index + 1;
    end
  end
  
  assign out_parity = parity;
  assign output_data = partial_sum[W_WIDTH-1];
endmodule