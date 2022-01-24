function OnPressed_StartSimulationButton(src,event,h)
    cla(h.ax);
    h.ax.Title.String='';
    h.main_tab4.Parent=h.main_tabgp;
    rotate3d(h.ax,'on');
    h.main_tabgp.SelectedTab=h.main_tab4;
    start_simulation;
    %handles.fig.Visible='off';
end
