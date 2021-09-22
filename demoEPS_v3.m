%MAIN SIMULATION LAUNCH CODE
%Orbit simulation
%The object is assumed submitted only to gravity and it's mass is m in kg
m = 10; %mass (kg), this parameter does not have any impact

%Initialisation of Keplerian parameters
%modifying RAAN (O), arg. of perigee (o) and date, different beta values can be found.
a = 6678; %semimajor axis (km)
e = 0.001; %eccentricity
i = 51.6; %inclination (degrees)
O = 181; %Right ascension of the right ascending node (degrees) %max 197,    %21/3 min 181 ok 300
o = 90; %Argument of the perigee (degrees)                      %max  90,    %21/3 min 90  ok 90
nu = 0; %True anomaly (degrees)
%Initialisation of date
year = 2020;
month = 3;
day = 21;
hours = 0;
minutes = 0;
seconds = 0;

%Duration of the simulation
N_orbits = 9;
%Torbit=90*60;       %1 orbit approx. 90 minutes
Torbit=2*pi*sqrt(a^3/(3.986004418E5));
%tsimulation=60*45;   %in [s] 1 orbit
tsimulation=N_orbits*Torbit;
%tsimulation=10000;
delta_t = 1; %simulation time step (seconds)

%Battery configuration
Cbat=2.6;           %Cell capacity in [Ah]
Nbs=4;
Nbp=4;
C=Cbat*Nbp*3600;    %Battery Capacity for all parallel arrays [Ampere*sec]

%Loads
Pload1=50;          %Required power Thruster [W]
%iLoad=2;     %to test, in [A]
Pload2=2;           %Required power OBC [W]
Pload3=2.5;         %Required power ADCS w/o RWA [W]
Pload4=1.7;         %Required power Com (Rx)[W]

eff_iBat=0.95;      %efficiency from Battery to load
eff_i1=0.9;         %efficiency PDU CH not regulated
eff_i2=0.85;        %efficiency PDU CH 3.3V

%Power Generation
Psa=48;             %Peak power generation [W]
eff_ACU=0.85;       %efficiency ACU conversion
P_eps=0.6;          %internal power consumption EPS [W]

%Battery
DOD_0=0;            %initial DOD from 0 to 1
%iB=2;   %to test in [A]

%Charge/Discharge logic
I_BD_max= 5;        %Maximum discharge current [A] approx. C/2
I_BC_max= 3;        %Maximum charge current [A] approx. C/3.5
%inside the function:
% Vfull=16.8;     %full battery charge
% Vmax=16.6;      %maximum charge battery
% Vnorm=14;       %battery normal voltage
% Vsafe=13.4;      %minimum battery safe voltage
% Vcrit=13;       %critical battery voltage


EPS_orbit_v1a_R19a
Power=sim('EPS_orbit_v1a_R19a');

EPS_sim_test_v3_R19a
E=sim('EPS_sim_test_v3_R19a');


%% data for Plots
timesec = E.tout;
time=timesec/60;  %to plot in minutes
DOD = getdatasamples(E.DOD,(1:length(time)));
Vbat = getdatasamples(E.Vbat,(1:length(time)));
Ibat = getdatasamples(E.Ibat,(1:length(time)));
SOC = 100*(1 - DOD);
Pcollected = getdatasamples(Power.Psa1,(1:length(time)));
beta = getdatasamples(Power.beta,(1:length(time)));
Ploads = getdatasamples(E.LOAD,(1:length(time)));

%get charge and discharge currents
ibc=zeros(length(time),1);
ibd=zeros(length(time),1);
for i=1:length(time)
    if Ibat(i)>0
        ibc(i,1)=0;
        ibd(i,1)=Ibat(i);
    end
    if Ibat(i)<0
        ibc(i,1)=-Ibat(i);
        ibd(i,1)=0;
    end
end

%% Plots

time=timesec/60;  %to plot in minutes
figure(1)
set(gcf,'color','w');
    subplot(3,1,1)
        plot(time,Pcollected,'b','LineWidth',1)
        hold on;
        legend('Power Generated by SA [W]')
        title('Power Generated')
        ylabel('Power [W]')
        xlabel('time in minutes')
        grid on
    subplot(3,1,2)
        plot(time,Ploads,'b','LineWidth',1)
        hold on;
        legend('All Power Requested by Loads [W]')
        title('Power Loads')
        ylabel('Power [W]')
        xlabel('time in minutes')
        grid on
    subplot(3,1,3)
        plot(time,beta,'b','LineWidth',1)
        hold on;
        legend('Beta angle [deg]')
        title('Angle between sun and projection on orbit plane (Beta angle)')
        ylabel('Angle [deg]')
        xlabel('time in minutes')
        grid on

figure(2)
set(gcf,'color','w');
    subplot(2,2,1)
        plot(time,SOC,'b','LineWidth',1)
        hold on;
        legend('State of Charge [%]')
        title('4S 4P Battery State of Charge')
        ylabel('Charge %')
        xlabel('time in minutes')
        grid on
subplot(2,2,3)
        plot(time,Vbat,'b','LineWidth',1)
        hold on;
        yline(16.8, 'b--', 'LineWidth', 1);
        yline(16.6, 'm--', 'LineWidth', 1);
        yline(14.0, 'g--', 'LineWidth', 1);
        yline(13.4, 'r--', 'LineWidth', 1);
        yline(13.0, 'b--', 'LineWidth', 1);
        legend('Battery array Voltage [V]','100%','Vmax','Vnormal','Vsafe','Vcritical')
        title('4S 4P Battery Voltage')
        ylabel('Voltage')
        xlabel('time in minutes')
        grid on
subplot(2,2,2)
        plot(time,ibc,'b','LineWidth',1)
        hold on;
        yline(1.04, 'b--', 'LineWidth', 1);
        yline(0.52, 'g--', 'LineWidth', 1);
        yline(2.08, 'r--', 'LineWidth', 1);
        legend('Charge Current [A]','C/10','C/20','C/5')
        title('4S 4P Battery Charge Current')
        ylabel('Current [A]')
        xlabel('time in minutes')
        grid on
subplot(2,2,4)
        plot(time,ibd,'b','LineWidth',1)
        yline(1.04, 'b--', 'LineWidth', 1);
        yline(0.52, 'g--', 'LineWidth', 1);
        yline(2.08, 'r--', 'LineWidth', 1);
        yline(3.46, 'm--', 'LineWidth', 1);
        hold on;
        legend('Discharge Current [A]','C/10','C/20','C/5','C/3')
        title('4S 4P Battery Discharge Current')
        ylabel('Current [A]')
        xlabel('time in minutes')
        grid on