function dP = riccati(t, P, A, B, Wu, Wx)
    P = reshape(P, size(A)); %Convert from "n^2"-by-1 to "n"-by-"n"
    dP = -(P*A + A'*P - P*B*inv(Wu)*B'*P + Wx); %Determine derivative
    dP = dP(:); %Convert from "n"-by-"n" to "n^2"-by-1
end