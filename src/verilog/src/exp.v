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
// Exp(x) implemented through Taylor series centered in 0. Coefficients use a 5.10 fixed point representation and are stored in a .hex file.
// Each term of the exponential is computed in pipeline.
//
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////

module exp #(parameter N_STAGE = 3)(
    input CLK, RST,
    input wire signed [15:0] data,
    output wire signed [15:0] output_data,
    output reg write_enable
    );
    
  reg signed [31:0] pipeline_output[0:N_STAGE-1];
  reg signed [31:0] pipe_power_reg[0:N_STAGE-1];
  reg signed [15:0] coeff[0:N_STAGE-1];
  reg [3:0] current_stage;
  integer i;
  
  //!! Check whether coeff is initilized after synthesis
  initial begin
    $readmemh("../data_file/exp_coeff.hex",coeff);
    
    for(i=0; i<N_STAGE; i = i+1) begin
        pipe_power_reg[i] <= 32'h0;
        pipeline_output[i] <= 32'h0;
    end 
    
    current_stage <= 4'b0000;
    write_enable <= 1'b0;
  end
  
  always @(posedge CLK) begin
    if (RST) begin
        for(i=0; i<N_STAGE; i = i+1) begin
            pipe_power_reg[i] <= 32'h0;
            pipeline_output[i] <= 32'h0;
        end
        
        current_stage <= 4'b0000;
        write_enable <= 1'b0;  
    end else begin
        pipe_power_reg[0] <= data; //implements the computation of the power of the input (x^power) through stages
        pipeline_output[0] <= pipe_power_reg[0] + coeff[0];
        
        for(i=1; i<N_STAGE; i=i+1) begin
            pipe_power_reg[i] <= ((pipe_power_reg[i-1] >> 10) * data); //need to rescale otherwise it scales up at each stage
            pipeline_output[i] <= pipeline_output[i-1] + (pipe_power_reg[i] / coeff[i]);
        end
        
        if(current_stage==N_STAGE-1) begin
            write_enable <= 1;
        end
        
        current_stage <= current_stage + 1;
    end
  end

  assign output_data = pipeline_output[N_STAGE-1];
endmodule