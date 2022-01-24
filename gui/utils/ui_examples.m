%{
fig=figure('units','normalized','outerposition',[0 0 1 1])
p = uipanel('Title','Main Panel','FontSize',12,...
             'BackgroundColor','white',...
             'Position',[0 0 1 1]);
sp1 = uipanel('Parent',p,'Title','Subpanel 1','FontSize',12,...
              'Position',[0 0 .5 1]);
sp2 = uipanel('Parent',p,'Title','Subpanel 2','FontSize',12,...
              'Position',[0.5 0 .5 1]);
ax=axes(sp2);
ax.Units = 'pixels';
ax.Position = [0 0 500 500]
%set(gca,'color',[1 1 1])

%startAnimationButton = button(fig,'Start Animation',[0 0 100 50],@startAnimationButtonPushed);
%testCheckbox = checkbox(fig,'Coucou', [200 200 200 200],@startAnimationButtonPushed);
bg = buttongroup(sp1,[0 0 50 20],@startAnimationButtonPushed);
rb1 = radiobutton(bg,'One',[0 40 50 20]);
rb2 = radiobutton(bg,'Two',[0 20 50 20]);
rb3 = radiobutton(bg,'Three',[0 0 50 20]);
bg.Visible = 'on';

spn = spinner(sp1,[0 500 100 20],{'One';'Two';'Three'},@startAnimationButtonPushed);

bg2 = buttongroup(sp1,[0 0.9 100 100],@startAnimationButtonPushed);
tb1 = uicontrol(bg2,'style','togglebutton','Position',[0 50 100 22],'String','One');
tb2 = uicontrol(bg2,'style','togglebutton','Position',[0 25 100 22],'String','Two');
tb3 = uicontrol(bg2,'style','togglebutton','Position',[0 0 100 22],'String','Three');
bg2.Visible = 'on';
%{
% Create a button group and radio buttons:
bg = uibuttongroup('Parent',fig,...
    'Position',[56 77 123 85]);
rb1 = uiradiobutton(bg,'Position',[10 60 91 15]);
rb2 = uiradiobutton(bg,'Position',[10 38 91 15]);
rb3 = uiradiobutton(bg,'Position',[10 16 91 15]);

% Create a check box:
cbx = uicheckbox(fig,'Position',[55 217 102 15],...
    'ValueChangedFcn',@(cbx,event) cBoxChanged(cbx,rb3));
end

% Create the function for the ValueChangedFcn callback:
function cBoxChanged(cbx,rb3)
val = cbx.Value;
if val
    rb3.Enable = 'off';
else
    rb3.Enable = 'on';
end
%}
%}