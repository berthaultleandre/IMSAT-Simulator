function condition = CreateScenarioElementCondition(varargin)
    condition=struct();
    if nargin>=1
        condition.Condition1=varargin{1};
    end
    if nargin>=3
        condition.Operator1=varargin{2};
        condition.Condition2=varargin{3};
    end
    if nargin==5
        condition.Operator2=varargin{4};
        condition.Condition3=varargin{5};
    end
end

