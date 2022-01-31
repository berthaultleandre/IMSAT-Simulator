function str = GetElementConditionStr(condition)
    condition_name1=condition.Condition1;
    e1=isfield(condition,'Condition1');
    e2=isfield(condition,'Condition2');
    e3=isfield(condition,'Condition3');
    space=32;
    if e1
        str=condition_name1;
    end
    if e2
        operator1=condition.Operator1;
        condition_name2=condition.Condition2;
        if e1
            str=strcat(str,space,operator1,space,condition_name2);
        else
            str=condition_name2;
        end
    end
    if e3
        operator2=condition.Operator2;
        condition_name3=condition.Condition3;
        if ~e1 && ~e2
            str=condition_name3;
        else
            str=strcat(str,space,operator2,space,condition_name3);
        end
    end
end

