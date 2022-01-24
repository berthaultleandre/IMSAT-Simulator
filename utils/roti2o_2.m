function Rio = roti2o_2(v_dir,center)
%https://math.stackexchange.com/questions/23197/finding-a-rotation-transformation-from-two-coordinate-frames-in-3-space
    xi=[1;0;0];
    xo=v_dir;
    xo=xo/norm(xo);
    
    zi=[0;0;1];
    zo=-center;
    zo=zo/norm(zo);
    
    B=xi*xo'+zi*zo';
    [U,~,V]=svd(B);
    M=diag([1 1 det(U)*det(V)]);
    Rio=U*M*V';
    Rio=Rio';
end

