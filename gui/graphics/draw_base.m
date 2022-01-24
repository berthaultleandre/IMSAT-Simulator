function [plt,txt]=draw_base(base,t)
    name=base.name;
    [x,y,z]=base_position(base,t,0);
    plt=plot3(x,y,z,'ro', 'MarkerSize', 5);
    [x,y,z]=base_position(base,t,0.3);
    txt=text(x,y,z,name);
end