global all_spacecrafts all_cond0 all_general_configs

h.p1 = uipanel('Parent',h.main_tab1,'FontSize',12,...
              'Position',[0 0 1 1]);
       
%% Panel 0 : Config
h.p10 = uipanel('Parent',h.p1,'Title','Config','FontSize',10,...
              'Position',[0 0.9 1 0.1]);

h.txt_generalconfig=new_text(h.p10,'Config',[10 20 100 20]);
h.spn_generalconfig=new_spinner(h.p10,all_general_configs.keys,[0 0 100 20]);
rightof(h.spn_generalconfig,h.txt_generalconfig,5);

h.btn_updategeneralconfig=new_button(h.p10,'Update',[0 0 70 20]);
rightof(h.btn_updategeneralconfig,h.spn_generalconfig,10);

h.btn_deletegeneralconfig=new_button(h.p10,'Delete',[0 0 70 20]);
rightof(h.btn_deletegeneralconfig,h.btn_updategeneralconfig,10);

h.txt_creategeneralconfig=new_text(h.p10,'New config name',[0 0 100 20]);
rightof(h.txt_creategeneralconfig,h.btn_deletegeneralconfig,20);
h.ed_creategeneralconfig=new_edit(h.p10,'',[0 0 100 20]);
rightof(h.ed_creategeneralconfig,h.txt_creategeneralconfig,5);
h.btn_creategeneralconfig=new_button(h.p10,'Create',[0 0 70 20]);
rightof(h.btn_creategeneralconfig,h.ed_creategeneralconfig,5);

%% Panel 1 : Spacecraft

h.p11 = uipanel('Parent',h.p1,'Title','Spacecraft','FontSize',10,...
              'Position',[0 0.7 1 0.2]);
          
h.txt_spacecraft=new_text(h.p11,'Spacecraft',[10 100 100 20]);
h.spn_spacecraft=new_spinner(h.p11,all_spacecrafts.keys,[0 0 100 20]);
rightof(h.spn_spacecraft,h.txt_spacecraft,5);

h.txt_spacecraftdim=new_text(h.p11,'Dimensions (m)',[0 0 100 20]);
h.ed_spacecraftdimx=new_edit(h.p11,'',[0 0 30 20]);
h.ed_spacecraftdimy=new_edit(h.p11,'',[0 0 30 20]);
h.ed_spacecraftdimz=new_edit(h.p11,'',[0 0 30 20]);
rightof(h.txt_spacecraftdim,h.spn_spacecraft,5);
rightof(h.ed_spacecraftdimx,h.txt_spacecraftdim,5);
rightof(h.ed_spacecraftdimy,h.ed_spacecraftdimx,5);
rightof(h.ed_spacecraftdimz,h.ed_spacecraftdimy,5);
h.txt_spacecraftdim.Enable='off';
h.ed_spacecraftdimx.Enable='off';
h.ed_spacecraftdimy.Enable='off';
h.ed_spacecraftdimz.Enable='off';

h.txt_spacecraftweight=new_text(h.p11,'Weight (kg)',[0 0 100 20]);
h.ed_spacecraftweight=new_edit(h.p11,'',[0 0 100 20]);
rightof(h.txt_spacecraftweight,h.ed_spacecraftdimz,5);
rightof(h.ed_spacecraftweight,h.txt_spacecraftweight,5);
h.txt_spacecraftweight.Enable='off';
h.ed_spacecraftweight.Enable='off';

h.txt_actuators=new_text(h.p11,'Actuators',[0 0 100 20]);
h.spn_actuators=new_spinner(h.p11,{'Reaction wheels';'Magnetorquers';'Mix'},[0 0 120 20]);
under(h.txt_actuators,h.txt_spacecraft,10);
rightof(h.spn_actuators,h.txt_actuators,5);

%% Panel 2 : Initial conditions set
h.p12 = uipanel('Parent',h.p1,'Title','Initial conditions set','FontSize',10,...
              'Position',[0 0.5 1 0.2]);

h.txt_cond0=new_text(h.p12,'Initial conditions set',[10 100 100 20]);
h.spn_cond0=new_spinner(h.p12,all_cond0.keys,[0 0 100 20]);
rightof(h.spn_cond0,h.txt_cond0,5);

h.txt_cond0altitude=new_text(h.p12,'Initial altitude (km)',[0 0 100 20]);
h.ed_cond0altitude=new_edit(h.p12,'',[0 0 100 20]);
under(h.txt_cond0altitude,h.txt_cond0,20);
rightof(h.ed_cond0altitude,h.txt_cond0altitude,5);
h.txt_cond0altitude.Enable='off';
h.ed_cond0altitude.Enable='off';

h.txt_cond0reci0=new_text(h.p12,'Initial position (km)',[0 0 100 20]);
h.ed_cond0reci0x=new_edit(h.p12,'',[0 0 50 20]);
h.ed_cond0reci0y=new_edit(h.p12,'',[0 0 50 20]);
h.ed_cond0reci0z=new_edit(h.p12,'',[0 0 50 20]);
rightof(h.txt_cond0reci0,h.ed_cond0altitude,5);
rightof(h.ed_cond0reci0x,h.txt_cond0reci0,5);
rightof(h.ed_cond0reci0y,h.ed_cond0reci0x,5);
rightof(h.ed_cond0reci0z,h.ed_cond0reci0y,5);
h.txt_cond0reci0.Enable='off';
h.ed_cond0reci0x.Enable='off';
h.ed_cond0reci0y.Enable='off';
h.ed_cond0reci0z.Enable='off';

h.txt_cond0veci0=new_text(h.p12,'Initial linear velocity (km/s)',[0 0 100 40]);
h.ed_cond0veci0x=new_edit(h.p12,'',[0 0 50 20]);
h.ed_cond0veci0y=new_edit(h.p12,'',[0 0 50 20]);
h.ed_cond0veci0z=new_edit(h.p12,'',[0 0 50 20]);
rightof(h.txt_cond0veci0,h.ed_cond0reci0z,5);
rightof(h.ed_cond0veci0x,h.txt_cond0veci0,5);
rightof(h.ed_cond0veci0y,h.ed_cond0veci0x,5);
rightof(h.ed_cond0veci0z,h.ed_cond0veci0y,5);
h.txt_cond0veci0.Enable='off';
h.ed_cond0veci0x.Enable='off';
h.ed_cond0veci0y.Enable='off';
h.ed_cond0veci0z.Enable='off';

h.txt_cond0eulob0deg=new_text(h.p12,'Euler angles orbit to body (deg)',[0 0 100 40]);
h.ed_cond0eulob0degphi=new_edit(h.p12,'',[0 0 30 20]);
h.ed_cond0eulob0degtheta=new_edit(h.p12,'',[0 0 30 20]);
h.ed_cond0eulob0degpsi=new_edit(h.p12,'',[0 0 30 20]);
under(h.txt_cond0eulob0deg,h.txt_cond0altitude,10);
rightof(h.ed_cond0eulob0degphi,h.txt_cond0eulob0deg,5);
rightof(h.ed_cond0eulob0degtheta,h.ed_cond0eulob0degphi,5);
rightof(h.ed_cond0eulob0degpsi,h.ed_cond0eulob0degtheta,5);
h.txt_cond0eulob0deg.Enable='off';
h.ed_cond0eulob0degphi.Enable='off';
h.ed_cond0eulob0degtheta.Enable='off';
h.ed_cond0eulob0degpsi.Enable='off';

h.txt_cond0wob0=new_text(h.p12,'Angular velocity orbit to body (rad/s)',[0 0 100 40]);
h.ed_cond0wob0x=new_edit(h.p12,'',[0 0 30 20]);
h.ed_cond0wob0y=new_edit(h.p12,'',[0 0 30 20]);
h.ed_cond0wob0z=new_edit(h.p12,'',[0 0 30 20]);
rightof(h.txt_cond0wob0,h.ed_cond0eulob0degpsi,5);
rightof(h.ed_cond0wob0x,h.txt_cond0wob0,5);
rightof(h.ed_cond0wob0y,h.ed_cond0wob0x,5);
rightof(h.ed_cond0wob0z,h.ed_cond0wob0y,5);
h.txt_cond0wob0.Enable='off';
h.ed_cond0wob0x.Enable='off';
h.ed_cond0wob0y.Enable='off';
h.ed_cond0wob0z.Enable='off';

%% Panel 3 : Equilibrium

h.p13 = uipanel('Parent',h.p1,'Title','Equilibrium','FontSize',10,...
              'Position',[0 0.4 1 0.1]);
          
h.txt_attitudewchap=new_text(h.p13,'Equilibrium angular velocity orbit to body (rad/s)',[80 10 150 40]);
h.ed_attitudewchapx=new_edit(h.p13,'',[0 0 30 20]);
h.ed_attitudewchapy=new_edit(h.p13,'',[0 0 30 20]);
h.ed_attitudewchapz=new_edit(h.p13,'',[0 0 30 20]);
rightof(h.ed_attitudewchapx,h.txt_attitudewchap,5);
rightof(h.ed_attitudewchapy,h.ed_attitudewchapx,5);
rightof(h.ed_attitudewchapz,h.ed_attitudewchapy,5);

h.txt_attitudehchap=new_text(h.p13,'Equilibrium wheels angular momentum (kg.m2/s)',[0 100 150 40]);
h.ed_attitudehchapx=new_edit(h.p13,'',[0 0 50 20]);
h.ed_attitudehchapy=new_edit(h.p13,'',[0 0 50 20]);
h.ed_attitudehchapz=new_edit(h.p13,'',[0 0 50 20]);
rightof(h.txt_attitudehchap,h.ed_attitudewchapz,50);
rightof(h.ed_attitudehchapx,h.txt_attitudehchap,5);
rightof(h.ed_attitudehchapy,h.ed_attitudehchapx,5);
rightof(h.ed_attitudehchapz,h.ed_attitudehchapy,5);

%% Panel 4 : Animation config

h.p14 = uipanel('Parent',h.p1,'Title','Animation config','FontSize',10,...
              'Position',[0 0.1 1 0.3]);
          
h.txt_animspeed=new_text(h.p14,'Animation speed',[40 170 100 20]);
h.ed_animspeed=new_edit(h.p14,'',[0 0 100 20]);
rightof(h.ed_animspeed,h.txt_animspeed,5);

h.txt_spacecraftsize=new_text(h.p14,'Spacecraft size',[0 0 100 20]);
h.ed_spacecraftsize=new_edit(h.p14,'',[0 0 100 20]);
under(h.txt_spacecraftsize,h.txt_animspeed,5);
rightof(h.ed_spacecraftsize,h.txt_spacecraftsize,5);

h.txt_arrowlen=new_text(h.p14,'Arrow length',[0 0 100 20]);
h.ed_arrowlen=new_edit(h.p14,'',[0 0 100 20]);
under(h.txt_arrowlen,h.txt_spacecraftsize,5);
rightof(h.ed_arrowlen,h.txt_arrowlen,5);

h.txt_linelen=new_text(h.p14,'Line length',[0 0 100 20]);
h.ed_linelen=new_edit(h.p14,'',[0 0 100 20]);
under(h.txt_linelen,h.txt_arrowlen,5);
rightof(h.ed_linelen,h.txt_linelen,5);

h.txt_axislimitratio=new_text(h.p14,'Axis limit ratio',[0 0 100 20]);
h.ed_axislimitratio=new_edit(h.p14,'',[0 0 100 20]);
under(h.txt_axislimitratio,h.txt_linelen,5);
rightof(h.ed_axislimitratio,h.txt_axislimitratio,5);

h.txt_radiusratio=new_text(h.p14,'Radius ratio',[0 0 100 20]);
h.ed_radiusratio=new_edit(h.p14,'',[0 0 100 20]);
under(h.txt_radiusratio,h.txt_axislimitratio,5);
rightof(h.ed_radiusratio,h.txt_radiusratio,5);

h.cbx_savevideo=new_checkbox(h.p14,'Save video',[0 0 100 20]);
h.cbx_savevideo.Value=0;
enable_video_config=onoff(0);
rightof(h.cbx_savevideo,h.ed_animspeed,50);

h.txt_videoname=new_text(h.p14,'Video name',[0 0 100 20]);
h.ed_videoname=new_edit(h.p14,'',[0 0 100 20]);
h.txt_videoname.Enable=enable_video_config;
h.ed_videoname.Enable=enable_video_config;
under(h.txt_videoname,h.cbx_savevideo,5);
rightof(h.ed_videoname,h.txt_videoname,5);

h.txt_videoformat=new_text(h.p14,'Video format',[0 0 100 20]);
h.ed_videoformat=new_edit(h.p14,'',[0 0 100 20]);
h.txt_videoformat.Enable=enable_video_config;
h.ed_videoformat.Enable=enable_video_config;
under(h.txt_videoformat,h.txt_videoname,5);
rightof(h.ed_videoformat,h.txt_videoformat,5);

h.txt_videoframerate=new_text(h.p14,'Frame rate',[0 0 100 20]);
h.ed_videoframerate=new_edit(h.p14,'',[0 0 100 20]);
h.txt_videoframerate.Enable=enable_video_config;
h.ed_videoframerate.Enable=enable_video_config;
under(h.txt_videoframerate,h.txt_videoformat,5);
rightof(h.ed_videoframerate,h.txt_videoframerate,5);

UpdateGeneralTabFromConfig(all_general_configs('Default'),h);
