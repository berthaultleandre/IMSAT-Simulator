%Find all open Simulink scopes and return
%their handles to an array called hScopeFig.
hScopeFig = findall(0,'Type','Figure','Tag','SIMULINK_SIMSCOPE_FIGURE');
%Set the renderer for all open scopes to painters.
set(hScopeFig,'Render','painters');
%Turn off the Scople/Zbuffer warnings.
warning('off','Simulink:SL_ScopeRendererNotZBuffer');

close all;
clear
clc;

global I u_f r_o i_m w_0 T_o i_0 h_w_max re_m h_o;


load igrf11-300km.mat
load b_o_avg_dipole_model.mat
wheels_configurations

fprintf("Setting up model...\n\n");

%% Constants

G = 6.67428e-11; %gravity constant [m^3kg^-1s^-2]
m_e = 5.9742e24; %earth mass [kg]
mu = G*m_e; %earth gravitation coefficient [m^3s^-2]
re_e = 6378.1e3; %earth equatorial radius [m]
re_p = 6356.8e3; %earth polar radius [m]
re_m = 6371.2e3; % Earth's mean radius [m]
T_e = 86400; % earth period (1 day) [s]
w_e = 2*pi/T_e; %angular velocity [rad/s]
h_o = 300e3; %height above sea level [m]

%% Satellite and orbit properties

dim=[0.10,0.10,0.10]; %length,width,height[m]
m_s=2.0;%mass[kg]
r_o = re_m + h_o; %orbit radius [m]
w_0 = sqrt(mu/(r_o^3)); %angular velocity [rad/s]
T_o = 2*pi/w_0; %Orbit period [s]
N = 2; %Number of orbits
T_t = T_o*N; %Total time [s]

fprintf("######Spacecraft specifications######\n");
fprintf("# -> Altitude: %d km\n",h_o/1000);
fprintf("# -> Dimensions: %dx%dx%d cm (LxWxH)\n",dim(1)*100,dim(2)*100,dim(3)*100);
fprintf("# -> Mass: %d kg\n", m_s);
fprintf("# -> Orbit radius: %d km\n", round(r_o/1000));
fprintf("# -> Angular velocity: %.4f rad/s\n", w_0);
minutes = round(T_o/60);
hours = floor(minutes/60);
minutes = minutes - 60*hours;
seconds = round(T_o - 3600*hours-60*minutes);
fprintf("# -> Orbit period: %d s / %dh%dm%ds\n", round(T_o), hours, minutes, seconds);
fprintf("#####################################\n\n");

%% Inertia tensor

I_x=m_s/12*(dim(2)^2+dim(3)^2);
I_y=m_s/12*(dim(1)^2+dim(3)^2);
I_z=m_s/12*(dim(1)^2+dim(2)^2);
I=diag([I_x,I_y,I_z]); %Matrix of intertia

%% Magnetorquers properties

%i_max = 0.06; %Maximum current [A]
N_x = 258; %Number of windings
N_y = 144; %Number of windings
N_z = 144; %Number of windings
A_x = 60*10*10^-6; %mean Coil area [m^2]
A_y = 60*10*10^-6; %mean Coil area [m^2]
A_z = 90^2*10^-6; %mean Coil area [m^2]
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

%% Initial attitude and velocity

%angular velocity inertial to orbit
w_o_io = [0,w_0,0]';
%initial angular velocity orbit to body
w0 = [0,0,0]';
%initial attitude orbit to body
euler_0_deg = [90 90 90];
euler_0 = pi/180*euler_0_deg;
q_0 = euler2quat(euler_0)';
%initial rotation matrix, orbit to body
R_o_b = Rquat(q_0);
%initial angular velocity, orbit to inertial
w_o_ib = R_o_b*w_o_io;
%initial angular velocity, body to inertial
w_b_ib_0 = w0 + w_o_ib;

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
v0 = 2*pi*r_o/T_o;

%% Residual magnetic moment
m_dipoleDist =  [0.0001; -0.0001; 0.0005]';

%% Reaction wheels

omega_w_0 = [0,0,0]';
h_0=[0,0,0]';
tau_w=1;
wheels_config=orthogonal_config;
W=wheels_config.distr_matrix;
h_w_max=0.03;

fprintf("###########Reaction wheels###########\n");
fprintf("# -> Wheels configuration: %s\n", wheels_config.name);
fprintf("# -> Number of wheels: %d\n", size(wheels_config.distr_matrix,2));
fprintf("#####################################\n\n");

%% Linearized dynamics

%Equilibrium
g_chap=[0 0 0];
q4_chap=sqrt(1-norm(g_chap)^2);
q_chap=[g_chap q4_chap];
euler_chap=quat2euler(q_chap);
w_chap=[0 0 0];
h_chap=[0.01 0.01 0.01]; %non-linearity at 0

fprintf("############Initial state############\n")
fprintf("# -> Initial orientation: phi=%d°, theta=%d°, psi=%d°\n", euler_0_deg(1), euler_0_deg(2), euler_0_deg(3));
fprintf("#####################################\n\n");

fprintf("#############Equilibrium#############\n")
fprintf("# -> Attitude equilibrium: phi=%d°, theta=%d°, psi=%d°\n", euler_chap(1), euler_chap(2), euler_chap(3));
fprintf("# -> Angular speed equilibrium: [%.2f,%.2f,%.2f]\n", w_chap(1), w_chap(2), w_chap(3));
fprintf("# -> Wheels angular momentum equilibrium: [%.2f,%.2f,%.2f]\n", h_chap(1), h_chap(2), h_chap(3));
fprintf("#####################################\n\n");

%% Dipole model parameters

T = round(T_o);
u_f=7.9*10^15; %dipole strength mu_f
i_m = (90-11)*pi/180;
i_0 = 11*pi/180;
t=1;

b_o_avg_dipole_model;
%plot_igrf_magnetic_field();

b_b_avg=R_o_b*b_o_avg;

%% State space

%[A,B,C,D]=state_space(g_chap, w_chap, h_chap, b_b_avg);
%[A,B,C,D]=state_space_2(g_chap, w_chap, b_b_avg);
[A,B,C,D]=state_space_wheels_only(g_chap, w_chap, h_chap);
G=ss(A,B,C,D);

%% Attitude control

%LQR with constant gain

Tc=0.2;
Gc=gramt(A,B,Tc);
Q=1/Tc*inv(Gc);
R=eye(size(B,2));
K=lqr(A,B,Q,R);
regulator_type="LQR";
fprintf("###############Control###############\n")
fprintf("# -> Regulator type: %s\n", regulator_type);
fprintf("# -> Control horizon: %.2f s\n", Tc);
fprintf("#####################################\n\n");


%LQI with constant gain

% Aa=[A zeros(size(A,1),size(C,1));-C zeros(size(C))]; %12x12
% Ba=[B;zeros(size(C,1),size(B,2))]; %12x6
% Tc=0.2;
% 
% Ri=eye(3);
% %Gc=gramt(Aa,Ba,Tc);
% %Qi=1/Tc*inv(Gc);
% %integrand = @(tau) expm(Aa*tau)*Ba*Ba'*expm(Aa'*tau);           % Integrand
% %gram = @(t) integral(integrand, 0, t, 'ArrayValued',1);        % Controllability Gramian
% %Gc = gram(Tc);
% %Qi=1/Tc.*inv(Gc);
% Qi=20*eye(size(A,1)+size(C,1));
% %Qi=diag([100000,100000,100000,100000,100000,100000,10,10,10,10,10,10])
% Ni=zeros(size(A,1)+size(C,1),3);
% heig=eig([Qi Ni;Ni' Ri]);
% posdef=all(heig >= 0)
% 
% [Ktot,S,E]=lqi(G,Qi,Ri,Ni);
% Kr=Ktot(:,1:6);
% Ki=Ktot(:,7:end);

%Optimal state estimator (Kalman filter)

Cobs=eye(6);
Ts=4e-4;
n=4e-2;
%Choix 1 : De Larminat
% To=100;
% Go=gramt(A',Cobs',To);
% Robs=1/To*inv(Go);
% Qobs=eye(6);

%Choix 2
sigma=1e-4;
Robs=sigma*(Cobs)'*Cobs;
Qobs=eye(6);

fprintf("Model set up successfully!\n");

