`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2023 03:19:46 PM
// Design Name: 
// Module Name: tb_convolution
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

module tb_convolution(
    );
    
    reg CLK, RST;
    reg [15:0] data_in=16'hac30; //data in input
    wire [15:0] out;
    wire parity, write_enable;
    
    //Clock generation
    initial begin
        CLK = 0;        
        forever #5 CLK = ~CLK;
    end
    
    //Convolution module to be tested
    convolution2 #(.MODE(0), .W_WIDTH(20)) uut (
        .CLK(CLK),
        .RST(RST),
        .in_parity(1'b1),
        .input_data(data_in),
        .output_data(out),
        .out_parity(parity),
        .write_enable(write_enable)
    );

    // Reset and pipeline test
    initial begin
        RST = 0;
        //#15 RST = 1;
        //#15 RST = 0;
        #30 data_in = 0;
        #10 data_in = 16'h200;
        #10 data_in = 16'h4a0;
        #10 data_in = 16'h6b0;
        #10 data_in = 16'h8c0;
        //#35 RST = 1;
                
        $monitor("Time=%0t, Data=%h", $time, out);

        #500 $finish;
    end
endmodule