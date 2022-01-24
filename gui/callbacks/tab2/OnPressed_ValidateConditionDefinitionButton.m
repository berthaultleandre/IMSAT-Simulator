function OnPressed_ValidateConditionDefinitionButton(src,event,h)
    global current_conditions
    SetAttitudeTabUpdateState(false,h);
    ha=guidata(h.tbl_attitudeelementaryconditions);
    type=h.spn_attitudeconditiondefinitiontype.String{h.spn_attitudeconditiondefinitiontype.Value};
    name=h.ed_attitudeconditiondefinitionname.String;
    [param,func]=GetConditionParam(type,ha);
    new_condition=struct('Name',name,'Type',type,'Parameters',param,'Function',func);
    current_conditions(name)=new_condition;
    UpdateElementaryConditions(h);
end