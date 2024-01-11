`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2023 11:05:11 AM
// Design Name: 
// Module Name: tb_log
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
// Tested using 16bit fixed point representation ad 12 bit for the decimal part, 1 for the sign and 3 for the integer part
//////////////////////////////////////////////////////////////////////////////////

module tb_log(
    );
    
    reg CLK, RST;
    reg [15:0] data_in=16'd4096; //data in input, (data-1) per ln(data) -> in this case the input is 2 (1+1)
    wire [15:0] out;
    
    //Clock generation
    initial begin
        CLK = 0;        
        forever #5 CLK = ~CLK;
    end
    
    //Log module to be tested
    log #(.N_STAGE(2)) uut (
        .CLK(CLK),
        .RST(RST),
        .data(data_in),
        .output_data(out)
    );

    // Reset and pipeline test
    initial begin
        RST = 0;
        //#15 RST = 1;
        //#15 RST = 0;
        //#15 data_in = 0;
        //#5 data_in = 16'h200;
        //#5 data_in = 16'h400;
        //#5 data_in = 16'h600;
        //#5 data_in = 16'h800;
        //#35 RST = 1;
                
        $monitor("Time=%0t, Data=%h", $time, out);

        #50 $finish;
    end
endmodule