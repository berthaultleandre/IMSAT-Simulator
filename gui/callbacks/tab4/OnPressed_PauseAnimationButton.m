function OnPressed_PauseAnimationButton(src,event,h)
    if strcmpi(get(src, 'String'),'Resume')
        set(src, 'String', 'Pause');
        startTimer(h,true);
    else
        set(src, 'String', 'Resume');
        pauseTimer(src, h);
    end
end