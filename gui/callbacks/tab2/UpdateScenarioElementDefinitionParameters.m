function UpdateScenarioElementDefinitionParameters(ha,src,row) 
    global current_scenario
    if row>length(current_scenario)
        return;
    end
    if row == length(ha.spn_attitudesequencepriority.String)
        law_name='Nadir Pointing';
        parameters=struct([]);
    else
        line=int2str(row);
        element=current_scenario(line);
        condition_name1=element.Condition.Condition1;
        condition_name2=element.Condition.Condition2;
        condition_name3=element.Condition.Condition3;
        operator1=element.Condition.Operator1;
        operator2=element.Condition.Operator2;
        law_name=element.Law;
        parameters=element.Parameters;
        ha.spn_attitudesequencepriority.Value=row;
        ha.spn_attitudesequenceconditionname1.Value=find(strcmp(ha.spn_attitudesequenceconditionname1.String,condition_name1));
        ha.spn_attitudesequenceconditionname2.Value=find(strcmp(ha.spn_attitudesequenceconditionname2.String,condition_name2));
        ha.spn_attitudesequenceconditionname3.Value=find(strcmp(ha.spn_attitudesequenceconditionname3.String,condition_name3));
        ha.spn_attitudesequenceconditionoperator1.Value=find(strcmp(ha.spn_attitudesequenceconditionoperator1.String,operator1));
        ha.spn_attitudesequenceconditionoperator2.Value=find(strcmp(ha.spn_attitudesequenceconditionoperator1.String,operator2));
    end
    h=UpdateScenarioElementDefinitionParametersAux(ha,src,law_name,parameters);
    guidata(src,h);
end