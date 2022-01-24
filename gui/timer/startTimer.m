function startTimer(h,restart)    
    global timer_step last_timer_step
    if (~restart)
        last_timer_step=1;
        timer_step=1;
    end
    config=load('anim_config.mat');
    data=load('anim_data.mat');

    fig=h.fig;
    handles=guidata(fig);
    handles.timer = timer('Name','MyTimer',               ...
                            'Period',0.001,                    ... 
                            'StartDelay',0,                 ... 
                            'TasksToExecute',inf,           ... 
                            'ExecutionMode','fixedSpacing', ...
                            'TimerFcn',{@TimerStep,h}); 
    guidata(fig,handles);
    tic;
    start(handles.timer);
end

function TimerStep(src,event,h)
    global w_e_deg last_timer_step timer_step center spacecraft arrows arrows2 lines lines2 earth bases_plt;
    bases
    
    config=load('anim_config.mat');
    data=load('anim_data.mat');
    
    n_data=length(data.times);
    
    if (timer_step==n_data)
        stopTimer(src,h);
        return;
    end
    
    t=data.times(timer_step);
    last_t=data.times(last_timer_step);
    title({'IMSAT Simulator',['t=',num2str(t),'s']})
    
    %Delete previously drawn spacecraft, arrows and lines
    if (timer_step>1)
        nextStep();
        old_center=center;
        dt=t-last_t;
    else
        firstStep();
        dt=t-0;
    end
   
    rotate(earth,[0 0 1], w_e_deg*dt);
    %Draw ECEF frame
    [arrows2,lines2]=draw_frame([0;0;0],Rzyx(0,0,-pi/180*w_e_deg*t),config.anim_arrow_len, config.anim_line_len);

    %% Draw bases
    bases_plt=[];
    bas=all_bases.values;
    for i=1:length(bas)
        [plt,txt]=draw_base(bas{1,i},t);
        hold on
        bases_plt=[bases_plt plt txt];
    end
    
    %Gather next data
    center=data.centers(:,timer_step);
    if (timer_step==1)
        old_center=center;
    end
    Rib=data.Ribs(:,3*timer_step-2:3*timer_step);
    S=data.Ss(:,3*timer_step-2:3*timer_step);
    
    %Display new elements
    spacecraft=draw_spacecraft(S);
    [arrows,lines]=draw_frame(center, Rib, config.anim_arrow_len, config.anim_line_len);
    
    v=plot3([old_center(1), center(1)],...
    [old_center(2), center(2)],...
    [old_center(3), center(3)],'m'); %display travelled distance
    v.LineWidth=2;
    
    if (config.anim_save_video)
        frame=getframe(gcf);
        writeVideo(h.video, frame);
    end
    
    pause_time=-1;
    i=0;
    while pause_time<0
        i=i+1;
        dt=data.times(timer_step+i)-data.times(timer_step);
        delay=toc;
        pause_time=dt-delay;
    end
    last_timer_step=timer_step;
    timer_step=min(timer_step+i,n_data);
    pause_time=pause_time/config.anim_animation_speed;
    pause(pause_time);
    tic
    
end

function nextStep()
    global spacecraft arrows lines bases_plt arrows2 lines2;
    delete(spacecraft)
    delete(arrows)
    delete(lines)
    delete(arrows2)
    delete(lines2)
    delete(bases_plt)
end

function firstStep()
    global earth;
    load 'anim/anim_config.mat'
    load sim/sim_data.mat
    load sim/R_data.mat
    bases
    %% Initial state
    origin=center_data(:,1);
    center=origin;

    %Draw Earth
    earth=draw_earth_spherical();
    hold on
    %Draw ECI frame
    draw_frame([0;0;0],eye(3),anim_arrow_len, anim_line_len);
    hold on
    %Draw orbit line
    step=1;
    for t=t_data'
        old_center=center;
        center=center_data(:,step);
        w=plot3([old_center(1), center(1)],...
        [old_center(2), center(2)],...
        [old_center(3), center(3)],'c');
        step=step+1;
    end

    %% Axis
    %Labels
    xlabel('x') 
    ylabel('y') 
    zlabel('z') 

    %Limits
    lim=anim_axis_limit_ratio*norm(origin);
    Lim=[-lim lim];
    xlim(Lim)
    ylim(Lim)
    zlim(Lim)
end