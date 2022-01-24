function OnSelectedItem_Cond0Spinner(src,event,h)
    SetGeneralTabUpdateState(false,h);
    name=src.String{src.Value};
    UpdateCond0Data(name,h);
    
end