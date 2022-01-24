h.p4 = uipanel(h.main_tab4,'FontSize',15,...
             'BackgroundColor','white',...
             'Position',[0 0 1 1]);
         
h.p41 = uipanel('Parent',h.p4,'Title','Animation','FontSize',12,...
              'Position',[0 0 1 1]);

h.ax=axes(h.p41);
h.ax.Units = 'pixels';
h.ax.Position = [200 200 500 450];
h.btn_pause=new_button(h.p41,'Pause',[300 20 100 20]);
h.btn_pause.Enable='off';
h.btn_stop=new_button(h.p41,'Stop',[400 20 100 20]);
h.btn_stop.Enable='off';
pause_anim=false;