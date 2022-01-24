h.p3 = uipanel(h.main_tab3,'FontSize',15,...
             'BackgroundColor','white',...
             'Position',[0 0 1 1]);
         
h.p31 = uipanel('Parent',h.p3,'Title','Simulation','FontSize',12,...
             'Position',[0 0.85 0.4 0.15]);

def_sim_time=200;
h.txt_simtime=new_text(h.p31,'Simulation time (s)',[20 60 100 20]);
h.ed_simtime=new_edit(h.p31,num2str(def_sim_time),[0 0 100 20]);
rightof(h.ed_simtime,h.txt_simtime,5);
h.btn_startsim=new_button(h.p31,'Start Simulation',[0 0 100 20]);
under(h.btn_startsim,h.ed_simtime,10);