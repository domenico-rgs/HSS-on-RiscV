`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: MCLab (UniPV)
// Engineer: D. Ragusa
// 
// Create Date: 01/23/2024 04:56:55 PM
// Module Name: spikerem
// Project Name: HSS on AIRISC
// Target Devices: Nexys4 DDR NexysVideo
// Tool Versions: Vivado 2023.2
// Description: 
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////

module spikerem(
    input aclk, aresetn,
    
    input wire signed [31:0] s_axis_data_tdata,
    output wire s_axis_data_tready,
    input wire s_axis_data_tvalid,
    
    output wire [31:0] m_axis_data_tdata,
    input m_axis_data_tready,
    output m_axis_data_tvalid,
    
    output [7:0] m_axis_config_tdata,
    input m_axis_config_tready,
    output m_axis_config_tvalid
    );

  localparam N = 5; // Number of samples to consider for averaging

  reg signed [31:0] buffer [0:N-1];
  reg signed [64:0] sum;
  reg signed [31:0] output_data;
  reg tready_internal;
  reg validity;
  reg [4:0] filter_counter;
  reg [2:0] count;
  integer i;
  
always @(posedge aclk) begin
    if (aresetn) begin
        count <= 0;
        sum <= 0;
        
        for(i=0; i<N; i=i+1) begin
            buffer[i] <= 0;
        end 
      
        tready_internal <= 1'b1;
    end else if (m_axis_data_tready && m_axis_config_tready) begin
        if(s_axis_data_tvalid) begin
            validity <= 1'b1;
            
            for (i = 1; i < N; i = i + 1) begin
                buffer[i] <= buffer[i-1];
            end
            buffer[0] <= s_axis_data_tdata;
            
            if (count < N) begin
                sum <= sum + s_axis_data_tdata - buffer[count];
                count <= count + 1;
            end
            
            if (count == N) begin
                output_data <= sum / N;
            end else begin
                output_data <= s_axis_data_tdata;
            end
        
            tready_internal <= 1'b1;
            filter_counter <= filter_counter + validity;
        end else begin
            validity = 1'b0;
        end
    end else begin
        tready_internal <= 1'b0;
    end
end
  
  assign m_axis_data_tdata = output_data;
  assign m_axis_data_tvalid = validity;
  assign s_axis_data_tready = tready_internal;
  
  assign m_axis_config_tvalid = validity;
  assign m_axis_config_tdata = {3'b0,filter_counter};
endmodule