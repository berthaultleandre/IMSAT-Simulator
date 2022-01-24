function OnPressed_AddAttitudeSequenceElementButton(src,event,h)
    global current_scenario
    SetAttitudeTabUpdateState(false,h);
    condition_index1=h.spn_attitudesequenceconditionname1.Value;
    condition_name1=h.spn_attitudesequenceconditionname1.String(condition_index1);
    condition_name1=cast(condition_name1,'char');
    
    condition_index2=h.spn_attitudesequenceconditionname2.Value;
    condition_name2=h.spn_attitudesequenceconditionname2.String(condition_index2);
    condition_name2=cast(condition_name2,'char');
    
    condition_index3=h.spn_attitudesequenceconditionname3.Value;
    condition_name3=h.spn_attitudesequenceconditionname3.String(condition_index3);
    condition_name3=cast(condition_name3,'char');
    
    operator_index1=h.spn_attitudesequenceconditionoperator1.Value;
    operator1=h.spn_attitudesequenceconditionoperator1.String(operator_index1);
    
    operator_index2=h.spn_attitudesequenceconditionoperator2.Value;
    operator2=h.spn_attitudesequenceconditionoperator2.String(operator_index2);
    
    condition=struct('Condition1',condition_name1,'Condition2',condition_name2,...
        'Condition3',condition_name3,'Operator1',operator1,'Operator2',operator2);
    
    law_index=h.spn_attitudesequencelaw.Value;
    law_name=h.spn_attitudesequencelaw.String(law_index);
    param=GetLawParam(law_name,h,false);

    element=struct('Condition',condition,'Law',law_name,'Parameters',param);
    index=num2str(h.spn_attitudesequencepriority.Value);
    current_scenario(index)=element;

    UpdateScenarioTable(h);
end