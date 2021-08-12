function [gain] = getGainvhf(u)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global Gvhf Azimuth Coelevation

phi=u(1);   %Azimuth
theta=u(2); %Elevation

%test
X=Azimuth;
Y=Coelevation;
V=Gvhf;
%point to test:
Xq=phi;
Yq=theta;
gain = interp2(X,Y,V,Xq,Yq);
end
