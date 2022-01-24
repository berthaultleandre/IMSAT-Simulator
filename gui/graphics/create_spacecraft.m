function S = create_spacecraft(center, R, dim)
% https://fr.mathworks.com/matlabcentral/answers/168319-how-to-rotate-cube-in-matlab
A = [-.5 .5 -.5];
B = [.5 .5 -.5];
C = [.5 -.5 -.5];
D = [-.5 -.5 -.5];

E = [-.5 .5 .5];
F = [.5 .5 .5];
G = [.5 -.5 .5];
H = [-.5 -.5 .5];

S = [D;C;G;F;B;A;D;H;E;F;G;H;E;A;B;C];

S(:,1)=S(:,1)*dim(1);
S(:,2)=S(:,2)*dim(2);
S(:,3)=S(:,3)*dim(3);

S = rotate_spacecraft(S, R);
S = translate(S, center);

end

