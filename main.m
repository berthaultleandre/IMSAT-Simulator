%% Header
%Find all open Simulink scopes and return
%their handles to an array called hScopeFig.
%hScopeFig = findall(0,'Type','Figure','Tag','SIMULINK_SIMSCOPE_FIGURE');
%Set the renderer for all open scopes to painters.
%set(hScopeFig,'Render','painters');
%Turn off the Scople/Zbuffer warnings.
%warning('off','Simulink:SL_ScopeRendererNotZBuffer')
% Turn off all warnings
warning('off','all')

close all
clear variables
clc

%% Imports
constants
spacecrafts
initial_conditions_sets
init_configs
wheels_configurations
bases

%% GUI
app_gui;

