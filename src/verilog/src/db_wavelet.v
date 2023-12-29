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
//
// Revision:
// Revision 0.01 - File Created
//
// Addition Notes: 
// Try to optimize with: https://en.wikipedia.org/wiki/Lifting_scheme
//////////////////////////////////////////////////////////////////////////////////

module db_wavelet #(parameter N_LEVEL = 3)(
    input CLK, RST,
    input wire signed [31:0] input_data,
    output reg signed [31:0] output_abs_data,
    output write_enable
    );
    
    wire signed [31:0] w_level [0:N_LEVEL-1];
    wire parity [0:N_LEVEL-2];
    
    generate genvar i;
        convolution2 #(.MODE(0)) wL0 (
            .CLK(CLK),
            .RST(RST),
            .in_parity(1'b1),
            .input_data(input_data),
            .output_data(w_level[0]),
            .parity(parity[0])
        );
        
        for(i=1; i<N_LEVEL-1; i=i+1) begin : conv_block
            convolution2 #(.MODE(0)) wL(
                .CLK(CLK),
                .RST(RST),
                .in_parity(parity[i-1]),
                .input_data(w_level[i-1]),
                .output_data(w_level[i]),
                .parity(parity[i])
            );
        end
        
        convolution2 #(.MODE(1)) wLlast (
            .CLK(CLK),
            .RST(RST),
            .input_data(w_level[N_LEVEL-2]),
            .in_parity(parity[N_LEVEL-2]),
            .output_data(w_level[N_LEVEL-1]),
            .parity(write_enable)
        );
    endgenerate
    
    always @ (w_level[N_LEVEL-1]) begin
        if (w_level[N_LEVEL-1] < 0) begin
            output_abs_data <= -w_level[N_LEVEL-1];
        end else begin
            output_abs_data <= w_level[N_LEVEL-1];
        end
    end
endmodule