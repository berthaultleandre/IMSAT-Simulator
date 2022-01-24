function stopTimer(src,handles)
    handles.btn_stop.Selected='on';
    set(handles.btn_stop, 'String', 'Restart');
    handles.btn_pause.Enable='off';
    set(handles.btn_pause, 'String', 'Pause');
    if isfield(handles,'video')
        close(handles.video);
    end
    pauseTimer(src,handles);
end