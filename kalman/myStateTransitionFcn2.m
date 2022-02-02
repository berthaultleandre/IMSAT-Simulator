

function x = myStateTransitionFcn2(x,u)
I=[u(16:18) u(19:21) u(22:24)];
w_0=u(25);
% I=const(1:3,1:3);
% w_0=const(4,2);
% Sample time [s]
dt = 0.01; 

omega=[x(1); x(2); x(3)];
q=[x(4); x(5); x(6); x(7)];
g=[x(4); x(5); x(6)];

w=[0 0 0];
w(1) = 2*w_0*(q(1)*q(2)+q(3)*q(4));
w(2) = w_0*(-q(1)^2+q(2)^2-q(3)^2+q(4)^2);
w(3) = 2*w_0*(q(2)*q(3)-q(1)*q(4));


%u=[m T_w h T_m T_d]

omega_0=w';
omega_point=inv(I)*(I*skew(omega)*omega_0-(skew(omega)-skew(omega_0))*(I*omega+I*omega_0+u(10:12))+u(7:9)+u(13:15));
g_point=-1/2*skew(omega)*g+1/2*q(4)*omega;
q4_point=-1/2*omega'*g;

x1=omega_point(1);  %w1
x2=omega_point(2);  %w2
x3=omega_point(3);  %w3
x4=g_point(1);  %q1
x5=g_point(2);  %q2
x6=g_point(3);  %q3
x7=q4_point;  %q4

x=x+[x1; x2; x3; x4; x5; x6; x7]*dt;

end
