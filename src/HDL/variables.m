% -------------------------------------------------------------------------
% Script Title: HSS_Preprocessing_vars
% Author: Domenico Ragusa (University of Pavia) - Antonio Josè
% Rodriguez-Almeida (Universidad de Las Palmas de Gran Canaria)
% Creation Date: 16/04/2024
% Description: Container for variables used in the HSS_prefiltering_model
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program. If not, see <http://www.gnu.org/licenses/>.
% -------------------------------------------------------------------------

%% General vars
fs = 4000;
lpf_frequency = 8;

%% Initial filtering
butter_bandpass_order = 80;
cutoff_bp_1 = 25;
cutoff_bp_2 = 400;

out_word_len_prefilt = 32;
out_fract_len_prefilt = 31;

sample_period_filtering = 1/5e6;

%% SWT
[LoD,HiD,~,~] = wfilters('db1');

const_bin_width = 32;
const_frac_width = 31;

%level-2
bit_width_l2 = 32;
frac_bit_l2 = 30;
%level-3
bit_width_l3 = 32;
frac_bit_l3 = 29;
%level-4
bit_width_l4 = 32;
frac_bit_l4 = 28;

small_constant = 1e-8;

%log
log_word_len = 48;
log_fract_len = 43;
log_latency = 21;

grp_delay_swt = 12;
sample_period_swt = 1/5e6;
%% Hilbert
fft_len_hilb = 2048; %FR ~ 1 Hz
fft_freq = 32;
sample_period_hilbert = 1/5e6;

grp_delay_hilb = 11;
%% Homomorphic
% log
log_word_len_homo = 32;
log_fract_len_homo = 31;

% filter
fir_coeff_width=32;
fir_coeff_fract=32;

order = 180;
cutt_off_homo_filt = 2*lpf_frequency/fs;
Ap=0.01;
Ast=80;
Rst = 10^(-Ast/20);
Rp = (10^(Ap/20) - 1)/(10^(Ap/20) + 1);
NUM = firceqrip(order,cutt_off_homo_filt,[Rp Rst],'passedge');
%fvtool(NUM,'Fs',fs)

% exp
exp_word_len_homo = 32;
exp_fract_len_homo = 26;
explarge_delay = 3;

cordic_input_width = 36;
cordic_bin_point = 33;
cordic_output_width = 32;
cordic_delay = 20;
cordic_iterations = 18;

grp_delay_homo = 13;

sample_period_homo = 1/5e6;
%% PSD
fft_length = 4096;
window_dim = 100;
window_val = tukeywin(100,.25); %hamming(window_dim);

freq = linspace(0,fft_length/2,fft_length/2+1)./(fft_length*1/fs);
fl_low=40;
fl_high=60;
[~,fl_low_index] = min(abs(freq-fl_low));
[~,fl_high_index] = min(abs(freq-fl_high));

scale = 1.0 / (fs * sum(window_val.*window_val));

fir_interpolator = dsp.FIRInterpolator(50);

fft_freq_psd = 32;

grp_delay_psd = 19;

sample_period_psd = 1/5e6;

%% Decimators
M = fs/50;
firdecim = dsp.FIRDecimator(M);
%firDecim4 = dsp.FIRDecimator(4);
%firDecim5 = dsp.FIRDecimator(5);

coeff_width = 32;
output_width = 32;

%% LOG
%https://it.mathworks.com/help/fixedpoint/ug/implement-fixed-point-log2-using-lookup-table.html
B = 8;  % Number of bits in a byte
log2_table = log2((2^(B-1) : 2^(B)) / 2^(B - 1));
NLZLUT = B-ceil(log2((1:2^B)));
l2e = 1/log2(exp(1));

%% EXP
%https://ieeexplore.ieee.org/document/9012611
l2 = log(2);
e_val = 1/l2;

%% Windowing
win_dim = 64;
win_bit = log2(win_dim)+1;