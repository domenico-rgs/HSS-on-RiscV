`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: MCLab (UniPV)
// Engineer: D. Ragusa
// 
// Create Date: 01/17/2024 09:21:09 AM
// Module Name: incrementalNormalization
// Project Name: HSS on AIRISC
// Target Devices: Nexys4 DDR, NexysVideo
// Tool Versions: Vivado 2023.2
// Description: 
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////

module incrementalNormalization #(SQRT_STAGES = 3, WIDTH = 16, FXP_BITS = 12, HALF_VALUE = 31'h1, signed ONE_VALUE = 31'h1)(
    input aclk, aresetn,
    
    input signed [31:0] s_axis_data_tdata,
    input s_axis_data_tvalid,
    output s_axis_data_tready,
    
    output signed [31:0] m_axis_data_tdata,
    output m_axis_data_tvalid,
    input m_axis_data_tready,
    
    output [7:0] m_axis_config_tdata,
    input m_axis_config_tready,
    output m_axis_config_tvalid
);
    
    reg signed [63:0] pipe_reg_0[0:2];
    reg signed [63:0] pipe_reg_1[0:3];
    
    reg signed [63:0] pipe_sqrt_0[0:SQRT_STAGES-1];
    reg signed [63:0] pipe_sqrt_1[0:SQRT_STAGES-1];
    reg signed [63:0] pipe_sqrt_2[0:SQRT_STAGES-1];
    
    reg signed [31:0] normalized_signal;
    
    reg tready_internal;
    reg validity[0:2+SQRT_STAGES-1];
    
    reg [4:0] filter_counter;
    integer i;
    
    always @(posedge aclk) begin
        if(aresetn) begin
            for(i=0; i<3; i=i+1) begin
                pipe_reg_0[i] <= 0;
            end
            
            for(i=0; i<4; i=i+1) begin
                pipe_reg_1[i] <= 0;
            end
            
            for(i=0; i<SQRT_STAGES; i=i+1) begin
                pipe_sqrt_0[i] <= 0;
                pipe_sqrt_1[i] <= 0;
                pipe_sqrt_2[i] <= 0;
            end

            normalized_signal <= 0;
        end else if (m_axis_data_tready && m_axis_config_tready) begin
            if (s_axis_data_tvalid) begin
                //Stage 0 - incremental mean
                validity[0] <= 1'b1;
                pipe_reg_0[0] <= s_axis_data_tdata;
                pipe_reg_0[1] <= pipe_reg_0[1] + ((s_axis_data_tdata - pipe_reg_0[1]) / (pipe_reg_0[2] + ONE_VALUE) <<< FXP_BITS);
                pipe_reg_0[2] <= pipe_reg_0[2] + ONE_VALUE; //n_samples
                
                //Stage 1 - incremental sum_square diff for std_dev
                validity[1] <= validity[0];
                pipe_reg_1[0] <= pipe_reg_0[1]; //mean
                pipe_reg_1[1] <= pipe_reg_0[0]; //data_in
                pipe_reg_1[2] <= pipe_reg_0[2]; //n_samples
                pipe_reg_1[3] <= pipe_reg_1[3] + (pipe_reg_0[0] - pipe_reg_0[1]) * (pipe_reg_0[0] - pipe_reg_0[1]); //sum_square_difference
                
                //Stage 2-N - sqrt with newton-rapson
                validity[2] <= validity[1];
                pipe_sqrt_2[0] <= (pipe_reg_1[1] - pipe_reg_1[0]);
                pipe_sqrt_1[0] <= pipe_reg_1[3]/pipe_reg_1[2];
                pipe_sqrt_0[0] <= ((HALF_VALUE * (HALF_VALUE + ((pipe_reg_1[3]/pipe_reg_1[2])/HALF_VALUE) <<< FXP_BITS)) >>> FXP_BITS); //HALF will be the initial guess
                for(i=1; i<SQRT_STAGES; i=i+1) begin
                    validity[2+i] <= validity[2+i-1];
                    pipe_sqrt_2[i] <= pipe_sqrt_2[i-1];
                    pipe_sqrt_1[i] <= pipe_sqrt_1[i-1];
                    pipe_sqrt_0[i] <= ((HALF_VALUE * ( pipe_sqrt_0[i-1] + ((pipe_sqrt_1[i-1]/pipe_sqrt_0[i-1]) <<< FXP_BITS))) >>> FXP_BITS);
                end
                
                //Stage N+1 - normalization
                validity[2+SQRT_STAGES-1] <= validity[2+SQRT_STAGES-2];
                normalized_signal <= (pipe_sqrt_2[SQRT_STAGES-1] / pipe_sqrt_0[SQRT_STAGES-1]) <<< FXP_BITS;
            
                filter_counter <= filter_counter + validity[2+SQRT_STAGES-1];
            end else begin
                validity[0] <= 1'b0;
            end

            tready_internal <= 1'b1;
        end else begin
            tready_internal <= 1'b0;
        end
    end
    
    assign s_axis_data_tready = tready_internal;
    
    assign m_axis_data_tdata = normalized_signal;
    assign m_axis_data_tvalid = validity[2+SQRT_STAGES-1];
    
    assign m_axis_config_tvalid = validity[2+SQRT_STAGES-1];
    assign m_axis_config_tdata = {3'b0,filter_counter};
endmodule