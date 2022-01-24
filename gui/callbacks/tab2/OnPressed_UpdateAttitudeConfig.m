function OnPressed_UpdateAttitudeConfig(src,event,h)
    name=h.spn_attitudeconfig.String{h.spn_attitudeconfig.Value};
    CreateOrUpdateAttitudeConfig(name,h);
end

