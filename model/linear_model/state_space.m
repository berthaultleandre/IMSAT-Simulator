function [A,B,C,D] = state_space(g_chap, w_chap, h_chap, b_b_avg)
global I w_0;

q4_chap=sqrt(1-norm(g_chap)^2);
q_chap=[g_chap q4_chap];
w_o_chap=w_o(q_chap);
c_3_chap=c_3(q_chap);
I_check=check(I);
I_inv=inv(I);

Aww=I_inv*(-I*skew(w_o_chap)-I_check*skew_star(w_chap)+...
    skew(I*w_o_chap')-skew(w_o_chap)*I+skew(h_chap));

Awg=I_inv*(I*skew(w_chap)-skew(w_chap)*I+skew(I*w_chap')-...
    I_check*skew_star(w_o_chap)+skew(h_chap))*dw_o(q_chap)+...
    3*w_0^2*I_inv*I_check*skew_star(c_3_chap)*dc_3(q_chap);

Agw=1/2*skew(g_chap)+1/2*q_chap(4)*eye(3);

Agg=-1/2*skew(w_chap);

Bm=I_inv*skew(b_b_avg)*skew(b_b_avg)/norm(b_b_avg)^2; %- ?

A = [Aww Awg;Agw Agg];
B = [Bm inv(I);zeros(3) zeros(3)];
C = eye(6);
D = zeros(size(C,1),size(B,2));
end

