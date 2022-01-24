%% Header
global all_wheels_configs current_conditions current_scenario all_spacecrafts all_cond0;
global re_m h_o S r_o;

%% Imports
load igrf11-300km.mat
load b_o_avg_dipole_model.mat
bases
constants
spacecrafts
initial_conditions_sets

%% Display init
fprintf("Setting up model...\n\n")

%% Gather GUI Data
general_config=GetGeneralConfigFromGUI('',h);
spacecraft_name=general_config.spacecraft_name;
cond0_name=general_config.cond0_name;
anim_animation_speed=general_config.anim_animation_speed;
anim_spacecraft_size=general_config.anim_spacecraft_size;
anim_arrow_len=general_config.anim_arrow_len;
anim_line_len=general_config.anim_line_len;
anim_axis_limit_ratio=general_config.anim_axis_limit_ratio;
r_ratio=general_config.r_ratio;
anim_save_video=general_config.anim_save_video;

sim_time=str2double(h.ed_simtime.String);   

save('anim/anim_config.mat','anim_animation_speed','anim_spacecraft_size',...
'anim_arrow_len','anim_line_len','anim_axis_limit_ratio','r_ratio',...
'anim_save_video');

if (anim_save_video)
    anim_video_name=general_config.anim_video_name;
    anim_video_format=general_config.anim_video_format;
    anim_video_frame_rate=general_config.anim_video_frame_rate;
    
    save('anim/anim_config.mat','anim_video_name','anim_video_format',...
         'anim_video_frame_rate','-append');
end

spacecraft=all_spacecrafts(spacecraft_name);
cond0=all_cond0(cond0_name);

%% Orbit parameters
tol = 1e-10; %tolerance for orbit calculus

%% Reaction wheels
actuators=general_config.actuators;
name=actuators('name');
if strcmp(name,'Reaction wheels') || strcmp(name,'Mix')
    parameters=actuators('parameters');
    omega_w_0 = [0,0,0]';
    h_0=[0,0,0]';
    tau_w=1;
    num_wheels=parameters.number_of_wheels;
    wheels_config=all_wheels_configs(parameters.wheels_config);
    W=wheels_config.distr_matrix;
    h_w_max=0.03;
end

%% Control parameters
w_chap=[str2double(h.ed_attitudewchapx.String);...
    str2double(h.ed_attitudewchapy.String);...
    str2double(h.ed_attitudewchapz.String)]; %angular velocity equilibrium [rad/s]
h_chap=[str2double(h.ed_attitudehchapx.String);...
    str2double(h.ed_attitudehchapy.String);...
    str2double(h.ed_attitudehchapz.String)]; %wheels angular momentum equilibrium [kg*m2/s]
Tc=0.2; %control horizon [s]

%% Satellite and orbit properties
eul_o_b_0_deg = cond0.eul_o_b_0_deg;
w_o_b_0=cond0.w_o_b_0;
r_eci_0=cond0.r_eci_0;
v_eci_0=cond0.v_eci_0;

h_o = norm(r_eci_0)-re_m; %height above sea level [m]
dim=spacecraft.dim; %length,width,height[m]
S = dim(1)*dim(2); %m2
m_s=spacecraft.m;%mass[kg]
r_o = re_m + h_o; %orbit radius [m]
w_0 = sqrt(mu/(r_o^3)); %angular velocity [rad/s]
T_o = 2*pi/w_0; %Orbit period [s]
N = 2; %Number of orbits
T_t = T_o*N; %Total time [s]
v0 = 2*pi*r_o/T_o;
T = round(T_o);



%% Inertia tensor
I_x=m_s/12*(dim(2)^2+dim(3)^2);
I_y=m_s/12*(dim(1)^2+dim(3)^2);
I_z=m_s/12*(dim(1)^2+dim(2)^2);
I=diag([I_x,I_y,I_z]); %Matrix of intertia

%% Initial attitude and velocity
w_o_io=[0;w_0;0]; %angular velocity inertial to orbit
euler_o_b_0=pi/180*eul_o_b_0_deg; %initial angles orbit to body [rad]
q_0=euler2quat(euler_o_b_0)'; %initial attitude orbit to body
R_o_b=Rquat(q_0); %initial rotation matrix orbit to body
w_o_ib=R_o_b*w_o_io; %initial angular velocity orbit to body [rad]
w_b_ib_0=w_o_b_0+w_o_ib; %initial angular velocity body to inertial [rad]

%% Earth magnetic field
%Calculates average earth magnetic field in orbital frame
b_o_avg_dipole_model;

b_b_avg=R_o_b*b_o_avg; %average earth magnetic field in body frame

%% Orbit
k=h_o/re_m*r_ratio; %spacecraft altitude with rescaling
r_s=1+k; %spacecraft orbit radius with rescaling

tspan=[0 sim_time]; %simulation time span

y0=[r_eci_0' v_eci_0']; %initial conditions set, position and velocity

[t_data,r_data,v_data]=get_orbit(tspan,y0,tol); %calculates orbit
n_data=length(t_data);

%Calculate orbital data
center_data=zeros(3,n_data); %animation positions
Rio_data=zeros(3,3,n_data); %rotation matrices inertial to orbit
phi_data=zeros(1,n_data); %phi angles inertial to orbit
theta_data=zeros(1,n_data); %theta angles inertial to orbit

step=1;  
for t=t_data'
    r_i=r_data(:,step);
    n=norm(r_i);
    k=n/re_m;
    center=r_i/n*(1+(k-1)*r_ratio);
    center_data(:,step)=center;
    theta=atan2(sqrt(center(1)^2+center(2)^2),center(3));
    phi=atan2(center(2),center(1));
    theta_data(1,step)=theta;
    phi_data(1,step)=phi;
    v_dir=v_data(:,step);
    Rio=roti2o_2(v_dir,center);
    Rio_data(:,:,step)=Rio;
    step=step+1;
end


%% Attitude control (LQR)

fprintf("Computing LQR variable gain... ")

per=0; %percentage to display
lineLength=fprintf("%d%%\n",per);

q_chap_data=zeros(4,length(t_data)); %attitude equilibriums
K_data=[]; %variable LQR gain

scenario=current_scenario;
scenario_keys=scenario.keys;
conditions=current_conditions;

step=1;
for t=t_data'
    while (step<=length(t_data) && t>t_data(step))
        step=step+1;
    end
    step=max(step-1,1);
    
    %Display percentage
    new_per=floor(t/sim_time*100);
    if (new_per~=per)
        per=new_per;
        fprintf(repmat('\b',1,lineLength))
        lineLength=fprintf("%d%%\n",per);
    end

    %Gather orbital data
    Rio=Rio_data(:,:,step);
    center=center_data(:,step);
    phi=phi_data(1,step);
    theta=theta_data(1,step);
    longitude=180/pi*phi;
    latitude=180-180/pi*theta;
    
    %Attitude control scenario
    for i=1:length(scenario_keys)
        element_tmp=scenario(int2str(i));
        condition_name1=element_tmp.Condition.Condition1;
        condition_name2=element_tmp.Condition.Condition2;
        condition_name3=element_tmp.Condition.Condition3;
        e1=~strcmp(condition_name1,' ');
        e2=~strcmp(condition_name2,' ');
        e3=~strcmp(condition_name3,' ');
        operator1=element_tmp.Condition.Operator1;
        operator2=element_tmp.Condition.Operator2;
        conditions_tmp=[];
        operators={};
        if e1
            condition1=conditions(condition_name1);
            conditions_tmp=[conditions_tmp condition1];
        end
        if e2
            condition2=conditions(condition_name2);
            conditions_tmp=[conditions_tmp condition2];
            if e1
                operators=horzcat(operators,operator1);
            end
        end
        if e3
            condition3=conditions(condition_name3);
                conditions_tmp=[conditions_tmp condition3];
            if e1 || e2
                operators=horzcat(operators,operator2);
            end
        end
        condition_check=true;
        for j=1:length(conditions_tmp)
            condition=conditions_tmp(j);
            if j==1
                operator=str2func('and');
            else
                operator=str2func(operators{j-1});
            end
            
            if strcmp(condition.Type,'Time')
                new_condition=condition.Function(t);
            elseif strcmp(condition.Type,'Latitude')
                new_condition=condition.Function(latitude);
            elseif strcmp(condition.Type,'Longitude')
                new_condition=condition.Function(longitude);
            end
            condition_check=operator(condition_check,new_condition);
        end
        if condition_check
            element=element_tmp;
            break;
        end
    end
    
    if strcmp(element.Law,'Base Pointing')
        base_name=element.Parameters.Base;
        base=all_bases(base_name);
        Rob_chap=point_base(base,center,Rio,t);
    elseif strcmp(element.Law,'Nadir Pointing')
        Rob_chap=point_nadir(center,Rio);
    end
    
    %Compute new attitude reference
    q_chap=rotm2quat(Rob_chap);

    %Compute new state space system
    %[A,B,C,D]=state_space_wheels_only(g_chap, w_chap, h_chap, I, w_0);
    [A,B,C,D]=state_space_wheels_only_2(q_chap, w_chap, h_chap, I, w_0);
    
    %Compute new LQR gain
    %Gc=gramt(A,B,Tc);
    %Q=1/Tc*inv(Gc);
    Q=eye(size(A,1))*0.001;
    R=eye(size(B,2));
    nj=size(A,1);
    K_lqr=lqr(A,B,Q,R);

    q_chap_data(:,step)=q_chap;
    K_data(:,(step-1)*nj+1:step*nj)=K_lqr;
end

%Display complete
fprintf(repmat('\b',1,lineLength))
fprintf("100%%\n\n")


%% Save data used by Simulink
save('sim/sim_data.mat','r_data','v_data','phi_data','theta_data',...
    'center_data','Rio_data','K_data','q_chap_data','t_data','w_b_ib_0',...
    'I','v0','K_data','q_0','t_data','h_chap','w_o_io','q_chap_data',...
    'w_chap','dim','W','h_0','omega_w_0','h_w_max');

%% Start Simulink model
fprintf("Model set up successfully!\n\n");
fprintf("Starting simulation...\n\n");


sim('spacecraft_model','StartTime','0','StopTime',num2str(sim_time));
