load igrf11-300km.mat
load b_o_avg_dipole_model.mat

global mu J2 rho Cd re_m w_e_deg T_e

%% Constants

G = 6.67428e-11; %gravity constant [m^3kg^-1s^-2]
m_e = 5.9742e24; %earth mass [kg]
mu = G*m_e; %earth gravitation coefficient [m^3s^-2]
re_e = 6378.1e3; %earth equatorial radius [m]
re_p = 6356.8e3; %earth polar radius [m]
re_m = 6371.2e3; %earth's mean radius [m]
T_e = 86164.1; %earth period (1 day) [s]
w_e = 2*pi/T_e; %angular velocity [rad/s]
w_e_deg = 50*360/T_e; %angular velocity [deg/s]
erad = 6378.1e3; %equatorial radius [m]
prad = 6356.8e3; %polar radius [m]
J2 = 1.0827e-3; %earth's dynamic oblateness


%% Magnetorquers properties

%i_max = 0.06; %maximum current [A]
N_x = 258; %number of windings x
N_y = 144; %number of windings y
N_z = 144; %number of windings z
A_x = 60*10*10^-6; %mean coil area x [m^2]
A_y = 60*10*10^-6; %mean coil area y [m^2]
A_z = 90^2*10^-6; %mean coil area z [m^2]

% Resistance in each coil
Rx = 30;
Ry = 30;
Rz = 83;

%A_x = 5329e-6; 
%A_y = 13724e-6; %mean Coil area [m^2]
%A_z = 13724e-6; %mean Coil area [m^2]
%mx_max = i_max*N_x*A_x;
%my_max = i_max*N_y*A_y;
%mz_max = i_max*N_z*A_z;

i_max=0.25;
mx_max=0.2;
my_max=0.2;
mz_max=0.2;
vx_max=2.5;
vy_max=2.5;
vz_max=5;

%% Sun pressure

Pp = 4.5*10^-6;
Ap = 0.1*0.2;
Cp = 1.6;

%% Aerodynamic drag

r = [0.005,0.001,0.001]';
rho = 42.418*10^-11;%300 km
%rho = 6.697*10^-13;%500 mean km
%rho = 1.170*10^-14;%800 km
Cd = 2.0;

%% Residual magnetic moment
m_dipoleDist =  [0.0001; -0.0001; 0.0005]';

%% Dipole model parameters

u_f=7.9*10^15; %dipole strength mu_f
i_m = (90-11)*pi/180;
i_0 = 11*pi/180;