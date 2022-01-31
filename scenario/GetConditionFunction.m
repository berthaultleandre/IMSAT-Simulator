function func = GetConditionFunction(type,param)
    if strcmp(type,'Time')
        startTime=param.StartTime;
        endTime=param.EndTime;
        func=@(t) (t>=startTime && t<endTime);
    elseif strcmp(type,'Latitude')
        latitudeMin=param.LatitudeMin;
        latitudeMax=param.LatitudeMax;
        func=@(lat) (lat>=latitudeMin && lat<latitudeMax);
    elseif strcmp(type,'Longitude')
        longitudeMin=param.LongitudeMin;
        longitudeMax=param.LongitudeMax;
        func=@(lon) (lon>=longitudeMin && lon<longitudeMax);
    end
end

