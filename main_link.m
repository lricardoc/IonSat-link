%Orbit simulation
%The object is assumed submitted only to gravity and it's mass is m in kg
m = 10; %mass (kg)
%Initialisation of Keplerian parameters
a = 6678; %semimajor axis (km)
e = 0.001; %eccentricity
i = 51.6; %inclination (degrees)
O = 197; %Right ascension of the right ascending node (degrees) %max 197, min 300.5 %181
o = 90; %Argument of the perigee (degrees)                      %max 90, min 0      %90
nu = 0; %True anomaly (degrees)

%Initialisation of date
year = 2020;
month = 1;
day = 1;
hours = 0;
minutes = 0;
seconds = 0;

%Simulation time parameters
N_orbits = 3;
%Torbit=90*60;       %1 orbit approx. 90 minutes
Torbit=2*pi*sqrt(a^3/(3.986004418E5));
%tsimulation=60*45;   %in [s] 1 orbit
tsimulation=N_orbits*Torbit;
%tsimulation=10000;
%tsimulation=2700;
delta_t = 0.5; %simulation time step (seconds)

%%% GET PROPER IGRF COEFFICIENTS %%%
date = [year,month,day];
gh = loadigrfcoefsim(datenum(date));
%Define order of the IGRF approximation
nmax = 2;
%Earth Radius in meters used in IGRF 2020 model
R_earth = 6.3712e+6; 

%% Ground Station parameters
lat=43.6;    %latitude in degrees
long=1.44;   %longitude in degrees
h=189;      %altitude in meters


A_EKFv1
data=sim('A_EKFv1');