function OnSelectedItem_AttitudeSequencePrioritySpinner(src,event,h)
    row=h.spn_attitudesequencepriority.Value;
    UpdateScenarioElementDefinitionParameters(h,h.tbl_attitudesequence,row);
end

