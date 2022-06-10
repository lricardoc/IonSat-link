function I = pv_math(G,T,Isc,Voc,A,Rs,Rsh,Ns,Np,Ki,Kv,V,i)
    
    q = 1.6e-19;                          % Electron charge
    k = 1.38e-23;                         % Boltzmann constant
    Tcell = 273+T;                        % Cell temperature in Kelvin
    vt=(A*k*Tcell*Ns)/q;                  % Thermal voltage Equation(5)
        
    Isc_T = Isc+((Isc*(Ki/100))*(T-25));  % Isc temperature coef Equation(6)
    Voc_T = Voc+((Voc*(Kv/100))*(T-25));  % Voc temperature coef Equation(7)
    Is = Isc_T/(exp(Voc_T/vt)-1);         % Reverse saturation current Equation(8)
    Iph = Isc_T*(G/1000);                 % Photon current Equation(9)
    
    % Single diode model output current Equation(4)
    I = Np*Iph-(Np*Is*(exp((V+(i*Rs/Np))/vt)-1))-((Np*V+(i*Rs))/Rsh);
end
