function new_spacecraft(name,dim,weight)
    global all_spacecrafts
    spacecraft=struct('name',name,'dim',dim,'m',weight);
    all_spacecrafts(name)=spacecraft;
end