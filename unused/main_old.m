%% Header

%Find all open Simulink scopes and return
%their handles to an array called hScopeFig.
hScopeFig = findall(0,'Type','Figure','Tag','SIMULINK_SIMSCOPE_FIGURE');
%Set the renderer for all open scopes to painters.
set(hScopeFig,'Render','painters');
%Turn off the Scople/Zbuffer warnings.
warning('off','Simulink:SL_ScopeRendererNotZBuffer');

% TURN OFF ALL WARNINGS
warning('off','all')

close all;
clear all;
clc;

global I u_f r_o i_m w_0 T_o i_0 h_w_max re_m h_o sim_time step_time;

load igrf11-300km.mat
load b_o_avg_dipole_model.mat
wheels_configurations
bases

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
m_s=1.0;%mass[kg]
r_o = re_m + h_o; %orbit radius [m]
w_0 = sqrt(mu/(r_o^3)); %angular velocity [rad/s]
T_o = 2*pi/w_0; %Orbit period [s]
N = 2; %Number of orbits
T_t = T_o*N; %Total time [s]

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
euler_0 = pi/180*[90 90 90];
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

%% Linearized dynamics

% Constant equilibriums
w_chap=[0 0 0];
h_chap=[0.01 0.01 0.01]; %non-linearity at 0

%% Dipole model parameters

T = round(T_o);
u_f=7.9*10^15; %dipole strength mu_f
i_m = (90-11)*pi/180;
i_0 = 11*pi/180;
t=1;

b_o_avg_dipole_model;
%plot_igrf_magnetic_field();

b_b_avg=R_o_b*b_o_avg;

%% Orbit

sim_time=60;
step_time=0.1;

r_ratio=30;
k=h_o/re_m*r_ratio;
r_s=1+k;

r_data=[r_s];
phi_data=[0];
theta_data=[pi/2];
step=2;    
dphidt=0.04;
dthetadt=-0.02;
%{
y=ode45
for i=...
        [r,phi,theta]=func(y(i));
end
%}
for t=0:step_time:sim_time
    % Compute new spherical coordinates
    r_data(step)=r_s;
    phi_data(step)=0;
    phi_data(step)=phi_data(step-1)+dphidt*step_time;
    theta_data(step)=pi/2;
    theta_data(step)=theta_data(step-1)+dthetadt*step_time;
    step=step+1;
end
save('sim_data/phi.mat','phi_data');
save('sim_data/theta.mat','theta_data');

fprintf("Computing LQR variable gain... ")

%% Attitude control (LQR)

lqr_step=1; % compute LQR gain every 'lqr_step' steps
Tc=0.2;
face_i=[0;-1;0];
per=-1; % percentage to display
lineLength=fprintf("0%%");
sample_time=step_time*lqr_step;
center_data=[];
Rio_data=[];
v_dir0=[-1;0;0];
v_dir=v_dir0;
K_data=[];
g_chap_data=[];
step=1;
for t=0:sample_time:sim_time
    
    % Display percentage
    new_per=floor(t/sim_time*100);
    if (new_per~=per)
        per=new_per;
        fprintf(repmat('\b',1,lineLength))
        lineLength=fprintf("%d%%\n",per);
    end
    
    % Compute spacecraft's new origin
    [x,y,z]=sph2cart(r_data(step),phi_data(step),theta_data(step));
    center=[x;y;z];
    center_data(:,step)=center;
    
    % Compute current speed direction in inertial frame
    if (step>1)
        v_dir=center-center_data(:,step-1);
    end
 
    % Compute inertial to orbital rotation
    Rio=roti2o([1;0;0],v_dir);
    face_o=Rio*face_i;
    
    % Attitude control
    if (t<sim_time/3)
        Rob_chap=point_nadir(face_o,center)';
    elseif(t<sim_time*2/3)
        Rob_chap=point_base(face_o,center,base_A)';
    else
        Rob_chap=point_base(face_o,center,base_B)';
    end

    % Compute new attitude reference
    q_chap=rotm2quat(Rob_chap);
    g_chap=q_chap(1:3)';
    
    % Compute new state space system
    [A,B,C,D]=state_space_wheels_only(g_chap, w_chap, h_chap, I, w_0);
    
    % Compute new LQR gain
    Gc=gramt(A,B,Tc);
    Q=1/Tc*inv(Gc);
    R=eye(size(B,2));
    nj=size(A,1);
    K_lqr=lqr(A,B,Q,R);
    
    % Save data
    Rio_data(:,:,step)=Rio;
    g_chap_data(:,step)=g_chap;
    K_data(:,(step-1)*nj+1:step*nj)=K_lqr;
    
    step=step+1;
end
fprintf(repmat('\b',1,lineLength))
fprintf("100%%\n\n")

% Save data used by start_anim
save('sim_data/center.mat','center_data');
save('sim_data/Rio.mat','Rio_data');

fprintf("Model set up successfully!\n\n");

% Start Simulink model
fprintf("Starting simulation...\n\n");
sim('spacecraft_model')
fprintf("Simulation ended!\n\n");

