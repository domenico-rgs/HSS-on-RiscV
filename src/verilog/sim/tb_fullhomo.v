`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/12/2024 09:18:15 AM
// Design Name: 
// Module Name: tb_fullhomo
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


module tb_fullhomo(
    );
    
    reg CLK, RST;
    reg [31:0] data_in=32'd2048;
    wire [31:0] out;
    wire write_enable;
    
    //Clock generation
    initial begin
        CLK = 0;        
        forever #5 CLK = ~CLK;
    end
    
    //Homomorphic module to be tested
     homomorphic homo (
        .RST(RST),
        .CLK(CLK),
        .input_data(data_in),
        .output_data(out),
        .write_enable(write_enable)
    );

    // Reset and pipeline test
    initial begin
        RST = 0;
        //#10 data_in = 32'd2050;
        //#10 data_in = 32'h200;
        //#10 data_in= 32'h4a0;
        //#15 RST = 1;
        //#15 RST = 0;
        //#30 data_in = 0;
        //#10 data_in = 16'h200;
        //#10 data_in = 0;
        //#10 data_in = 16'h4a0;
        //#10 data_in = 16'h6b0;
        //#10 data_in = 16'h8c0;
        //#35 RST = 1;
                
        $monitor("Time=%0t, Data=%h", $time, out);
        #100 $finish;
    end
endmodule
