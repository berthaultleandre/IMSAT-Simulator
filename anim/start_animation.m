global earth;

%% Imports
load sim/sim_data.mat
load sim/R_data.mat
load anim/anim_config.mat
bases

%% Display init
fprintf("Simulation ended successfully!\n\n");
fprintf("Starting animation...\n\n");

%% Pre-process
n_data=length(R_data.Time); %number of samples from Simulink

centers=zeros(3,n_data); %spacecraft position (Simulink samples)
Ribs=zeros(3,3*n_data); %rotation matrix inertial to body (Simulink samples)
Ss=zeros(16,3*n_data); %spacecrafts (Simulink samples)

step=1;
for k=1:n_data
    t=R_data.Time(k);
    
    while (step<length(t_data) && t>t_data(step))
        step=step+1;
    end
    step=max(step-1,1);

    %Gather data
    center=center_data(:,step);
    Rio=Rio_data(:,:,step)';
    centers(:,k)=center;
    Rob=R_data.Data(:,:,k);
    
    %Calculate rotation matrix inertial to body
    Rib=Rob*Rio;
    Ribs(:,3*k-2:3*k)=Rib;
    
    %Pre-create spacecraft
    S=create_spacecraft(center, Rib, dim*anim_spacecraft_size);
    Ss(:,3*k-2:3*k)=S;
end

%% Animate

h=evalin('base', 'h');

if (anim_save_video)
    %video = VideoWriter(anim_video_name,anim_video_format);
    video = VideoWriter(anim_video_name);
    video.FrameRate = anim_video_frame_rate;
    video.Quality=90;
    h.video=video;
    open(video)
end

lost_frames=0;
%step_time=0.1;

times=R_data.Time;
save('anim/anim_data.mat','times','Ss','centers','Ribs')
h.btn_pause.Enable='on';
h.btn_stop.Enable='on';
startTimer(h,false);
