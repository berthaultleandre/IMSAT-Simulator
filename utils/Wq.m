function W = Wq(q)
W = 0.5*[q(4) -q(3) q(2);
q(3) q(4) -q(1);
-q(2) q(1) q(4);
-q(1) -q(2) -q(3)];
end