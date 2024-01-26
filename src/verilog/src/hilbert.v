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
        
   wire signed [31:0] w_tdata;
   wire w_validity;
   wire w_ready;
  
   reg signed [31:0] abs_value;
   
   hilber_fir_0 hilb_transform_0(
        .aclk(aclk),
        .aresetn(~aresetn),
        
        .s_axis_data_tdata(s_axis_data_tdata),
        .s_axis_data_tready(s_axis_data_tready),
        .s_axis_data_tvalid(s_axis_data_tvalid),
        
        .m_axis_data_tdata(w_tdata),
        .m_axis_data_tready(w_ready),
        .m_axis_data_tvalid(w_validity)
   );
   
    always @* begin
        abs_value = (w_tdata < 0) ? -w_tdata : w_tdata;
    end
    
    fir_compiler_0 hilb_downsampling_0(
        .aclk(aclk),
        .aresetn(~aresetn),
        
        .s_axis_data_tdata(abs_value),
        .s_axis_data_tready(w_ready),
        .s_axis_data_tvalid(w_validity),
        
        .m_axis_data_tdata(m_axis_data_tdata),
        .m_axis_data_tvalid(m_axis_data_tvalid)
    );
endmodule