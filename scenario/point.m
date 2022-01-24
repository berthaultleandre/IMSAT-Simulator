function Rob_chap = point(target,center,Rio)
    
    zi=[0;0;1];
    zb=target-center;
    zb=zb/norm(zb);
    
    %Rtemp=vrrotvec2mat(vrrotvec(zi,zb));
    
    xi=[1;0;0];
    n=null(zb');
    xb=n(:,1);
    xb=xb/norm(xb);
    
    B=xi*xb'+zi*zb';
    [U,~,V]=svd(B);
    M=diag([1 1 det(U)*det(V)]);
    Rib=U*M*V';
    
    Rob_chap=Rib*Rio;
    Rob_chap=Rob_chap';
end

