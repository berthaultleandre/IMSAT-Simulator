function rightof(obj1,obj2,marginleft)
    obj1.Position(1)=obj2.Position(1)+obj2.Position(3)+marginleft;
    obj1.Position(2)=obj2.Position(2)+(obj2.Position(4)-obj1.Position(4))/2;
end

