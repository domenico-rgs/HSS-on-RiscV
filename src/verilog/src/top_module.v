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

module TopModule(
   input CLK,
   input nRESET,
   input uart_tx_in,
   output uart_rx_out
);

    wire [31:0] xadc_tdata;
    wire [31:0] hilb_s_tdata, homo_s_tdata, wave_s_tdata;
    wire [31:0] hilb_m_tdata, homo_m_tdata, wave_m_tdata;
    
    wire hilb_m_tvalid, homo_m_tvalid, wave_m_tvalid;
    wire w_b_tready[0:2], w_b_tvalid[0:2];
    
    /* wire busy_out;
    wire eoc_out;
    wire ready,we[0:1];
    
     xadc_wiz_0 ADC (
        .daddr_in(16'h10),
        .dclk_in(CLK), 
        .den_in(eoc_out), 
        .di_in(0), 
        .dwe_in(0), 
        .busy_out(busy_out),                    
        .vauxp0(vauxp),
        .vauxn0(vauxn),
        .vn_in(1'b0), 
        .vp_in(1'b0), 
        .alarm_out(), 
        .do_out(data), 
        .reset_in(nRESET),
        .eoc_out(eoc_out),
        .channel_out(),
        .eos_out(),
        .drdy_out(ready)
    ); */
    
    /*axi_uartlite_0 uart(
        .s_axi_aclk(CLK),
        .s_axi_aresetn(nRESET),
        
        .rx(uart_tx_in),
        .tx(uart_rx_out)
    );*/
    
    axis_data_fifo_0 hilb_buff_0(
        .s_axis_aresetn(nRESET),
        .s_axis_aclk(CLK),
        
        .s_axis_tdata(xadc_tdata),
        .s_axis_tready(),
        .s_axis_tvalid(),
        
        .m_axis_tdata(hilb_s_tdata),
        .m_axis_tready(w_b_tready[0]),
        .m_axis_tvalid(w_b_tvalid[0])
    );

    hilbert hilb (
        .aresetn(nRESET),
        .aclk(CLK),
        
        .s_axis_data_tdata(hilb_s_tdata),
        .s_axis_data_tready(w_b_tready[0]),
        .s_axis_data_tvalid(w_b_tvalid[0]),
        
        .m_axis_data_tdata(hilb_m_tdata),
        .m_axis_data_tvalid(hilb_m_tvalid)
    );
    
    axis_data_fifo_0 homo_buff_0(
        .s_axis_aresetn(nRESET),
        .s_axis_aclk(CLK),
        
        .s_axis_tdata(xadc_tdata),
        .s_axis_tready(),
        .s_axis_tvalid(),
        
        .m_axis_tdata(homo_s_tdata),
        .m_axis_tready(w_b_tready[1]),
        .m_axis_tvalid(w_b_tvalid[1])
    );   

    homomorphic homo (
        .aresetn(nRESET),
        .aclk(CLK),

        .s_axis_data_tdata(homo_s_tdata),
        .s_axis_data_tready(w_b_tready[1]),
        .s_axis_data_tvalid(w_b_tvalid[1]),
        
        .m_axis_data_tdata(homo_m_tdata),
        .m_axis_data_tvalid(homo_m_tvalid)
    );
    
    axis_data_fifo_0 wave_buff_0(
        .s_axis_aresetn(nRESET),
        .s_axis_aclk(CLK),
        
        .s_axis_tdata(xadc_tdata),
        .s_axis_tready(),
        .s_axis_tvalid(),
        
        .m_axis_tdata(wave_s_tdata),
        .m_axis_tready(w_b_tready[2]),
        .m_axis_tvalid(w_b_tvalid[2])
    );
    
    db_wavelet #(.N_LEVEL(3)) wave (
        .aresetn(nRESET),
        .aclk(CLK),
        
        .s_axis_data_tdata(wave_s_tdata),
        .s_axis_data_tready(w_b_tready[2]),
        .s_axis_data_tvalid(w_b_tvalid[2]),
        
        .m_axis_data_tdata(wave_m_tdata),
        .m_axis_data_tvalid(wave_m_tvalid)
    );
    
    /*memory_controller mem_ctrl (
        
    );
    
    blk_mem_gen_0 SRAM_HILB(
        .addra(1'b0),
        .clka(CLK),
        .dina(res_hilb),
        .wea(1'b1),
        .douta(),
        
        .addrb(6'b0),
        .clkb(CLK),
        .doutb(),
        .web(),
        .dinb()
    );
        
    blk_mem_gen_0 SRAM_HOMO(
        .addra(write_address_homo),
        .clka(CLK),
        .dina(res_homo),
        .wea(1'b1),
        .douta(),
        
        .addrb(6'b0),
        .clkb(CLK),
        .doutb(),
        .web(),
        .dinb()
    );
    
    blk_mem_gen_0 SRAM_WAVE(
        .addra(write_address_wave),
        .clka(CLK),
        .dina(res_wave),
        .wea(1'b1),
        .douta(),

        .addrb(6'b0),
        .clkb(CLK),
        .doutb(),
        .web(),
        .dinb()
    );*/
endmodule