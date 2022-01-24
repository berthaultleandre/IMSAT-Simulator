function h=UpdateActuatorsGUI(name,param,h,ha)
    global all_wheels_configs
    if strcmp(name,'Reaction wheels') || strcmp(name,'Mix')
        txt_numberofwheels=new_text(ha.p11,'Number of wheels',[0 0 150 20]);
        spn_numberofwheels=new_spinner(ha.p11,{3;4},[0 0 50 20]);
        under(txt_numberofwheels,ha.txt_actuators,10);
        rightof(spn_numberofwheels,txt_numberofwheels,5);
        txt_wheelsconfig=new_text(ha.p11,'Wheels configuration',[0 0 120 20]);
        spn_wheelsconfig=new_spinner(ha.p11,all_wheels_configs.keys,[0 0 100 20]);
        rightof(txt_wheelsconfig,spn_numberofwheels,5);
        rightof(spn_wheelsconfig,txt_wheelsconfig,5);
        if ~isempty(param)
            spn_numberofwheels.Value=find(strcmp(spn_numberofwheels.String,num2str(param.number_of_wheels)));
            spn_wheelsconfig.Value=find(strcmp(spn_wheelsconfig.String,param.wheels_config));
        end
        
        spn_numberofwheels.Callback={@OnEdited_GeneralTab, ha};
        spn_wheelsconfig.Callback={@OnEdited_GeneralTab, ha};
        
        h.actuatorsgui=containers.Map;
        h.actuatorsgui('txt_numberofwheels')=txt_numberofwheels;
        h.actuatorsgui('spn_numberofwheels')=spn_numberofwheels;
        h.actuatorsgui('txt_wheelsconfig')=txt_wheelsconfig;
        h.actuatorsgui('spn_wheelsconfig')=spn_wheelsconfig;
    end
end

