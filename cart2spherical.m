function [phi_theta] = cart2spherical(u)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
x=u(1);
y=u(2);
z=u(3);
r=sqrt(x^2+y^2+z^2);
theta=180/pi*acos(z/r);    %co-elevation
phi=180/pi*atan2(y,x);     %azimuth
if phi<0
    phi=phi+360;           %phi has to be between 0 and 360
end
phi_theta=[phi;theta];
end

