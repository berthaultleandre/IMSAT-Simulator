function leftof(obj1,obj2,marginright)
    obj1.Position(1)=obj2.Position(1)-obj2.Position(3)-marginright;
    obj1.Position(2)=obj2.Position(2);
end

