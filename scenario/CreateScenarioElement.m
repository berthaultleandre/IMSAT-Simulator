function element = CreateScenarioElement(condition,law_name,varargin)
    element = struct('Condition',condition,'Law',law_name);
    if length(varargin)==1
        element.Parameters=varargin{1};
    else
        element.Parameters=struct([]);
    end
end

