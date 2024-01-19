`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: MCLab (UniPV)
// Engineer: D. Ragusa
// 
// Create Date: 11/28/2023 09:55:54 PM
// Module Name: homomorphic
// Project Name: HSS on AIRISC
// Target Devices: Nexys4 DDR, NexysVideo
// Tool Versions: Vivado 2023.2
//
// Description: 
// Implementation of the digital circuit for extracting the homomorphic envelogram from a phonocardiogram as explained here: https://iopscience.iop.org/article/10.1088/0967-3334/31/4/004
// TESTED WITH Q3.12 FIXED POINT REPRESENTATION FOR BOTH COEFFICIENTS AND SAMPLES
// The coefficients are the same as the output from matlab, the implementation follow the direct form II
//
// Revision:
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////

`include "system_defines.vh"

module homomorphic(
    input aclk, aresetn,
    input wire signed [31:0] s_axis_data_tdata,
    output wire s_axis_data_tready,
    input wire s_axis_data_tvalid,
    output wire [31:0] m_axis_data_tdata,
    output wire m_axis_data_tvalid
);
    
    localparam N_STAGES = 2;
    
    reg signed [31:0] abs_value;
        
    wire signed [31:0] w_tdata[0:3];
    wire w_validity[0:3];
    wire w_ready[0:3];
    
    wire [0:7] config_tdata;
    wire config_ready, config_valid;
        
    always @* begin
        abs_value = (s_axis_data_tdata < 0) ? -s_axis_data_tdata : s_axis_data_tdata;
    end
        
    log #(.N_STAGE(N_STAGES)) log_0 (
        .aclk(aclk),
        .aresetn(aresetn),
        
        .s_axis_data_tdata(abs_value-`H_ONE), //-1 to compute ln(x), h1000 is 1 in the current fixed-point format, adapt according to needs
        .s_axis_data_tvalid(s_axis_data_tvalid),
        .s_axis_data_tready(s_axis_data_tready),
        
        .m_axis_data_tdata(w_tdata[0]),
        .m_axis_data_tvalid(w_validity[0]),
        .m_axis_data_tready(w_ready[0])
    );
    
    butterworth_LP butter_0 (
        .aclk(aclk),
        .aresetn(aresetn),
        
        .s_axis_data_tdata(w_tdata[0]),
        .s_axis_data_tvalid(w_validity[0]),
        .s_axis_data_tready(w_ready[0]),
        
        .m_axis_data_tdata(w_tdata[1]),
        .m_axis_data_tvalid(w_validity[1]),
        .m_axis_data_tready(w_ready[1])
    );
    
    exp #(.N_STAGE(N_STAGES)) exp_0 (
        .aclk(aclk),
        .aresetn(aresetn),
        
        .s_axis_data_tdata(w_tdata[1]),
        .s_axis_data_tvalid(w_validity[1]),
        .s_axis_data_tready(w_ready[1]),
                
        .m_axis_data_tdata(w_tdata[2]),
        .m_axis_data_tvalid(w_validity[2]),
        .m_axis_data_tready(w_ready[2])
    );
    
    incrementalNormalization #(.SQRT_STAGES(3), .WIDTH (16), .FXP_BITS(12), .HALF_VALUE(31'h800), .ONE_VALUE(31'h1000)) homoNorm_0(
        .aclk(aclk),
        .aresetn(aresetn),
        
        .s_axis_data_tdata(w_tdata[2]),
        .s_axis_data_tvalid(w_validity[2]),
        .s_axis_data_tready(w_ready[2]),
                
        .m_axis_data_tdata(w_tdata[3]),
        .m_axis_data_tready(w_ready[3]),
        .m_axis_data_tvalid(w_validity[3]),
        
        .m_axis_config_tdata(config_tdata),
        .m_axis_config_tready(config_ready),
        .m_axis_config_tvalid(config_valid)
    );
    
    poly_decimator_0 homo_downsampling_0(
        .aresetn(aresetn),
        .aclk(aclk),
        
        .s_axis_data_tdata(w_tdata[3]),
        .s_axis_data_tready(w_ready[3]),
        .s_axis_data_tvalid(w_validity[3]),
        
        
        .s_axis_config_tdata(config_tdata),
        .s_axis_config_tready(config_ready),
        .s_axis_config_tvalid(config_valid),
        
        .m_axis_data_tdata(m_axis_data_tdata),
        .m_axis_data_tvalid(m_axis_data_tvalid)
    );  
endmodule