function res = translate(S,u)
    res = S;
    for i=1:size(S,1)
        res(i,:)=res(i,:)+u';
    end
end

