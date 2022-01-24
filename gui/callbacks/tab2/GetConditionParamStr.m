function param_str=GetConditionParamStr(type,param)
    if strcmp(type,'Time')
        param_str=strcat(num2str(param.StartTime),', ',num2str(param.EndTime));
    elseif strcmp(type,'Latitude')
        param_str=strcat(num2str(param.LatitudeMin),', ',num2str(param.LatitudeMax));
    elseif strcmp(type,'Longitude')
        param_str=strcat(num2str(param.LongitudeMin),', ',num2str(param.LongitudeMax));
    end
end

