`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2024 10:06:57 AM
// Design Name: 
// Module Name: tb_homomorphic
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


module tb_homomorphic(
    );
    
    parameter T_HOLD = 10;
    
    reg CLK, RST;
    
    reg signed [31:0] s_tdata=0;
    
    wire signed [31:0] m_tdata0, m_tdata1, m_tdata2;
    wire signed [31:0] output_data;
    wire validity;
    reg signed [31:0] abs_value;
    reg s_tvalid=0;
    
    wire m_tvalid0, m_tvalid1, m_tvalid2;
    wire m_tready0, m_tready1, m_tready2;
    
    integer fd;
    integer idx=0;
    
    //Clock generation
    initial begin
        CLK = 0;        
        forever #5 CLK = ~CLK;
    end
    
    always @* begin
        abs_value = (s_tdata < 0) ? -s_tdata : s_tdata;
    end

    log #(.N_STAGE(5)) log_0 (
        .aclk(CLK),
        .aresetn(RST),
        
        .s_axis_data_tdata(abs_value), //-1 to compute ln(x), h1000 is 1 in the current fixed-point format, adapt according to needs
        .s_axis_data_tvalid(s_tvalid),
        .s_axis_data_tready(m_tready1),
        
        .m_axis_data_tdata(m_tdata0),
        .m_axis_data_tvalid(m_tvalid0),
        .m_axis_data_tready(m_tready0)
    );
    
    butterworth_LP butter_0 (
        .aclk(CLK),
        .aresetn(RST),
        
        .s_axis_data_tdata(m_tdata0),
        .s_axis_data_tvalid(m_tvalid0),
        .s_axis_data_tready(m_tready0),
        
        .m_axis_data_tdata(m_tdata1),
        .m_axis_data_tvalid(m_tvalid1),
        .m_axis_data_tready(m_tready1)
    );
    
    exp #(.N_STAGE(3)) exp_0 (
        .aclk(CLK),
        .aresetn(RST),
        
        .s_axis_data_tdata(m_tdata1),
        .s_axis_data_tvalid(m_tvalid1),
        .s_axis_data_tready(m_tready1),
                
        .m_axis_data_tdata(m_tdata2),
        .m_axis_data_tvalid(m_tvalid2),
        .m_axis_data_tready(1'b1)
    );
    
    poly_decimator_0 homo_downsampling_0(
        .aresetn(~RST),
        .aclk(CLK),
        
        .s_axis_data_tdata(m_tdata2-32'h4000000),
        .s_axis_data_tready(m_tready2),
        .s_axis_data_tvalid(m_tvalid2),
        
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
            
            s_tvalid <= 1'b1;

            #T_HOLD;
            
            idx = idx + 1;
        end
        repeat(100)@(posedge CLK);
        $fclose(fd);
        
        $display("SIMUlATION DONE");
        $finish;
    end
endmodule
