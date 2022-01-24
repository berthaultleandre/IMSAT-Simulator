%Bavg computes the average B matrix in the linearized satellite
%dynamics using the geomagnetic field model data over one orbit
%period. The average of the B matrix divided with the 2-norm of
%the magnetic field,
%and he average of the B matrix divided with the squared 2-norm of the
%magnetic field are also calculated.
%Fredrik Stray 2010
%The geomagnetic field model data is loaded.
load igrf11-300km
%Calculating over one period
for i = 1:length(box300)
    vec=[box300(i),boy300(i),boz300(i)]';
    S = skew(vec)*skew(vec)';
    S11(i)=S(1,1);
    S12(i)=S(1,2);
    S13(i)=S(1,3);
    S21(i)=S(2,1);
    S22(i)=S(2,2);
    S23(i)=S(2,3);
    S31(i)=S(3,1);
    S32(i)=S(3,2);
    S33(i)=S(3,3);
    S = skew(vec)*skew(vec)'/norm(vec)^2;
    Ss11(i)=S(1,1);
    Ss12(i)=S(1,2);
    Ss13(i)=S(1,3);
    Ss21(i)=S(2,1);
    Ss22(i)=S(2,2);
    Ss23(i)=S(2,3);
    Ss31(i)=S(3,1);
    Ss32(i)=S(3,2);
    Ss33(i)=S(3,3);
    S = skew(vec)*skew(vec)'/norm(vec);
    Sss11(i)=S(1,1);
    Sss12(i)=S(1,2);
    Sss13(i)=S(1,3);
    Sss21(i)=S(2,1);
    Sss22(i)=S(2,2);
    Sss23(i)=S(2,3);
    Sss31(i)=S(3,1);
    Sss32(i)=S(3,2);
    Sss33(i)=S(3,3);
end
%Calculating the averages and saving
gamma=[sum(S11),sum(S21),sum(S31);
sum(S12),sum(S22),sum(S32);
sum(S13),sum(S23),sum(S33)]/i;
save('gamma.mat','gamma')
gammaNorm2=[sum(Ss11),sum(Ss21),sum(Ss31);
sum(Ss12),sum(Ss22),sum(Ss32);
sum(Ss13),sum(Ss23),sum(Ss33)]/i;
save('gammaNorm2.mat','gammaNorm2')
gammaNorm=[sum(Sss11),sum(Sss21),sum(Sss31);
sum(Sss12),sum(Sss22),sum(Sss32);
sum(Sss13),sum(Sss23),sum(Sss33)]/i;
save('gammaNorm.mat','gammaNorm')
