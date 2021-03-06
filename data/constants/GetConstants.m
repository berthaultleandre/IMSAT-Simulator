function c = GetConstants()
    c=struct();
    %% Constants

    c.G = 6.67428e-11; %gravity constant [m^3kg^-1s^-2]
    c.m_e = 5.9742e24; %earth mass [kg]
    c.mu = c.G*c.m_e; %earth gravitation coefficient [m^3s^-2]
    c.re_e = 6378.1e3; %earth equatorial radius [m]
    c.re_p = 6356.8e3; %earth polar radius [m]
    c.re_m = 6371.2e3; %earth's mean radius [m]
    c.T_e = 86164.1; %earth period (1 day) [s]
    c.w_e = 2*pi/c.T_e; %angular velocity [rad/s]
    c.w_e_deg = 360/c.T_e; %angular velocity [deg/s]
    c.erad = 6378.1e3; %equatorial radius [m]
    c.prad = 6356.8e3; %polar radius [m]
    c.J2 = 1.0827e-3; %earth's dynamic oblateness

    %% Sun

    c.r_min_sun=147098074000;
    c.r_max_sun=152097701000;
    c.b_sun=(c.r_min_sun^2*c.r_max_sun)^(1/3);
    c.a_sun=(c.r_max_sun^2*c.r_min_sun)^(1/3);
    c.e_sun=0.01671022;
    c.w_sun=2*pi/(365.2422*24*60*60);

    %% ODE
    c.tol = 1e-10; %tolerance for orbit calculus
        
    %% Magnetorquers properties

    %i_max = 0.06; %maximum current [A]
    c.N_x = 258; %number of windings x
    c.N_y = 144; %number of windings y
    c.N_z = 144; %number of windings z
    c.A_x = 60*10*10^-6; %mean coil area x [m^2]
    c.A_y = 60*10*10^-6; %mean coil area y [m^2]
    c.A_z = 90^2*10^-6; %mean coil area z [m^2]

    % Resistance in each coil
    c.Rx = 30;
    c.Ry = 30;
    c.Rz = 83;

    %A_x = 5329e-6; 
    %A_y = 13724e-6; %mean Coil area [m^2]
    %A_z = 13724e-6; %mean Coil area [m^2]
    %mx_max = i_max*N_x*A_x;
    %my_max = i_max*N_y*A_y;
    %mz_max = i_max*N_z*A_z;

    c.i_max=0.25;
    c.mx_max=0.2;
    c.my_max=0.2;
    c.mz_max=0.2;
    c.vx_max=2.5;
    c.vy_max=2.5;
    c.vz_max=5;

    %% Sun pressure

    c.r_sun_pressure = [0.005,0.001,0.001]';
    c.Pp = 4.5*10^-6;
    c.Ap = 0.1*0.2;
    c.Cp = 1.6;

    %% Aerodynamic drag

    c.r_drag = [0.005,0.001,0.001]';
    c.rho = 42.418*10^-11;%300 km
    %rho = 6.697*10^-13;%500 mean km
    %rho = 1.170*10^-14;%800 km
    c.Cd = 2.0;

    %% Residual magnetic moment
    c.m_dipoleDist =  [0.0001; -0.0001; 0.0005]';

    %% Dipole model parameters

    c.u_f=7.9*10^15; %dipole strength mu_f
    c.i_m = (90-11)*pi/180;
    c.i_0 = 11*pi/180;                                                                                                                                                                                                            
    
end