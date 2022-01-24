function pauseTimer(src,handles)
    guihandles=guidata(handles.fig);
    if isfield(guihandles,'timer') && ~isempty(guihandles.timer)
        stop(guihandles.timer);
        guihandles.timer = [];
        guidata(handles.fig,guihandles);
    end
end