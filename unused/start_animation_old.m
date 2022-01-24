load sim_data/r.mat
load sim_data/phi.mat
load sim_data/theta.mat
load sim_data/center.mat
load sim_data/Rio.mat

bases

%set(gca,'color',[0.3 0.2 0.8])

fprintf("Simulation ended successfully!\n\n");
  
fprintf("Starting animation...\n\n");

%% Initial state
origin=center_data(:,1);
center=origin;

%% Axis
lim=1.2*r_data(1);
Lim=[-lim lim];
xlim(Lim)
ylim(Lim)
zlim(Lim)

xlabel('x') 
ylabel('y') 
zlabel('z') 

arrow_len=1;
line_len=5;

%% Display init
draw_earth_spherical()
hold on

%% Bases

draw_base(base_A)
hold on
draw_base(base_B)
hold on

%% Loop

%Inertial frame
draw_frame([0;0;0], eye(3), arrow_len, line_len);

n_data=length(R_data.Time);

step=1;
for t=0:step_time:sim_time
    step=floor(t/step_time)+1;
    old_center=center;
    center=center_data(:,step);
    w=plot3([old_center(1), center(1)],...
    [old_center(2), center(2)],...
    [old_center(3), center(3)],'c');
end
fprintf("1\n\n");
center=origin;
v=plot3([0 0],[0 0],[0 0],'m');

centers=zeros(3,n_data);
Ribs=zeros(3,3*n_data);
Ss=zeros(16,3*n_data);
for k=1:n_data
    t=R_data.Time(k);
    step=floor(t/step_time)+1;   
    
    %Compute new state (=orbit model)
    phi = phi_data(step);
    theta = theta_data(step);
    r = r_data(step);

    Rob=R_data.Data(:,:,k);
    old_center=center;
    center=center_data(:,step);
    centers(:,k)=center;
    
    %Spacecraft attitude
    Rio=Rio_data(:,:,step);
    Rib=Rob*Rio;
    Ribs(:,3*k-2:3*k)=Rib;
    
    S=create_spacecraft(center, Rib, dim*anim_spacecraft_size);
    Ss(:,3*k-2:3*k)=S;
end
fprintf("2\n\n");
center=origin;
lost_time=0;
for k=1:n_data
    tic
    t=R_data.Time(k);
    title({'IMSAT Simulator',['t=',num2str(t),'s']})
    
    %Delete previously drawn spacecraft, arrows and lines
    if (k>1)
        delete(spacecraft)
        delete(arrows)
        delete(lines)
    end
    
    %Gather next data
    old_center=center;
    center=centers(:,k);
    Rib=Ribs(:,3*k-2:3*k);
    S=Ss(:,3*k-2:3*k);
    
    %Display
    spacecraft=plot3(S(:,1),S(:,2),S(:,3));
    [arrows,lines]=draw_frame(center, Rib, arrow_len, line_len);
    v=plot3([old_center(1), center(1)],...
    [old_center(2), center(2)],...
    [old_center(3), center(3)],'m');
    v.LineWidth=2;
    
    if (k<n_data)
        next_t=R_data.Time(k+1);
    end
    
    calc_time=toc;
    pause_time=next_t-t-calc_time;
    if (pause_time<0)
        lost_time=lost_time-pause_time;
    else
        pause(pause_time/anim_animation_speed);
    end
end
fprintf("3\n\n");

