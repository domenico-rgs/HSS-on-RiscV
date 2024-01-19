`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: MCLab (UniPV)
// Engineer: D. Ragusa
// 
// Create Date: 12/19/2023 12:40:29 PM
// Module Name: db_wavelet
// Project Name: HSS on AIRISC
// Target Devices: Nexys4 DDR, NexysVideo
// Tool Versions: Vivado 2023.2
//
// Description: 
// Implementation of a DB10 with a decomposition level 3 (can be adapted through the N_LEVEL parameter). 
// At the end, the absolute value is computed to extract the envelogram.
// TESTED WITH Q2.29 FIXED POINT REPRESENTATION FOR BOTH COEFFICIENTS AND SAMPLES
// Validated using Matlab dwt with dwtmode('zpd')
//
// Revision:
// Revision 0.01 - File Created
//
// Addition Notes: 
// Try to optimize with: https://en.wikipedia.org/wiki/Lifting_scheme
//////////////////////////////////////////////////////////////////////////////////

module db_wavelet #(parameter N_LEVEL = 3)(
    input aclk, aresetn,
    input wire signed [31:0] s_axis_data_tdata,
    output wire s_axis_data_tready,
    input wire s_axis_data_tvalid,
    output wire [31:0] m_axis_data_tdata,
    output m_axis_data_tvalid
);
    
    reg signed [31:0] abs_data;
    
    wire signed [31:0] w_tdata[0:N_LEVEL];
    wire w_validity[0:1];
    wire w_ready[0:1];
    
    wire [0:7] config_tdata;
    wire config_ready, config_valid;
    
    generate genvar i;
        convolution #(.MODE(0)) w_conv_0 (
            .aclk(aclk),
            .aresetn(aresetn),
            
            .s_axis_data_tdata(s_axis_data_tdata),            
            .s_axis_data_tvalid(s_axis_data_tvalid),
            .s_axis_data_tready(s_axis_data_tready),
            
            .m_axis_data_tdata(w_tdata[0]),
            .m_axis_data_tvalid(w_validity[0]),
            .m_axis_data_tready(w_ready[0])
        );
        
        for(i=1; i<N_LEVEL-1; i=i+1) begin : conv_block
            convolution #(.MODE(0)) w_conv(
                .aclk(aclk),
                .aresetn(aresetn),
                
                .s_axis_data_tdata(w_tdata[i-1]),
                .s_axis_data_tvalid(w_validity[i-1]),
                .s_axis_data_tready(w_ready[0]),
                
                .m_axis_data_tdata(w_tdata[i]),
                .m_axis_data_tvalid(w_validity[i]),
                .m_axis_data_tready(w_ready[1])
            );
        end
        
        convolution #(.MODE(1)) w_conv_last (
            .aclk(aclk),
            .aresetn(aresetn),
            
            .s_axis_data_tdata(w_tdata[N_LEVEL-2]),
            .s_axis_data_tvalid(w_validity[N_LEVEL-2]),
            .s_axis_data_tready(w_ready[1]),
            
            .m_axis_data_tdata(w_tdata[N_LEVEL-1]),
            .m_axis_data_tvalid(w_validity[N_LEVEL-1]),
            .m_axis_data_tready(w_ready[2])
        );
    
        always @* begin
            abs_data = (w_tdata[N_LEVEL-1] < 0) ? -w_tdata[N_LEVEL-1] : w_tdata[N_LEVEL-1];
        end
            
        incrementalNormalization #(.SQRT_STAGES(3), .WIDTH (32), .FXP_BITS(29), .HALF_VALUE(31'h10000000), .ONE_VALUE(31'h20000000)) waveNorm(
            .aclk(aclk),
            .aresetn(aresetn),
            
            .s_axis_data_tdata(abs_data),
            .s_axis_data_tvalid(w_validity[N_LEVEL-1]),
            .s_axis_data_tready(w_ready[2]),
            
            .m_axis_data_tdata(w_tdata[N_LEVEL]),
            .m_axis_data_tready(w_ready[3]),
            .m_axis_data_tvalid(w_validity[N_LEVEL]),
            
            .m_axis_config_tdata(config_tdata),
            .m_axis_config_tready(config_ready),
            .m_axis_config_tvalid(config_valid)
        );
        
        poly_decimator_0 wave_downsampling(
            .aresetn(aresetn),
            .aclk(aclk),
            
            .s_axis_data_tdata(w_tdata[N_LEVEL]),
            .s_axis_data_tready(w_ready[3]),
            .s_axis_data_tvalid(w_validity[N_LEVEL]),
            
            
            .s_axis_config_tdata(config_tdata),
            .s_axis_config_tready(config_ready),
            .s_axis_config_tvalid(config_valid),
            
            .m_axis_data_tdata(m_axis_data_tdata),
            .m_axis_data_tvalid(m_axis_data_tvalid)
        );
    endgenerate
endmodule