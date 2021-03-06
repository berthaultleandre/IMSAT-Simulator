function b_o_avg=b_o_avg_dipole_model(c)
    %Bavg computes the average B matrix in the linearized satellite dynamics
    %using the geomagnetic field model data over one orbit period.
    %The average of the B matrix divided with the 2-norm of the magnetic
    %field, and the average of the B matrix divided with the squared 2-norm
    %of the magnetic field are also calculated.
    %Fredrik Stray 2010
    %https://core.ac.uk/download/pdf/30798469.pdf
    %Calculating over one period
    bxs=[];
    bys=[];
    bzs=[];
    for t = 0:c.T_o
        b = c.u_f/c.r_o^3*[cos(c.w_0*(t-c.i_0/c.w_0))*sin(c.i_m);...
        -cos(c.i_m);2*sin(c.w_0*(t-c.i_0/c.w_0))*sin(c.i_m)];
        bxs(t+1)=b(1);
        bys(t+1)=b(2);
        bzs(t+1)=b(3);
    end
    %Calculating the averages and saving
    b_o_avg=[sum(bxs);sum(bys);sum(bzs)]/c.T_o;
    save('data/b_o_avg_dipole_model.mat','b_o_avg')
end