function [phi_theta] = cart2spherical(u)
%This function converts cartesian coordinates to spherical (co-elevation
%and azimuth
% Syntax:
% y=cart2spherical(u)
% Input argument:
%   1 * u(1):      cartesian coordinate x
%   2 * u(2):      cartesian coordinate y
%   3 * u(3):      cartesian coordinate z
% Output argument
%    * y=[phi;theta];
% Co-elevation is defined as the angle from z axis towards the xy plane
% Azimuth is defined as the angle from x to y in the xy plane 
%    * two values of co-elevation (theta) and azimuth (phi)
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

