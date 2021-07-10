function [gain] = getGain(u)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global Gtest Azimuth Coelevation

phi=u(1);   %Azimuth
theta=u(2); %Elevation

%test
X=Azimuth;
Y=Coelevation;
V=Gtest;
%point to test:
Xq=phi;
Yq=theta;
gain = interp2(X,Y,V,Xq,Yq);
end
