function b = CheckComplexCondition(complex_condition,state)
    global current_conditions
    [elementary_conditions,operators]=SplitComplexCondition(complex_condition);  
    b=true;
    operator=str2func('and');
    for j=1:length(elementary_conditions)
        condition=elementary_conditions(j);
        if j>1
            operator=str2func(operators{j-1});
        end
        b=operator(CheckElementaryCondition(condition,state),b);
    end
end

