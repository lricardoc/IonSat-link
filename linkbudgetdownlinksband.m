function [linkmargindown] = linkbudgetdownlinksband(u)

%   Detailed explanation goes here

sc_antenna_gain=u(1);
range=u(2);

% Parameterss
frequency=2100e6; %Hz
c=3e8; %m/s celerity
boltzmann=-228.6;

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
sc_EIRP=sc_antenna_gain+sc_dBW-sc_total_tranmission_line_losses-loss_from_duplexer_insertion-double_antenna_transmission_losses;

%downlink
sc_Antenna_Pointing_loss=0;
sc_to_gs_Antenna_Polarization_Loss=3;
FSL=20*log10(4*pi*range*frequency/c);
Atmospheric_loss=3;
Ionospheric_loss=0;
Rain_loss=0;
Isotropic_gs=sc_EIRP-Rain_loss-Ionospheric_loss-Atmospheric_loss-FSL-sc_Antenna_Pointing_loss-sc_to_gs_Antenna_Polarization_Loss;

%gs eb/no method
gs_antenna_pointingloss=0.9;
gs_effective_noise_temperature=510; %in K
gs_figureofmerrit=gs_antenna_gain-gs_total_tranmission_line_losses-10*log10(gs_effective_noise_temperature);
gs_SNR=gs_EIRP+gs_figureofmerrit-boltzmann-gs_antenna_pointingloss+Isotropic_gs;
System_Desired_Data_Rate=2; %Mbps
data_rate_dBHz=10*log10(System_Desired_Data_Rate*1000000);
Telemetry_System_ebno=gs_SNR-data_rate_dBHz;
EbNo_theoric=9.6;
Technological_losses=1.5;
EbNo_Threshold=EbNo_theoric+Technological_losses;

linkmargindown=Telemetry_System_ebno-EbNo_Threshold;

end

