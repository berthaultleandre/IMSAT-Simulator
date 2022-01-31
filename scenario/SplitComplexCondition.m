function [elementary_conditions,operators] = SplitComplexCondition(complex_condition)
    global current_conditions
    elementary_conditions=[];
    operators={};
    e1=isfield(complex_condition,'Condition1');
    e2=isfield(complex_condition,'Condition2');
    e3=isfield(complex_condition,'Condition3');
    if e1
        condition_name1=complex_condition.Condition1;
        condition1=current_conditions(condition_name1);
        elementary_conditions=[elementary_conditions condition1];
    end
    if e2
        operator1=complex_condition.Operator1;
        condition_name2=complex_condition.Condition2;
        condition2=current_conditions(condition_name2);
        elementary_conditions=[elementary_conditions condition2];
        if e1
            operators=horzcat(operators,operator1);
        end
    end
    if e3
        operator2=complex_condition.Operator2;
        condition_name3=complex_condition.Condition3;
        condition3=current_conditions(condition_name3);
        elementary_conditions=[elementary_conditions condition3];
        if e1 || e2
            operators=horzcat(operators,operator2);
        end
    end
end

