function [Gain] = interpol_ant(data)
%UNTITLED2 Gets the antenna gain from the azimuth and co-elevation
%direction
%   data= Az, el in degrees
phi=data(1);    %azimuth
theta=data(2);  %co-elevation

step=10;

%row(1) = 37* entero+ 
row=fix(phi/step)*37+1+fix(theta/step);


end

