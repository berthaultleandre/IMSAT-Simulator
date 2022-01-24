function [param,func]=GetConditionParam(type,h)
    condition_gui=h.condition_gui;
    if strcmp(type,'Time')
        startTime=str2double(condition_gui('ed_attitudeconditiontimestart').String);
        endTime=str2double(condition_gui('ed_attitudeconditiontimeend').String);
        param=struct('StartTime',startTime,'EndTime',endTime);
        func=@(t) (t>=startTime && t<endTime);
    elseif strcmp(type,'Latitude')
        latitudeMin=str2double(condition_gui('ed_attitudeconditionlatitudemin').String);
        latitudeMax=str2double(condition_gui('ed_attitudeconditionlatitudemax').String);
        param=struct('LatitudeMin',latitudeMin,'LatitudeMax',latitudeMax);
        func=@(lat) (lat>=latitudeMin && lat<latitudeMax);
    elseif strcmp(type,'Longitude')
        longitudeMin=str2double(condition_gui('ed_attitudeconditionlongitudemin').String);
        longitudeMax=str2double(condition_gui('ed_attitudeconditionlongitudemax').String);
        param=struct('LongitudeMin',longitudeMin,'LongitudeMax',longitudeMax);
        func=@(lon) (lon>=longitudeMin && lon<longitudeMax);
    end
end

