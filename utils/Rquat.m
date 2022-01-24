function R = Rquat(q)
% R = Rquat(q) computes the quaternion rotation matrix R in SO(3)
g = q(1:3);
q4 = q(4);
R = (q4^2-norm(g)^2)*eye(3) + 2*g*g'-2*q4*skew(g);
end