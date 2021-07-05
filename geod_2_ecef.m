function [X_ECEF] = geod_2_ecef(u)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
h=u(1);
lat=u(2);
long=u(3);
[X_ECEF] = [geod2ecef(lat,long,h)]';

end

