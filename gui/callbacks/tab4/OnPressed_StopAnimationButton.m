function OnPressed_StopAnimationButton(src,event,h)
    if strcmpi(get(src, 'String'),'Restart')
        set(src, 'String', 'Stop');
        start_animation;
    else
        set(src, 'String', 'Restart');
        stopTimer(src,h);
        cla(h.ax);
        h.ax.Title.String='';
        set(h.btn_pause,'Enable','off'); 
    end
    
end