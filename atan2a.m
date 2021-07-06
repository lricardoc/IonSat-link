function [angle] = atan2a(u)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   Output: angle in degrees from 0 to 360
x=u(1);
y=u(2);
angle=180/pi*atan2(y,x);
if angle<0
    angle=angle+360;
end

%angle=180/pi()*(pi()-pi()/2*(1+sign(x))*(1-sign(y^2))-pi()/4*(2+sign(x))*sign(y));
end

