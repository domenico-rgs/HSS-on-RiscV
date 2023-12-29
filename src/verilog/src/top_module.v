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
   input vauxn,
   input vauxp
);

    wire [15:0] data;
    wire [15:0] res_homo, res_wave;
    
    wire busy_out;
    wire eoc_out;
    wire ready,we[0:1];
    
    reg [6:0] write_address_homo=0, write_address_wave=0;

    
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
    );
   
    homomorphic homo (
        .nRESET(nRESET),
        .CLK(CLK),
        .input_data(data),
        .output_data(res_homo),
        .write_enable(we[0])
    );
    
    db_wavelet #(.N_LEVEL(3)) wave (
        .RST(nRESET),
        .CLK(CLK),
        .input_data(data),
        .output_abs_data(res_wave),
        .write_enable(we[1])
    );
    
    always @(posedge we[0]) begin
        if (we[0]==1'b1) begin
            write_address_homo <= write_address_homo + 1'b1;
        end else begin
            write_address_homo <= write_address_homo;
        end
    end
        
    blk_mem_gen_0 SRAM_HOMO(
        .addra(write_address_homo),
        .clka(CLK),
        .dina(res_homo),
        .wea(we[0]),
        .douta(),
        
        .addrb(6'b0),
        .clkb(CLK),
        .doutb(),
        .web(),
        .dinb()
    );
    
    always @(posedge we[1]) begin
        if (we[1]==1'b1) begin
            write_address_wave <= write_address_wave + 1'b1;
        end else begin
            write_address_wave <= write_address_wave;
        end
    end
    
    blk_mem_gen_0 SRAM_WAVE(
        .addra(write_address_wave),
        .clka(CLK),
        .dina(res_wave),
        .wea(we[1]),
        .douta(),

        .addrb(6'b0),
        .clkb(CLK),
        .doutb(),
        .web(),
        .dinb()
    );
endmodule