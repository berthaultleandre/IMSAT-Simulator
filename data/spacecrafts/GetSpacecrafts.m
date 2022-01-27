function spacecrafts = GetSpacecrafts()
    spacecrafts=containers.Map;

    %Spacecrafts
    spacecrafts('Default')=new_spacecraft('Default',[0.10,0.10,0.10],1.0);
    spacecrafts('Big One')=new_spacecraft('Big One',[1,1,1],100.0);
end