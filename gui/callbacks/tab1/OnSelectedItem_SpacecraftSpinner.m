function OnSelectedItem_SpacecraftSpinner(src,event,h)
    SetGeneralTabUpdateState(false,h);
    name=src.String{src.Value};
    UpdateSpacecraftData(name,h);
end