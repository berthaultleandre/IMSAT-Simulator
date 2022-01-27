function bases=GetBases()

    bases = containers.Map;

    %A
    bases('A')=new_base('A',0.5*pi,0.5*pi);

    %B
    bases('B')=new_base('B',1.5*pi,0.75*pi);

    %C
    bases('C')=new_base('C',0.7*pi,0.4*pi);

    %D
    bases('D')=new_base('D',0,0);
end