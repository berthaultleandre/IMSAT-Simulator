function [A,B,C,D] = state_space_wheels_only_2(q_chap,data)
c=data.constants;
I=c.I;
w_0=c.w_0;

ctrl=data.control;
w_chap=ctrl.w_chap;
h_chap=ctrl.h_chap;

q4_chap=q_chap(4);
g_chap=q_chap(1:3);
w_o_chap=w_o(q_chap,w_0);
c_3_chap=c_3(q_chap);
I_check=check(I);
I_inv=inv(I);

Aww=I_inv*(-I*skew(w_o_chap)-I_check*skew_star(w_chap')+...
    skew(I*w_o_chap')-skew(w_o_chap)*I+skew(h_chap'));

Awg=I_inv*(I*skew(w_chap')-skew(w_chap')*I+skew(I*w_chap)-...
    I_check*skew_star(w_o_chap)+skew(h_chap'))*dw_o(q_chap,w_0)+...
    3*w_0^2*I_inv*I_check*skew_star(c_3_chap)*dc_3(q_chap);

Awh=I_inv*(-skew(w_chap')-skew(w_o_chap));

Agw=1/2*skew(g_chap)+1/2*q_chap(4)*eye(3);

Agg=-1/2*skew(w_chap');

Agh=zeros(3,3);

A = [Aww Awg Awh;Agw Agg Agh;zeros(3,9)];
B = [inv(I);zeros(3);-eye(3)];
C = eye(9);
D = zeros(size(C,1),size(B,2));
end

