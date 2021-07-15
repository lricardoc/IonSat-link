function [linkmargin] = linkbudgetdownlink(sc_antenna_gain)

%   Detailed explanation goes here

%% Parameters
global Gtest Coelevation gainHF 
R_earth = 6.3712e+6;
a = 6678;
alt_orbit=a*1000-R_earth;
d_0=(sqrt((R_earth+alt_orbit)^2-R_earth^2))/1000;
slant_range=sqrt(R_earth^2+(R_earth+alt_orbit)^2 - (2*R_earth*(R_earth+alt_orbit)*cos(acos(R_earth/(R_earth+alt_orbit))*cos(Coelevation)-Coelevation)));
frequency=2200e6; %Hz
c=3e8; %m/s celerity
boltzmann=-226.8;

sc_antenna_gain=gainHF(:,3);


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
loss_from_duplexer_insertion=1; %in dB
double_antenna_transmission_losses=3; %in dB
%sc_antenna_gain=-1; %in dBi at 5° elevation
sc_EIRP=sc_antenna_gain+sc_dBW-sc_total_tranmission_line_losses-loss_from_duplexer_insertion-double_antenna_transmission_losses;

%downlink
sc_Antenna_Pointing_loss=0;
sc_to_gs_Antenna_Polarization_Loss=3;
FSL=20*log10(4*pi*d_0*frequency/c);
Atmospheric_loss=3;
Ionospheric_loss=0;
Rain_loss=0;
Isotropic_gs=sc_EIRP-Rain_loss-Ionospheric_loss-Atmospheric_loss-FSL-sc_Antenna_Pointing_loss-sc_to_gs_Antenna_Polarization_Loss;

%gs eb/no method
gs_antenna_pointingloss=0.9;
gs_effective_noise_temperature=290; %in K
gs_figureofmerrit=sc_antenna_gain-sc_total_tranmission_line_losses-10*log10(gs_effective_noise_temperature);
gs_SNR=gs_figureofmerrit-boltzmann-gs_antenna_pointingloss+Isotropic_gs;
System_Desired_Data_Rate=2; %Mbps
data_rate_dBHz=10*log10(System_Desired_Data_Rate*1000000);
Telecommand_System_ebno=gs_SNR-data_rate_dBHz;
BER=1e-5;
EbNo_theoric=9.6;
Technological_losses=1.5;
EbNo_Threshold=EbNo_theoric+Technological_losses;

linkmargin=Telecommand_System_ebno-EbNo_Threshold;

end

