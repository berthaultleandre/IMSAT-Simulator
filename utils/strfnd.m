function v = strfnd(spn,str)
    v = find(strcmp(spn.String,str));
    spn.Value=v;
end

