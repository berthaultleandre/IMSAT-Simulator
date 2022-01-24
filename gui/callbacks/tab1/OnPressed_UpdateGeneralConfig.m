function OnPressed_UpdateGeneralConfig(src,event,h)
    name=h.spn_generalconfig.String{h.spn_generalconfig.Value};
    CreateOrUpdateGeneralConfig(name,h);
end