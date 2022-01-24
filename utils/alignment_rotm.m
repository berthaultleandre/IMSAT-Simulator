function R = alignment_rotm(a,b)
%https://math.stackexchange.com/questions/180418/calculate-rotation-matrix-to-align-vector-a-to-vector-b-in-3d
    u = a/norm(a);
    v = b/norm(b);
    N = length(u);
    S = reflection(eye(N), v+u);      % S*u = -v, S*v = -u 
    R = reflection(S, v); 
end

