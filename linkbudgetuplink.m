function [linkmargin] = linkbudgetuplink()

%   Detailed explanation goes here

%% Parameters
slant_range=sqrt(R_earth^2+(R_earth+alt_orbit)^2 - (2*R_earth*(R_earth+alt_orbit)*cos(acos(R_earth/(R_earth+alt_orbit))*cos(Coelevation)-Coelevation)));
frequency=2100e6; %Hz
c=3e8; %m/s celerity
cst_boltzmann=-226.8;

%Ground Station
gs_transmitter_power=11.8; % in Watts
gs_dBW=10*log10(gs_transmitter_power);
gs_total_tranmission_line_losses=7.3; %in dB
gs_antenna_gain=31; %in dBi
gs_EIRP=gs_dBW+gs_antenna_gain-gs_total_tranmission_line_losses;

%Spacecraft
sc_transmitter_power=2; % in Watts
sc_dBW=10*log10(sc_transmitter_power);
sc_total_tranmission_line_losses=2; %in dB
sc_antenna_gain=-1; %in dBi
sc_EIRP=sc_antenna_gain+sc_dBW-sc_total_tranmission_line_losses;

%uplink
Ground_Station_Antenna_Pointing_loss=0.9;
Gnd_to_sc_Antenna_Polarization_Loss=3;
FSL=20*log10(4*pi*slant_range*frequency/c);
Atmospheric_loss=3;
Ionospheric_loss=0;
Rain_loss=0;
Isotropic_Signal_Level_at_Spacecraft=gs_EIRP-Rain_loss-Ionospheric_loss-Atmospheric_loss-FSL-Ground_Station_Antenna_Pointing_loss-Gnd_to_sc_Antenna_Polarization_Loss;

%spacecraft eb/no method
sc_antenna_pointingloss=0;
sc_effective_noise_temperature=290; %in K
sc_figureofmerrit=sc_antenna_gain-sc_total_tranmission_line_losses-10*log10(sc_effective_noise_temperature);
sc_SNR=-cst_boltzmann+sc_figureofmerrit-sc_antenna_pointingloss+Isotropic_Signal_Level_at_Spacecraft;
System_Desired_Data_Rate=64; %kbps
data_rate_dBHz=10*log10(System_Desired_Data_Rate*1000);
Telecommand_System_ebno=sc_SNR-data_rate_dBHz;
BER=1e-5;
EbNo_theoric=9.6;
Technological_losses=1;
EbNo_Threshold=EbNo_theoric+Technological_losses;
System_Link_Margin=Telecommand_System_ebno-EbNo_Threshold;

%%
outputArg1 = inputArg1;
outputArg2 = inputArg2;
end

