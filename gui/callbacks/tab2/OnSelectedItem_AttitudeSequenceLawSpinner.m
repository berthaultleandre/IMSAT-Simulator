function OnSelectedItem_AttitudeSequenceLawSpinner(src,event,h)
    law_name=h.spn_attitudesequencelaw.String(h.spn_attitudesequencelaw.Value);
    param=GetLawParam(law_name,h,true);
    UpdateScenarioElementDefinitionParametersAux(h,src,law_name,param);
end

