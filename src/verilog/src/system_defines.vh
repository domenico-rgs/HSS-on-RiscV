// File             : system_defines.vh
// Author           : D. Ragusa
// Creation Date    : 16.01.24
// Last Modified    : 16.01.24
// Version          : 1.0
// Abstract         : Constants and parameters for the general system

//FILE WITH COEFFICIENTS
`define LO_COEFF_FILE "mem_files/lo_d_coeff.mem"
`define HI_COEFF_FILE "mem_files/hi_d_coeff.mem"
`define BUTTER_COEFF_FILE "mem_files/butter_coeff.mem"
`define EXP_COEFF_FILE "mem_files/exp_coeff.mem"
`define LOG_COEFF_FILE "mem_files/log_coeff.mem"

//FXP DEFINITIONS
`define WAVE_FXP_DECIMAL_BITS 29
`define H_FXP_DECIMAL_BITS 12

`define H_ONE 16'h1000 //1 according to the fxp representation in use


