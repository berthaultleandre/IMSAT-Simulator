function euler = quat2euler(q)
% [phi,theta,psi] = Q2EULER(q) computes the Euler angles from the unit
% quaternions q = [eps1 eps2 eps3 eta]
%
% Author: Thor I. Fossen
% Date: 14th June 2001
% Edited by Fredrik Stray 2010
R = Rquat(q);
phi = atan2(R(3,2),R(3,3));
theta = -asin(R(3,1));
psi = atan2(R(2,1),R(1,1));
euler=180/pi*[phi theta psi];
end