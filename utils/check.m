function [Dc] = check(D)
Dx=D(1,1);
Dy=D(2,2);
Dz=D(3,3);
Dc=diag([Dz-Dy,Dx-Dz,Dy-Dx]);
end

