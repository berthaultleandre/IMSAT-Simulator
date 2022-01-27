function [a, incl, Omega, e, w, M, n] = TLE_to_orbital_elements(line2,mu)
% Orbit Inclination (degrees to rad)
incl = deg2rad (str2double(line2(9:16)));
% Right Ascension of Ascending Node (RAAN) (degrees to rad)
Omega = deg2rad(str2double(line2(18:25)));
% Eccentricity
e = str2double(line2(27:33))*1E-7;
% Argument of Perigee (degrees to rad)
w = deg2rad(str2double(line2(35:42)));
% Mean Anomaly (degrees to rad)
M = deg2rad(str2double(line2(44:51)));
% Mean Motion (revolutions/day)
n = str2double(line2(53:63));

a = mu^(1/3)/(n*2*pi/(24*3600))^(2/3);
end

