function OnPressed_DeleteGeneralConfig(src,event,h)
    name=h.spn_generalconfig.String{h.spn_generalconfig.Value};
    DeleteGeneralConfig(name,h);
end