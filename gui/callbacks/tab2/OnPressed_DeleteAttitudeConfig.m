function OnPressed_DeleteAttitudeConfig(src,event,h)
    name=h.spn_attitudeconfig.String{h.spn_attitudeconfig.Value};
    DeleteAttitudeConfig(name,h);
end

