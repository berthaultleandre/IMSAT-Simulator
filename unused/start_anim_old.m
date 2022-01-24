global re_m h_o sim_time step_time;

bases
load sim_data/phi.mat
load sim_data/theta.mat
load sim_data/center.mat
load sim_data/Rio.mat

%set(gca,'color',[0.3 0.2 0.8])

%% Initial state
r_ratio=30;
dim_ratio=2;
k=h_o/re_m*r_ratio;
dim=[0.10,0.10,0.10];
dim=dim*dim_ratio;

r_s=1+k;
phi=0;
theta=pi/2;
[x_s,y_s,z_s]=sph2cart(r_s, phi, theta);
[lat,lon]=sph2latlon(phi,theta);
origin=[x_s;y_s;z_s];
center=origin;

%% Axis
lim=1.2*r_s;
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
S = create_spacecraft(center, R, dim);
draw_earth()
hold on

spacecraft=plot3(S(:,1),S(:,2),S(:,3));
[arrows,lines]=draw_frame(center, R, arrow_len, line_len);

hold on

%% Bases

draw_base(base_A)
hold on
draw_base(base_B)
hold on

%% Loop

%Inertial frame
draw_frame([0;0;0], eye(3), arrow_len, line_len);

step=1;
n_data=length(R_data.Time);

for t=0:step_time:sim_time
    step=floor(t/step_time)+1;
    old_center=center;
    center=center_data(:,step);
    w=plot3([old_center(1), center(1)],...
    [old_center(2), center(2)],...
    [old_center(3), center(3)],'c');
end

center=origin;
v=plot3([0 0],[0 0],[0 0],'m');

for k=1:n_data-1
    t=R_data.Time(k);
    step=floor(t/step_time)+1;
    tic
    
    %Delete previously drawn spacecraft, arrows and lines
    delete(spacecraft)
    delete(arrows)
    delete(lines)
    
    %Compute new state (=orbit model)
    phi = phi_data(step);
    theta = theta_data(step);

    Rob=R_data.Data(:,:,k);
    old_center=center;
    center=center_data(:,step);

    v=plot3([old_center(1), center(1)],...
        [old_center(2), center(2)],...
        [old_center(3), center(3)],'m');
    v.LineWidth=2;
    
    %Spacecraft attitude
    Rio=Rio_data(:,:,step);
    Rib=Rob*Rio;

    %Display
    S = create_spacecraft(center, Rib, dim);
    spacecraft=plot3(S(:,1),S(:,2),S(:,3));
    [arrows,lines]=draw_frame(center, Rib, arrow_len, line_len);
    
    if (k<n_data)
        next_t=R_data.Time(k+1);
    end
    calc_time=toc;
    pause_time=next_t-t-calc_time;
    %pause(pause_time);
    pause(0.001);
end

