%% Header
global re_m h_o;

load igrf11-300km.mat
load b_o_avg_dipole_model.mat
wheel_configurations
bases

fprintf("Setting up model...\n\n")

%% Initial attitude and velocity

%angular velocity inertial to orbit
w_o_io = [0;w_0;0];
%initial attitude orbit to body
euler_o_b_0 = pi/180*eul_o_b_0_deg;
q_0 = euler2quat(euler_o_b_0)';
%initial rotation matrix, orbit to body
R_o_b = Rquat(q_0);
%initial angular velocity, orbit to inertial
w_o_ib = R_o_b*w_o_io;
%initial angular velocity, body to inertial
w_b_ib_0 = w_o_b_0 + w_o_ib;
%Calculates average earth magnetic field in orbital frame
b_o_avg_dipole_model;
%Average earth magnetic field in body frame
b_b_avg=R_o_b*b_o_avg;

%% Orbit
r_ratio=30;
k=h_o/re_m*r_ratio;
r_s=1+k;

face_i=[0;-1;0];
v_dir0=[-1;0;0];
v_dir=v_dir0;

r_data=[r_s];
phi_data=[0];
theta_data=[pi/2];
center_data=[];
Rio_data=[];

step=1;    
dphidt=0.04;
dthetadt=-0.02;
step_time=1;
for t=0:step_time:sim_time
    if (step > 1)
        % Compute new spherical coordinates
        r_data(step)=r_s;
        phi_data(step)=0;
        phi_data(step)=phi_data(step-1)+dphidt*step_time;
        theta_data(step)=pi/2;
        theta_data(step)=theta_data(step-1)+dthetadt*step_time;
    end

    % Compute spacecraft's new origin
    [x,y,z]=sph2cart(r_data(step),phi_data(step),theta_data(step));
    center=[x;y;z];
    center_data(:,step)=center;

    % Compute current speed direction in inertial frame
    if (step>1)
        v_dir=center_data(:,step)-center_data(:,step-1);
    end

    % Compute inertial to orbital rotation
    Rio=roti2o(v_dir);
    Rio_data(:,:,step)=Rio;
    step=step+1;
end


% Save data used by start_anim
save('sim_data/r.mat','r_data');
save('sim_data/phi.mat','phi_data');
save('sim_data/theta.mat','theta_data');
save('sim_data/center.mat','center_data');
save('sim_data/Rio.mat','Rio_data');

fprintf("Computing LQR variable gain... ")

%% Attitude control (LQR)

lineLength=fprintf("0%%");

K_data=[];
g_chap_data=[];
step=1;
per=-1; % percentage to display
sample_time=step_time;
for t=0:sample_time:sim_time

    % Display percentage
    new_per=floor(t/sim_time*100);
    if (new_per~=per)
        per=new_per;
        fprintf(repmat('\b',1,lineLength))
        lineLength=fprintf("%d%%\n",per);
    end

    % Attitude control scenario
    face_o=Rio_data(:,:,step)*face_i;
    center=center_data(:,step);
    
    if (t<sim_time/3)
       % Rob_chap=point_nadir(face_o,center)';
    elseif(t<sim_time*2/3)
        %Rob_chap=point_base(face_o,center,base_A)';
    else
        %Rob_chap=point_base(face_o,center,base_B)';
    end
    Rob_chap=point_nadir();
    % Compute new attitude reference
    q_chap=rotm2quat(Rob_chap);
    g_chap=q_chap(1:3)';

    % Compute new state space system
    [A,B,C,D]=state_space_wheels_only(q_chap, w_chap, h_chap, I, w_0);

    % Compute new LQR gain
    Gc=gramt(A,B,Tc);
    Q=1/Tc*inv(Gc);
    R=eye(size(B,2));
    nj=size(A,1);
    K_lqr=lqr(A,B,Q,R);

    % Save data
    g_chap_data(:,step)=g_chap;
    K_data(:,(step-1)*nj+1:step*nj)=K_lqr;

    step=step+1;
end
fprintf(repmat('\b',1,lineLength))
fprintf("100%%\n\n")

% Save data used by Simulink model
save('sim_data/K.mat','K_data');
save('sim_data/g_chap.mat','g_chap_data');

fprintf("Model set up successfully!\n\n");

% Start Simulink model
fprintf("Starting simulation...\n\n");
%sim('spacecraft_model')

