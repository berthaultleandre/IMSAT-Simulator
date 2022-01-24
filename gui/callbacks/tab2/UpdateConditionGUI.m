function h=UpdateConditionGUI(type,param,h,ha)
    if strcmp(type,'Time')
        txt_attitudeconditiontimestart=new_text(ha.sp212,'Start time',[0 0 100 20]);
        under(txt_attitudeconditiontimestart,ha.txt_attitudeconditiondefinitiontype,5);
        ed_attitudeconditiontimestart=new_edit(ha.sp212,'',[0 0 100 20]);
        rightof(ed_attitudeconditiontimestart,txt_attitudeconditiontimestart,10);

        txt_attitudeconditiontimeend=new_text(ha.sp212,'End time',[0 0 100 20]);
        under(txt_attitudeconditiontimeend,txt_attitudeconditiontimestart,5);
        ed_attitudeconditiontimeend=new_edit(ha.sp212,'',[0 0 100 20]);
        rightof(ed_attitudeconditiontimeend,txt_attitudeconditiontimeend,10);
        
        if ~isempty(param)
            ed_attitudeconditiontimestart.String=num2str(param.StartTime);
            ed_attitudeconditiontimeend.String=num2str(param.EndTime);
        end
        
        h.condition_gui=containers.Map;
        h.condition_gui('txt_attitudeconditiontimestart')=txt_attitudeconditiontimestart;
        h.condition_gui('ed_attitudeconditiontimestart')=ed_attitudeconditiontimestart;
        h.condition_gui('txt_attitudeconditiontimeend')=txt_attitudeconditiontimeend;
        h.condition_gui('ed_attitudeconditiontimeend')=ed_attitudeconditiontimeend;
    elseif strcmp(type,'Latitude')
        txt_attitudeconditionlatitudemin=new_text(ha.sp212,'Latitude min.',[0 0 100 20]);
        under(txt_attitudeconditionlatitudemin,ha.txt_attitudeconditiondefinitiontype,5);
        ed_attitudeconditionlatitudemin=new_edit(ha.sp212,'',[0 0 100 20]);
        rightof(ed_attitudeconditionlatitudemin,txt_attitudeconditionlatitudemin,10);

        txt_attitudeconditionlatitudemax=new_text(ha.sp212,'Latitude max.',[0 0 100 20]);
        under(txt_attitudeconditionlatitudemax,txt_attitudeconditionlatitudemin,5);
        ed_attitudeconditionlatitudemax=new_edit(ha.sp212,'',[0 0 100 20]);
        rightof(ed_attitudeconditionlatitudemax,txt_attitudeconditionlatitudemax,10);
        
        if ~isempty(param)
            ed_attitudeconditionlatitudemin.String=num2str(param.LatitudeMin);
            ed_attitudeconditionlatitudemax.String=num2str(param.LatitudeMax);
        end
        
        h.condition_gui=containers.Map;
        h.condition_gui('txt_attitudeconditionlatitudemin')=txt_attitudeconditionlatitudemin;
        h.condition_gui('ed_attitudeconditionlatitudemin')=ed_attitudeconditionlatitudemin;
        h.condition_gui('txt_attitudeconditionlatitudemax')=txt_attitudeconditionlatitudemax;
        h.condition_gui('ed_attitudeconditionlatitudemax')=ed_attitudeconditionlatitudemax;
    elseif strcmp(type,'Longitude')
        txt_attitudeconditionlongitudemin=new_text(ha.sp212,'Longitude min.',[0 0 100 20]);
        under(txt_attitudeconditionlongitudemin,ha.txt_attitudeconditiondefinitiontype,5);
        ed_attitudeconditionlongitudemin=new_edit(ha.sp212,'',[0 0 100 20]);
        rightof(ed_attitudeconditionlongitudemin,txt_attitudeconditionlongitudemin,10);

        txt_attitudeconditionlongitudemax=new_text(ha.sp212,'Longitude max.',[0 0 100 20]);
        under(txt_attitudeconditionlongitudemax,txt_attitudeconditionlongitudemin,5);
        ed_attitudeconditionlongitudemax=new_edit(ha.sp212,'',[0 0 100 20]);
        rightof(ed_attitudeconditionlongitudemax,txt_attitudeconditionlongitudemax,10);
        
        if ~isempty(param)
            ed_attitudeconditionlongitudemin.String=num2str(param.LongitudeMin);
            ed_attitudeconditionlongitudemax.String=num2str(param.LongitudeMax);
        end
        
        h.condition_gui=containers.Map;
        h.condition_gui('txt_attitudeconditionlongitudemin')=txt_attitudeconditionlongitudemin;
        h.condition_gui('ed_attitudeconditionlongitudemin')=ed_attitudeconditionlongitudemin;
        h.condition_gui('txt_attitudeconditionlongitudemax')=txt_attitudeconditionlongitudemax;
        h.condition_gui('ed_attitudeconditionlongitudemax')=ed_attitudeconditionlongitudemax;
    end
end

