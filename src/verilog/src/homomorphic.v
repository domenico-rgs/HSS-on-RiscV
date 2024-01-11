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
//
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////

`include "homo_config.vh"

module homomorphic(
    input CLK, nRESET,
    input wire signed [15:0] input_data,
    output wire [15:0] output_data,
    output write_enable
    );
    
    reg [15:0] abs_value;    
    wire [15:0] butter_wire_out, butter_wire_in;
    
    always @ (input_data) begin
        if (input_data < 0) begin
            abs_value = -input_data;
        end else begin
            abs_value = input_data;
        end
    end
        
    log #(.N_STAGE(`LOG_N_STAGES)) Tlog (
        .RST(nRESET),
        .CLK(CLK),
        .data(abs_value-`ONE), //-1 to compute ln(x), h1000 is 1 in the current fixed-point format, adapt according to needs
        .output_data(butter_wire_in)
    );
    
    butterworth_LP butter (
        .CLK(CLK),
        .RST(nRESET),
        .data(butter_wire_in),
        .out(butter_wire_out)
    );
    
    exp #(.N_STAGE(`EXP_N_STAGES)) Texp (
        .RST(nRESET),
        .CLK(CLK),
        .data(butter_wire_out),
        .output_data(output_data),
        .write_enable(write_enable)
    );
    
endmodule