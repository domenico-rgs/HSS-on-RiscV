`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2023 06:28:27 PM
// Design Name: 
// Module Name: tb_butter
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

module tb_butter(
    );
    
    reg CLK, RST;
    reg signed [31:0] data_in=32'd0; //data in input
    wire [15:0] out;
    
    //Clock generation
    initial begin
        CLK = 0;        
        forever #5 CLK = ~CLK;
    end
    
    //Butterworth module to be tested
    butterworth_LP uut (
        .CLK(CLK),
        .RST(RST),
        .data(data_in),
        .output_data(out)
    );

    // Reset and pipeline test
    initial begin
        RST = 0;
        #10 data_in = $signed(16'h968);
        #10 data_in = 16'hf38;
        #10 data_in = 16'd3896;
        #10 data_in = 16'd2408;
        //#15 RST = 1;
        //#15 RST = 0;
        //#15 data_in = 0;
        //#5 data_in = 16'h200;
        //#5 data_in = 16'h400;
        //#5 data_in = 16'h600;
        //#5 data_in = 16'h800;
        //#35 RST = 1;
                
        $monitor("Time=%0t, Data=%h", $time, out);

        #100 $finish;
    end
endmodule
