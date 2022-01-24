function M = dw_o(q)
    global w_0
    M=2*w_0*[q(2) q(1) q(4);
        -q(1) q(2) -q(3);
        -q(4) q(3) q(2)];
end

