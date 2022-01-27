global all_attitude_configs

gui.p2 = uipanel(gui.main_tab2,'FontSize',15,...
             'BackgroundColor','white',...
             'Position',[0 0 1 1]);
         
%% Panel 0 : Config
gui.p20 = uipanel('Parent',gui.p2,'Title','Config','FontSize',10,...
              'Position',[0 0.9 1 0.1]);

gui.txt_attitudeconfig=new_text(gui.p20,'Config',[10 20 100 20]);
gui.spn_attitudeconfig=new_spinner(gui.p20,all_attitude_configs.keys,[0 0 100 20]);
rightof(gui.spn_attitudeconfig,gui.txt_attitudeconfig,5);

gui.txt_attitudeconfig=new_text(gui.p20,'Config',[10 20 100 20]);
gui.spn_attitudeconfig=new_spinner(gui.p20,all_attitude_configs.keys,[0 0 100 20]);
rightof(gui.spn_attitudeconfig,gui.txt_attitudeconfig,5);

gui.btn_updateattitudeconfig=new_button(gui.p20,'Update',[0 0 70 20]);
rightof(gui.btn_updateattitudeconfig,gui.spn_attitudeconfig,10);

gui.btn_deleteattitudeconfig=new_button(gui.p20,'Delete',[0 0 70 20]);
rightof(gui.btn_deleteattitudeconfig,gui.btn_updateattitudeconfig,10);

gui.txt_createattitudeconfig=new_text(gui.p20,'New config name',[0 0 100 20]);
rightof(gui.txt_createattitudeconfig,gui.btn_deleteattitudeconfig,20);
gui.ed_createattitudeconfig=new_edit(gui.p20,'',[0 0 100 20]);
rightof(gui.ed_createattitudeconfig,gui.txt_createattitudeconfig,5);
gui.btn_createattitudeconfig=new_button(gui.p20,'Create',[0 0 70 20]);
rightof(gui.btn_createattitudeconfig,gui.ed_createattitudeconfig,5);

%% Panel 1 : Elementary conditions
gui.sp21 = uipanel('Parent',gui.p2,'Title','Elementary conditions','FontSize',12,...
              'Position',[0 0 .5 0.9]);
          
gui.sp211 = uipanel('Parent',gui.sp21,'Title','Selected conditions','FontSize',10,...
              'Position',[0 0.45 1 0.55]);

gui.tbl_attitudeelementaryconditions=uitable(gui.sp211);
gui.tbl_attitudeelementaryconditions.Position=[20 20 350 320];
gui.tbl_attitudeelementaryconditions.ColumnName = {'Name','Type','Parameters'};
tablecolumnwidth=gui.tbl_attitudeelementaryconditions.Position(3)/length(gui.tbl_attitudeelementaryconditions.ColumnName);
gui.tbl_attitudeelementaryconditions.ColumnWidth={tablecolumnwidth};
gui.tbl_attitudeelementaryconditions.RowName={};
gui.tbl_attitudeelementaryconditions.ColumnEditable = [false false false];

gui.sp212 = uipanel('Parent',gui.sp21,'Title','Condition definition','FontSize',10,...
              'Position',[0 0 1 0.45]);
          
gui.txt_attitudeconditiondefinitionname=new_text(gui.sp212,'Name',[0 250 100 20]);
gui.ed_attitudeconditiondefinitionname=new_edit(gui.sp212,'',[0 0 200 20]);
rightof(gui.ed_attitudeconditiondefinitionname,gui.txt_attitudeconditiondefinitionname,10);
          
gui.txt_attitudeconditiondefinitiontype=new_text(gui.sp212,'Type',[0 0 100 20]);
under(gui.txt_attitudeconditiondefinitiontype,gui.txt_attitudeconditiondefinitionname,5);
gui.spn_attitudeconditiondefinitiontype=new_spinner(gui.sp212,{'Time';'Latitude';'Longitude'},[0 0 100 20]);
rightof(gui.spn_attitudeconditiondefinitiontype,gui.txt_attitudeconditiondefinitiontype,10);

gui.btn_attitudeconditiondefinitiondelete=new_button(gui.sp212,'Delete',[100 10 100 20]);
gui.btn_attitudeconditiondefinitionvalidate=new_button(gui.sp212,'Add/Update',[250 10 100 20]);
     
%% Panel 2 : Attitude sequence
gui.sp22 = uipanel('Parent',gui.p2,'Title','Attitude sequence','FontSize',12,...
              'Position',[0.5 0 .5 0.9]);

gui.tbl_attitudesequence=uitable(gui.sp22);
gui.tbl_attitudesequence.Position=[20 322 350 320];
gui.tbl_attitudesequence.ColumnName = {'Priority','Condition','Law','Parameters'};
tablecolumnwidth=gui.tbl_attitudesequence.Position(3)/length(gui.tbl_attitudesequence.ColumnName);
gui.tbl_attitudesequence.ColumnWidth={tablecolumnwidth};
gui.tbl_attitudesequence.RowName={};
gui.tbl_attitudesequence.ColumnEditable = [false false false false];

gui.txt_attitudesequencepriority=new_text(gui.sp22,'Priority',[5 280 100 20]);
gui.spn_attitudesequencepriority=new_spinner(gui.sp22,{1;2;3},[0 0 100 20]);
rightof(gui.spn_attitudesequencepriority,gui.txt_attitudesequencepriority,5);

gui.txt_attitudesequenceconditionname=new_text(gui.sp22,'Condition',[0 0 100 20]);
gui.spn_attitudesequenceconditionname1=new_spinner(gui.sp22,{},[0 0 100 20]);
under(gui.txt_attitudesequenceconditionname,gui.txt_attitudesequencepriority,5);
rightof(gui.spn_attitudesequenceconditionname1,gui.txt_attitudesequenceconditionname,5);

gui.spn_attitudesequenceconditionoperator1=new_spinner(gui.sp22,{'and','or'},[0 0 50 20]);
under(gui.spn_attitudesequenceconditionoperator1,gui.spn_attitudesequenceconditionname1,5);
gui.spn_attitudesequenceconditionname2=new_spinner(gui.sp22,{},[0 0 100 20]);
rightof(gui.spn_attitudesequenceconditionname2,gui.spn_attitudesequenceconditionoperator1,5);
gui.spn_attitudesequenceconditionoperator2=new_spinner(gui.sp22,{'and','or'},[0 0 50 20]);
under(gui.spn_attitudesequenceconditionoperator2,gui.spn_attitudesequenceconditionoperator1,5);
gui.spn_attitudesequenceconditionname3=new_spinner(gui.sp22,{},[0 0 100 20]);
rightof(gui.spn_attitudesequenceconditionname3,gui.spn_attitudesequenceconditionoperator2,5);

gui.txt_attitudesequencelaw=new_text(gui.sp22,'Law',[5 180 100 20]);
gui.spn_attitudesequencelaw=new_spinner(gui.sp22,{'Nadir Pointing','Base Pointing','Solar Pointing'},[0 0 100 20]);
rightof(gui.spn_attitudesequencelaw,gui.txt_attitudesequencelaw,5);

gui.btn_attitudesequencemoveelementup=new_button(gui.sp22,'Up',[0 0 40 20]);
rightof(gui.btn_attitudesequencemoveelementup,gui.spn_attitudesequencepriority,20);
gui.btn_attitudesequencemoveelementdown=new_button(gui.sp22,'Down',[0 0 40 20]);
under(gui.btn_attitudesequencemoveelementdown,gui.btn_attitudesequencemoveelementup,5);

gui.btn_attitudesequencedeleteelement=new_button(gui.sp22,'Delete',[100 10 100 20]);
gui.btn_attitudesequenceaddelement=new_button(gui.sp22,'Add/Update',[250 10 100 20]);
rightof(gui.btn_attitudesequenceaddelement,gui.btn_attitudesequencedeleteelement,10);

if ~isempty(all_attitude_configs)
    configs=all_attitude_configs.values;
    UpdateAttitudeTabFromConfig(configs{1},h);
end