function anim_old()

    global re_m h_o;

    clc
    close all

    %set(gca,'color',[0.3 0.2 0.8])

    %% Initial state
    r_ratio=30;
    dim_ratio=2;
    k=h_o/re_m*r_ratio;
    dim=[0.10,0.10,0.10];
    dim=dim*dim_ratio;

    r=1+k;
    phi=0;
    theta=pi/2;
    [x_s,y_s,z_s]=sph2cart(r, phi, theta);
    [lat,lon]=sph2latlon(phi,theta);
    origin=[x_s;y_s;z_s];

    eul_b0=[0 0 0];
    q0=euler2quat(eul_b0);
    R=Rquat(q0);

    %% Bases

    %A
    phi_A=pi/2;
    theta_A=pi/2;
    [x_A,y_A,z_A]=sph2cart(1,phi_A,theta_A);
    A=[x_A;y_A;z_A];
    [lat_A,lon_A]=sph2latlon(phi_A,theta_A);
    draw_base(phi_A,theta_A,'A')
    hold on

    %B
    phi_B=1.5*pi;
    theta_B=3*pi/4;
    [x_B,y_B,z_B]=sph2cart(1,phi_B,theta_B);
    B=[x_B;y_B;z_B];
    [lat_B,lon_B]=sph2latlon(phi_B,theta_B);
    draw_base(phi_B,theta_B,'B')
    hold on

    %% Axis
    lim=1.2*(1+k);
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
    S = create_spacecraft(origin, R, dim);
    draw_earth()
    hold on

    spacecraft=plot3(S(:,1),S(:,2),S(:,3));
    [arrows,lines]=draw_frame(origin, R, arrow_len, line_len);

    hold on

    %% Loop
    center = origin;
    eul_b = eul_b0;
    q = q0;

    T=10e2;
    dt=0.02;

    for t=0:dt:T
        %Delete previously drawn spacecraft, arrows and lines
        delete(spacecraft)
        delete(arrows)
        delete(lines)

        %Compute new state (=orbit model)
        phi = phi + 0.01;
        theta = theta + 0.01;

        [x_s,y_s,z_s]=sph2cart(r, phi, theta);
        [lat,lon]=sph2latlon(phi,theta);
        center=[x_s;y_s;z_s];

        %Spacecraft attitude
        face=[0;1;0];
        R = point_base(face,center,B);
        %R = point_nadir(face,center);

        %Display
        S = create_spacecraft(center, R, dim);
        spacecraft=plot3(S(:,1),S(:,2),S(:,3));
        [arrows,lines]=draw_frame(center, R, arrow_len, line_len);

        pause(dt);
    end

    % rouge : x
    % vert : y
    % bleu : z

    %plot3(P(:,1),P(:,2),P(:,3), 'ro', 'MarkerSize', 5)
end

