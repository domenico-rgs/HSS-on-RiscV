`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2024 09:55:13 AM
// Design Name: 
// Module Name: tb_hilbert
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

module tb_hilbert(
);
    
    parameter T_HOLD = 10;
    
    reg CLK, RST;
    reg signed [31:0] s_tdata=0;
    wire signed [31:0] m_tdata;
    wire signed [31:0] output_data;
    reg signed [31:0] abs_value;
    wire validity;
    wire s_tready, s_tready_1;
    reg s_tvalid=0;
    wire m_tvalid;
    integer fd;
    integer idx=0;

    wire [31:0] real_part;
    
    //Clock generation
    initial begin
        CLK = 0;        
        forever #5 CLK = ~CLK;
    end
    
    hilber_fir_0 hilb_transform_0 (
        .aresetn(~RST),
        .aclk(CLK),
        
        .s_axis_data_tdata(s_tdata),
        .s_axis_data_tready(s_tready),
        .s_axis_data_tvalid(s_tvalid),
        
        .m_axis_data_tdata({m_tdata,real_part}),
        .m_axis_data_tvalid(m_tvalid),
        .m_axis_data_tready(s_tready_1)
    );
    
    always @* begin
        abs_value = (m_tdata < 0) ? -m_tdata : m_tdata;
    end
    
    fir_compiler_0 hilb_downsampling_0(
        .aresetn(~RST),
        .aclk(CLK),
        
        .s_axis_data_tdata(abs_value),
        .s_axis_data_tready(s_tready_1),
        .s_axis_data_tvalid(m_tvalid),
        
        .m_axis_data_tdata(output_data),
        .m_axis_data_tvalid(validity)
    );
            

    initial begin
        $display("START SIMULATION");
        
        RST = 0;
        
        fd = $fopen("output.txt", "r");
        
        @(posedge CLK);
        while(idx < 5120) begin
            $fscanf(fd, "%x", s_tdata);
            
            s_tvalid <= 1;

            #T_HOLD;
            
            idx = idx + 1;
        end
        repeat(100)@(posedge CLK);
        $fclose(fd);
        
        $display("SIMUlATION DONE");
        $finish;
    end
endmodule
