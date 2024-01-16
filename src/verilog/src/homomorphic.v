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
    input CLK, RST,
    input wire signed [31:0] input_data,
    output wire [31:0] output_data,
    output write_enable
    );
    
    localparam N_STAGES = 2;
    
    reg signed [31:0] abs_value;    
    wire [31:0] butter_wire_out, butter_wire_in;
    
    always @* begin
        abs_value = (input_data < 0) ? -input_data : input_data;
    end
        
    log #(.N_STAGE(N_STAGES)) Tlog (
        .RST(RST),
        .CLK(CLK),
        .data(abs_value-`H_ONE), //-1 to compute ln(x), h1000 is 1 in the current fixed-point format, adapt according to needs
        .output_data(butter_wire_in)
    );
    
    butterworth_LP butter (
        .CLK(CLK),
        .RST(RST),
        .data(butter_wire_in),
        .output_data(butter_wire_out)
    );
    
    exp #(.N_STAGE(N_STAGES)) Texp (
        .RST(RST),
        .CLK(CLK),
        .data(butter_wire_out),
        .output_data(output_data),
        .write_enable(write_enable)
    );
    
endmodule