%Main window
width=800;
height=800;

h.fig=figure('Position', [200 100 width height]);

h.main_tabgp = uitabgroup(h.fig,'Position',[0 0 1 1]);
h.main_tab1 = uitab(h.main_tabgp,'Title','General');
h.main_tab2 = uitab(h.main_tabgp,'Title','Attitude');
h.main_tab3 = uitab(h.main_tabgp,'Title','Simulation');
h.main_tab4 = uitab(h.main_tabgp,'Title','Animation');
h.main_tab4.Parent=[];

%% Tab 1 : General
tab_1_general

%% Tab 2 : Attitude
tab_2_attitude

%% Tab 3 : Simulation
tab_3_simulation

%% Tab 4 : Animation
tab_4_animation

%% Callbacks
callbacks