`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2023 12:07:16 PM
// Design Name: 
// Module Name: tb_exp
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_exp(
    );
    
    reg CLK, RST;
    reg [15:0] data_in = 16'h200;
    wire write_enable;
    wire [15:0] out;
    
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end
    
    exp #(.N_STAGE(3)) uut (
        .CLK(CLK),
        .RST(RST),
        .data(data_in),
        .output_data(out),
        .write_enable(write_enable)
    );

    // Reset and pipeline test
    initial begin
        RST = 0;
        #15 RST = 1;
        #15 RST = 0;
        #15 data_in = 0;
        #5 data_in = 16'h200;
        #5 data_in = 16'h400;
        #5 data_in = 16'h600;
        #5 data_in = 16'h800;
        #35 RST = 1;
        #10 RST = 0;
        
        $monitor("Time=%0t, Data=%h, WE=%h", $time, out, write_enable);

        #50 $finish;
    end
endmodule