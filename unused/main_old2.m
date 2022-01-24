%% Header
%Find all open Simulink scopes and return
%their handles to an array called hScopeFig.
hScopeFig = findall(0,'Type','Figure','Tag','SIMULINK_SIMSCOPE_FIGURE');
%Set the renderer for all open scopes to painters.
set(hScopeFig,'Render','painters');
%Turn off the Scople/Zbuffer warnings.
warning('off','Simulink:SL_ScopeRendererNotZBuffer')
% Turn off all warnings
warning('off','all')

close all
clear variables
clc

%% Imports
constants %all model constants
spacecrafts
initial_conditions_sets


%% Simulation parameters
sim_time=600; %simulation time [s]

%% Orbit parameters
tol = 1e-10; %tolerance for orbit calculus

%% Control parameters
w_chap=[0;0;0]; %angular velocity equilibrium [rad/s]
h_chap=[.0005;.0005;.0005]; %wheels angular momentum equilibrium [kg*m2/s]
Tc=0.2; %control horizon [s]

%% Spacecraft
spacecraft=spacecraft_default;
cond0=cond0_ISS;
calc_spacecraft

%% Animation parameters
anim_animation_speed=8; %animation speed
anim_spacecraft_size=2; %spacecraft size
anim_arrow_len=1; %length of frames' arrows
anim_line_len=5; %length of satellite's frame lines
anim_axis_limit_ratio=1.2; %axis length (number of orbit radius)
anim_save_video=true; %if true, saves animation as video
anim_video_name='demo.avi'; %video name
%anim_video_format='Uncompressed AVI'; %video format
anim_video_frame_rate=10; %video frame rate
r_ratio=30; %earth-to-satellite distance scale for animation

%% Start simulation
start_simulation