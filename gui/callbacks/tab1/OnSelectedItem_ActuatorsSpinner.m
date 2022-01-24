function OnSelectedItem_ActuatorsSpinner(src,event,h)
    SetGeneralTabUpdateState(false,h);
    name=h.spn_actuators.String{h.spn_actuators.Value};
    UpdateActuatorsParameters(h,src,name,struct([]));
end