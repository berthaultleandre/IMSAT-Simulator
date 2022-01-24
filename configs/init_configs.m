global all_general_configs all_attitude_configs

def_generalconfig_name='Default';
def_spacecraft_name='Default';
def_actuators=containers.Map;
def_actuators('name')='Reaction wheels';
def_actuators('parameters')=struct('number_of_wheels',4,'wheels_config','Orthogonal');
def_cond0_name='ISS';
def_attitude_wchap=[0;0;0]; %spacecraft weight
def_attitude_hchap=[.0005;.0005;.0005]; %spacecraft weight
def_anim_animation_speed=8; %animation speed
def_anim_spacecraft_size=2; %spacecraft size
def_anim_arrow_len=1; %length of frames' arrows
def_anim_line_len=5; %length of satellite's frame lines
def_anim_axis_limit_ratio=1.2; %axis length (number of orbit radius)
def_r_ratio=30; %earth-to-satellite distance scale for animation
def_anim_save_video=false; %if true, saves animation as video
def_anim_video_name='demo.avi'; %video name
def_anim_video_format='Uncompressed AVI'; %video format
def_anim_video_frame_rate=10; %video frame rate

general_config_default=struct('name',def_generalconfig_name,...
    'spacecraft_name',def_spacecraft_name,...
    'actuators',def_actuators,...
    'cond0_name',def_cond0_name,...
    'attitude_wchap',def_attitude_wchap,...
    'attitude_hchap',def_attitude_hchap,...
    'anim_animation_speed',def_anim_animation_speed,...
    'anim_spacecraft_size',def_anim_spacecraft_size,...
    'anim_arrow_len',def_anim_arrow_len,...
    'anim_line_len',def_anim_line_len,...
    'anim_axis_limit_ratio',def_anim_axis_limit_ratio,...
    'r_ratio',def_r_ratio,...
    'anim_save_video',def_anim_save_video,...
    'anim_video_name',def_anim_video_name,...
    'anim_video_format',def_anim_video_format,...
    'anim_video_frame_rate',def_anim_video_frame_rate);

all_general_configs=containers.Map;
all_general_configs('Default')=general_config_default;

if exist('configs/general_configs.mat', 'file') ~= 2
    configs=all_general_configs;
    save('configs/general_configs.mat','configs')
end
general_configs_file=load('configs/general_configs.mat');
all_general_configs=general_configs_file.configs;

%%%%

def_attitudeconfig_name='Default';
def_conditions=containers.Map;
def_scenario=containers.Map;

attitude_config_default=struct('name',def_attitudeconfig_name,...
    'conditions',def_conditions,...
    'scenario',def_scenario);

all_attitude_configs=containers.Map;
all_attitude_configs('Default')=attitude_config_default;

if exist('configs/attitude_configs.mat', 'file') ~= 2
    configs=all_attitude_configs;
    save('configs/attitude_configs.mat','configs')
end
attitude_configs_file=load('configs/attitude_configs.mat');
all_attitude_configs=attitude_configs_file.configs;