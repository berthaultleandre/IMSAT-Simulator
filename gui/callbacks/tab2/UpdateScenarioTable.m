function UpdateScenarioTable(h)
    global current_scenario
    newdata={};
    keys=current_scenario.keys;
    [sortedKeys sortIdx]=sort(keys);
    values=current_scenario.values;
    sortedValues=values(sortIdx);
    for i=1:length(sortedKeys)
        key=int2str(i);
        element=current_scenario(key);
        condition_name1=element.Condition.Condition1;
        condition_name2=element.Condition.Condition2;
        condition_name3=element.Condition.Condition3;
        operator1=element.Condition.Operator1;
        operator2=element.Condition.Operator2;
        e1=~strcmp(condition_name1,' ');
        e2=~strcmp(condition_name2,' ');
        e3=~strcmp(condition_name3,' ');
        space=32;
        if e1
            condition=condition_name1;
        end
        if e2
            if e1
                condition=strcat(condition,space,operator1,space,condition_name2);
            else
                condition=condition_name2;
            end
        end
        if e3
            if ~e1 && ~e2
                condition=condition_name3;
            else
                condition=strcat(condition,space,operator2,space,condition_name3);
            end
        end
        law_name=element.Law;
        param=element.Parameters;
        param_str=GetScenarioElementParamStr(law_name,param);
        new_line={key, condition, law_name, param_str};
        if isempty(newdata)
            newdata={new_line};
        else
            newdata={cat(1,newdata{:});new_line};
        end
    end
    newdata=cat(1, newdata{:});
    h.tbl_attitudesequence.Data=newdata;
    h.spn_attitudesequencepriority.String=num2cell(1:(length(current_scenario)+1));
end

