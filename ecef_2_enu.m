function [r_ENU] = ecef_2_enu(u)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
h= u(1)/1000;
lat = u(2);
long = u(3);
Xe = u(4)/1000;
Ye = u(5)/1000;
Ze = u(6)/1000;

wgs84 = wgs84Ellipsoid('kilometer');
[X_E,Y_N,Z_U] = ecef2enu(Xe,Ye,Ze,lat,long,h,wgs84);
r_ENU=[X_E,Y_N,Z_U]';
end

