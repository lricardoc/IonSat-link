function [linkmarginup] = linkbudgetuplinkvhf(u)

%   Detailed explanation goes here
sc_antenna_gain=u(1);
range=u(2);

% Parameters
frequency=145.8e6; %Hz
c=3e8; %m/s celerity
boltzmann=-228.6;
R_earth = 6.3712e+6; 
a = 6678;
alt_orbit=a*1000-R_earth;
d_0=(sqrt((R_earth+alt_orbit)^2-R_earth^2))/1000;


%Ground Station
gs_transmitter_power=100; % in Watts
gs_dBW=10*log10(gs_transmitter_power);
gs_total_transmission_line_losses=1.9; %in dB
gs_antenna_gain=14; %in dBi
gs_EIRP=gs_dBW+gs_antenna_gain-gs_total_transmission_line_losses;

%Spacecraft
sc_transmitter_power=1; % in Watts
sc_dBW=10*log10(sc_transmitter_power);
sc_total_tranmission_line_losses=2.2;
Loss_from_duplexer_insertion=1;%in dB
sc_EIRP=sc_antenna_gain+sc_dBW-sc_total_tranmission_line_losses-Loss_from_duplexer_insertion;

%uplink
gs_Antenna_Pointing_loss=0.3;
Gnd_to_sc_Antenna_Polarization_Loss=3;


FSL=20*log10(4*pi*range*frequency/c);

Atmospheric_loss=2.1;
Ionospheric_loss=0.7;
Rain_loss=0;
Isotropic_sc=gs_EIRP-Rain_loss-Ionospheric_loss-Atmospheric_loss-FSL-gs_Antenna_Pointing_loss-Gnd_to_sc_Antenna_Polarization_Loss;

%spacecraft eb/no method
sc_antenna_pointingloss=0;
sc_effective_noise_temperature=290; %in K
sc_figureofmerrit=sc_antenna_gain-sc_total_tranmission_line_losses-10*log10(sc_effective_noise_temperature);
sc_SNR=sc_EIRP+sc_figureofmerrit-boltzmann-sc_antenna_pointingloss+Isotropic_sc;
System_Desired_Data_Rate=9600; %bps
data_rate_dBHz=10*log10(System_Desired_Data_Rate);
Telecommand_System_ebno=sc_SNR-data_rate_dBHz;
EbNo_theoric=9.6;
Technological_losses=1.5;
EbNo_Threshold=EbNo_theoric+Technological_losses;

linkmarginup=Telecommand_System_ebno-EbNo_Threshold;

end

