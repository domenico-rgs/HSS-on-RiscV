`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: MCLab (UniPV)
// Engineer: D. Ragusa
// 
// Create Date: 10/31/2023 09:01:51 PM
// Module Name: top_module
// Project Name: HSS on AIRISC
// Target Devices: Nexys4 DDR, NexysVideo
// Tool Versions: Vivado 2023.2
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////

`include "system_defines.vh"

module TopModule(
   input CLK,
   input nRESET,
   input ac_adc_sdata
);

    wire [31:0] tdata [0:10-1];
    wire tready [0:6-1], tvalid [0:9-1];
    wire to_dec_press;
    wire buf_tready [0:3-1];
    
    wire [0:7] dec_config_tdata;
    wire dec_config_tready, dec_config_tvalid;
    
    butterworth_snd #(.COEF_FILE(`BUT_SND_HI)) butter_hp_0 (
        .aclk(CLK),
        .aresetn(nRESET),
        
        .s_axis_data_tdata(ac_adc_sdata),
        .s_axis_data_tvalid(),
        .s_axis_data_tready(),
        
        .m_axis_data_tdata(tdata[0]),
        .m_axis_data_tvalid(tvalid[0]),
        .m_axis_data_tready(tready[0])
    );
    
    butterworth_snd #(.COEF_FILE(`BUT_SND_LO)) butter_lp_0 (
        .aclk(CLK),
        .aresetn(nRESET),
        
        .s_axis_data_tdata(tdata[0]),
        .s_axis_data_tvalid(tvalid[0]),
        .s_axis_data_tready(tready[0]),
        
        .m_axis_data_tdata(tdata[1]),
        .m_axis_data_tvalid(tvalid[1]),
        .m_axis_data_tready(tready[1])
    );
    
    spikerem spikeRemoval_0 (
        .aresetn(nRESET),
        .aclk(CLK),
        
        .s_axis_data_tdata(tdata[1]),
        .s_axis_data_tvalid(tvalid[1]),
        .s_axis_data_tready(tready[1]),
        
        .m_axis_config_tdata(dec_config_tdata),
        .m_axis_config_tready(dec_config_tready),
        .m_axis_config_tvalid(dec_config_tvalid),
        
        .m_axis_data_tdata(tdata[2]),
        .m_axis_data_tvalid(tvalid[2]) ,
        .m_axis_data_tready(tready[2])   
    );
    
    poly_decimator_1 downsampling_0(
        .aresetn(nRESET),
        .aclk(CLK),
        
        .s_axis_data_tdata(tdata[2]),
        .s_axis_data_tvalid(tvalid[2]),
        .s_axis_data_tready(tready[2]),

        .s_axis_config_tdata(dec_config_tdata),
        .s_axis_config_tready(dec_config_tready),
        .s_axis_config_tvalid(dec_config_tvalid),
        
        .m_axis_data_tdata(tdata[3]),
        .m_axis_data_tready(to_dec_press), //check what happens if a buffer stops this filter
        .m_axis_data_tvalid(dec_tvalid)
    );
    
    assign to_dec_press = buf_tready[0] || buf_tready[1] || buf_tready[2];
    
    axis_data_fifo_0 hilb_buff_0(
        .s_axis_aresetn(nRESET),
        .s_axis_aclk(CLK),
        
        .s_axis_tdata(tdata[3]),
        .s_axis_tvalid(dec_tvalid),
        .s_axis_tready(buf_tready[0]),
        
        .m_axis_tdata(tdata[4]),
        .m_axis_tready(tready[3]),
        .m_axis_tvalid(tvalid[3])
    );

    hilbert hilb (
        .aresetn(nRESET),
        .aclk(CLK),
        
        .s_axis_data_tdata(tdata[4]),
        .s_axis_data_tready(tready[3]),
        .s_axis_data_tvalid(tvalid[3]),
        
        .m_axis_data_tdata(tdata[7]),
        .m_axis_data_tvalid(tvalid[6])
    );
    
    axis_data_fifo_0 homo_buff_0(
        .s_axis_aresetn(nRESET),
        .s_axis_aclk(CLK),
        
        .s_axis_tdata(tdata[3]),
        .s_axis_tvalid(dec_tvalid),
        .s_axis_tready(buf_tready[1]),
        
        .m_axis_tdata(tdata[5]),
        .m_axis_tready(tready[4]),
        .m_axis_tvalid(tvalid[4])
    );   

    homomorphic homo (
        .aresetn(nRESET),
        .aclk(CLK),

        .s_axis_data_tdata(tdata[5]),
        .s_axis_data_tready(tready[4]),
        .s_axis_data_tvalid(tvalid[4]),
        
        .m_axis_data_tdata(tdata[8]),
        .m_axis_data_tvalid(tvalid[7])
    );
    
    axis_data_fifo_0 wave_buff_0(
        .s_axis_aresetn(nRESET),
        .s_axis_aclk(CLK),
        
        .s_axis_tdata(tdata[3]),
        .s_axis_tvalid(dec_tvalid),
        .s_axis_tready(buf_tready[2]),
        
        .m_axis_tdata(tdata[6]),
        .m_axis_tready(tready[5]),
        .m_axis_tvalid(tvalid[5])
    );
    
    db_wavelet #(.N_LEVEL(3)) wave (
        .aresetn(nRESET),
        .aclk(CLK),
        
        .s_axis_data_tdata(tdata[6]),
        .s_axis_data_tready(tready[5]),
        .s_axis_data_tvalid(tvalid[5]),
        
        .m_axis_data_tdata(tdata[9]),
        .m_axis_data_tvalid(tvalid[8])
    );
endmodule