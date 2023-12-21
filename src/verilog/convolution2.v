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
    
  reg signed [31:0] pipeline_reg[0:W_WIDTH-1]; //31:0
  reg signed [15:0] buffer[0:W_WIDTH-1];
  reg signed [15:0] coeff[0:W_WIDTH-1];
  reg [4:0] sample_index;
  reg [2:0] clock_count;
  reg parity;
  integer i;
  
  //!! Check whether coeff is initilized after synthesis
  initial begin
    parity <= 1'b1;
    sample_index <= 5'b0;
    write_enable <= 1'b0;
    clock_count <= 3'b0;
    
    if (MODE) begin
        $readmemh("lo_d_coeff.hex",coeff);
    end else begin
        $readmemh("hi_d_coeff.hex",coeff);
    end
    
    for(i = 0; i<W_WIDTH; i=i+1) begin
        buffer[i] <= 16'h0;
        pipeline_reg[i] <= 16'h0;
    end
  end
    
  always @(posedge CLK or posedge RST) begin
    if (RST) begin
        for(i = 0; i<W_WIDTH; i=i+1) begin
            buffer[i] <= 16'h0;
            pipeline_reg[i] <= 16'h0;
        end
        
        parity <= 1'b1;
        sample_index <= 5'b0;
        write_enable <= 1'b0;
        clock_count <= 3'b0;
  
    end else if (in_parity) begin
        // At each clock the buffer is filled with the new data so a 20 samples window is obtained for convolution
        for(i = 1; i<W_WIDTH; i=i+1) begin
            buffer[i] <= buffer[i-1];
        end
        buffer[0]<=input_data;
    
        //Stage 0
        for(i = 0; i<W_WIDTH; i=i+1) begin
            pipeline_reg[i] = (buffer[i] * coeff[i]) >> 14;
        end

        //Stage 1
        for(i = 0; i<W_WIDTH/2; i=i+1) begin
            pipeline_reg[2*i] = pipeline_reg[2*i] + pipeline_reg[2*i+1];
        end

        //Stage 2
        for(i = 0; i<W_WIDTH/4; i=i+1) begin
            pipeline_reg[4*i] = pipeline_reg[4*i] + pipeline_reg[4*i+2];
        end

        //Stage 3
        pipeline_reg[0] = pipeline_reg[0] + pipeline_reg[4];
        pipeline_reg[8] = pipeline_reg[8] + pipeline_reg[12] + pipeline_reg[16];
        
        //Stage 4
        pipeline_reg[0] = pipeline_reg[0] + pipeline_reg[8];
        
        if(sample_index % 2 == 0) begin
            parity = 1'b1;
        end else begin
            parity = 1'b0;
        end
        
        if(clock_count >= 6) begin
            write_enable = (MODE == 1 && parity);
        end else begin
            write_enable = 0;
        end
        
        clock_count = clock_count + 1;
        sample_index = sample_index + 1;
    end
  end
  
  assign out_parity = parity;
  assign output_data = pipeline_reg[0];
endmodule