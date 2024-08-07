function [phi_theta_r] = cart2spherical2(u)
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
% Co-elevation (theta) is defined as the angle from z axis towards the xy plane
% Elevation (ele) is the angle from the xy plane towards the zenith
% Azimuth (phi) is defined as the angle from x to y in the xy plane 
%    * values of elevation (ele), azimuth (phi) and range (r)
x=u(1);
y=u(2);
z=u(3);
r=sqrt(x^2+y^2+z^2);
theta=180/pi*acos(z/r);    %co-elevation
ele=90-theta;
phi=180/pi*atan2(y,x);     %azimuth
if phi<0
    phi=phi+360;           %phi has to be between 0 and 360
end
phi_theta_r=[phi;ele;r];
end
