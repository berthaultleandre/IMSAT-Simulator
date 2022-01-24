function OnSelectedItem_AttitudeConditionDefinitionTypeSpinner(src,event,h)
    name=h.ed_attitudeconditiondefinitionname.String;
    type=h.spn_attitudeconditiondefinitiontype.String(h.spn_attitudeconditiondefinitiontype.Value);
    param=struct([]);
    UpdateConditionDefinitionParameters(h,h.tbl_attitudeelementaryconditions,name,type,param);
end

