function [gain] = getGainvhf(u)
%This function gets the gain of a VHF antenna from a matrix called Gvhf
% Syntax:
% y=getGainvhf(u)
% Input argument:
%   1 * u(1):      Azimuth
%   2 * u(2):      Co-elevation
% Output argument
%    * y=[gain];
% Co-elevation is defined as the angle from z axis towards the xy plane
% Azimuth is defined as the angle from x to y in the xy plane 
% the gain is calculated interpolating the values of theta and phi with one
% pre-calculated table of gains in function of Azimuth and Co-Elevation
% from a FEM simulator
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
