function sld = new_slider(parent,min,max,value,step)
    sld=uicontrol('Style','slider','Parent',parent,...
        'Min',min,'Max',max,'Value',value,...
        'Units', 'Normalized',...
        'SliderStep', step);
end
