`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: MCLab (UniPV)
// Engineer: D. Ragusa
// 
// Create Date: 01/17/2024 12:48:47 PM
// Module Name: hilbert
// Project Name: HSS on AIRISC
// Target Devices: Nexys4 DDR, NexysVideo
// Tool Versions: Vivado 2023.2
//
// Description: 
// 
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////

module hilbert(
    input aclk, aresetn,
    input wire signed [31:0] s_axis_data_tdata,
    output wire s_axis_data_tready,
    input wire s_axis_data_tvalid,
    output wire [31:0] m_axis_data_tdata,
    output m_axis_data_tvalid
);
        
   wire signed [31:0] w_tdata[0:1];
   wire w_validity[0:1];
   wire w_ready[0:1];

   wire [0:7] config_tdata;
   wire config_ready, config_valid;
  
   reg signed [31:0] abs_value;
   
   hilber_fir_0 hilb_transform_0(
        .aclk(aclk),
        .aresetn(aresetn),
        
        .s_axis_data_tdata(s_axis_data_tdata),
        .s_axis_data_tready(s_axis_data_tready),
        .s_axis_data_tvalid(s_axis_data_tvalid),
        
        .m_axis_data_tdata(w_tdata[0]),
        .m_axis_data_tready(w_ready[0]),
        .m_axis_data_tvalid(w_validity[0])
   );
   
    always @* begin
        abs_value = (w_tdata[0] < 0) ? -w_tdata[0] : w_tdata[0];
    end
    
   incrementalNormalization #(.SQRT_STAGES(3), .WIDTH (16), .FXP_BITS(12), .HALF_VALUE(31'h800), .ONE_VALUE(31'h1000)) hilbNorm_0(
        .aclk(aclk),
        .aresetn(aresetn),
        
        .s_axis_data_tdata(abs_value),
        .s_axis_data_tready(w_ready[0]),
        .s_axis_data_tvalid(w_validity[0]),
        
        .m_axis_data_tdata(w_tdata[1]),
        .m_axis_data_tready(w_ready[1]),
        .m_axis_data_tvalid(w_validity[1]),
        
        .m_axis_config_tdata(config_tdata),
        .m_axis_config_tready(config_ready),
        .m_axis_config_tvalid(config_valid)
    );
    
    poly_decimator_0 hilb_downsampling_0(
        .aresetn(aresetn),
        .aclk(aclk),
        
        .s_axis_data_tdata(w_tdata[1]),
        .s_axis_data_tready(w_ready[1]),
        .s_axis_data_tvalid(w_validity[1]),
        
        
        .s_axis_config_tdata(config_tdata),
        .s_axis_config_tready(config_ready),
        .s_axis_config_tvalid(config_valid),
        
        .m_axis_data_tdata(m_axis_data_tdata),
        .m_axis_data_tvalid(m_axis_data_tvalid)
    );
endmodule