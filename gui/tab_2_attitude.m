global all_attitude_configs

h.p2 = uipanel(h.main_tab2,'FontSize',15,...
             'BackgroundColor','white',...
             'Position',[0 0 1 1]);
         
%% Panel 0 : Config
h.p20 = uipanel('Parent',h.p2,'Title','Config','FontSize',10,...
              'Position',[0 0.9 1 0.1]);

h.txt_attitudeconfig=new_text(h.p20,'Config',[10 20 100 20]);
h.spn_attitudeconfig=new_spinner(h.p20,all_attitude_configs.keys,[0 0 100 20]);
rightof(h.spn_attitudeconfig,h.txt_attitudeconfig,5);

h.txt_attitudeconfig=new_text(h.p20,'Config',[10 20 100 20]);
h.spn_attitudeconfig=new_spinner(h.p20,all_attitude_configs.keys,[0 0 100 20]);
rightof(h.spn_attitudeconfig,h.txt_attitudeconfig,5);

h.btn_updateattitudeconfig=new_button(h.p20,'Update',[0 0 70 20]);
rightof(h.btn_updateattitudeconfig,h.spn_attitudeconfig,10);

h.btn_deleteattitudeconfig=new_button(h.p20,'Delete',[0 0 70 20]);
rightof(h.btn_deleteattitudeconfig,h.btn_updateattitudeconfig,10);

h.txt_createattitudeconfig=new_text(h.p20,'New config name',[0 0 100 20]);
rightof(h.txt_createattitudeconfig,h.btn_deleteattitudeconfig,20);
h.ed_createattitudeconfig=new_edit(h.p20,'',[0 0 100 20]);
rightof(h.ed_createattitudeconfig,h.txt_createattitudeconfig,5);
h.btn_createattitudeconfig=new_button(h.p20,'Create',[0 0 70 20]);
rightof(h.btn_createattitudeconfig,h.ed_createattitudeconfig,5);

%% Panel 1 : Elementary conditions
h.sp21 = uipanel('Parent',h.p2,'Title','Elementary conditions','FontSize',12,...
              'Position',[0 0 .5 0.9]);
          
h.sp211 = uipanel('Parent',h.sp21,'Title','Selected conditions','FontSize',10,...
              'Position',[0 0.45 1 0.55]);

h.tbl_attitudeelementaryconditions=uitable(h.sp211);
h.tbl_attitudeelementaryconditions.Position=[20 20 350 320];
h.tbl_attitudeelementaryconditions.ColumnName = {'Name','Type','Parameters'};
tablecolumnwidth=h.tbl_attitudeelementaryconditions.Position(3)/length(h.tbl_attitudeelementaryconditions.ColumnName);
h.tbl_attitudeelementaryconditions.ColumnWidth={tablecolumnwidth};
h.tbl_attitudeelementaryconditions.RowName={};
h.tbl_attitudeelementaryconditions.ColumnEditable = [false false false];

h.sp212 = uipanel('Parent',h.sp21,'Title','Condition definition','FontSize',10,...
              'Position',[0 0 1 0.45]);
          
h.txt_attitudeconditiondefinitionname=new_text(h.sp212,'Name',[0 250 100 20]);
h.ed_attitudeconditiondefinitionname=new_edit(h.sp212,'',[0 0 200 20]);
rightof(h.ed_attitudeconditiondefinitionname,h.txt_attitudeconditiondefinitionname,10);
          
h.txt_attitudeconditiondefinitiontype=new_text(h.sp212,'Type',[0 0 100 20]);
under(h.txt_attitudeconditiondefinitiontype,h.txt_attitudeconditiondefinitionname,5);
h.spn_attitudeconditiondefinitiontype=new_spinner(h.sp212,{'Time';'Latitude';'Longitude'},[0 0 100 20]);
rightof(h.spn_attitudeconditiondefinitiontype,h.txt_attitudeconditiondefinitiontype,10);

h.btn_attitudeconditiondefinitiondelete=new_button(h.sp212,'Delete',[100 10 100 20]);
h.btn_attitudeconditiondefinitionvalidate=new_button(h.sp212,'Add/Update',[250 10 100 20]);
     
%% Panel 2 : Attitude sequence
h.sp22 = uipanel('Parent',h.p2,'Title','Attitude sequence','FontSize',12,...
              'Position',[0.5 0 .5 0.9]);

h.tbl_attitudesequence=uitable(h.sp22);
h.tbl_attitudesequence.Position=[20 322 350 320];
h.tbl_attitudesequence.ColumnName = {'Priority','Condition','Law','Parameters'};
tablecolumnwidth=h.tbl_attitudesequence.Position(3)/length(h.tbl_attitudesequence.ColumnName);
h.tbl_attitudesequence.ColumnWidth={tablecolumnwidth};
h.tbl_attitudesequence.RowName={};
h.tbl_attitudesequence.ColumnEditable = [false false false false];

h.txt_attitudesequencepriority=new_text(h.sp22,'Priority',[5 280 100 20]);
h.spn_attitudesequencepriority=new_spinner(h.sp22,{1;2;3},[0 0 100 20]);
rightof(h.spn_attitudesequencepriority,h.txt_attitudesequencepriority,5);

h.txt_attitudesequenceconditionname=new_text(h.sp22,'Condition',[0 0 100 20]);
h.spn_attitudesequenceconditionname1=new_spinner(h.sp22,{},[0 0 100 20]);
under(h.txt_attitudesequenceconditionname,h.txt_attitudesequencepriority,5);
rightof(h.spn_attitudesequenceconditionname1,h.txt_attitudesequenceconditionname,5);

h.spn_attitudesequenceconditionoperator1=new_spinner(h.sp22,{'and','or'},[0 0 50 20]);
under(h.spn_attitudesequenceconditionoperator1,h.spn_attitudesequenceconditionname1,5);
h.spn_attitudesequenceconditionname2=new_spinner(h.sp22,{},[0 0 100 20]);
rightof(h.spn_attitudesequenceconditionname2,h.spn_attitudesequenceconditionoperator1,5);
h.spn_attitudesequenceconditionoperator2=new_spinner(h.sp22,{'and','or'},[0 0 50 20]);
under(h.spn_attitudesequenceconditionoperator2,h.spn_attitudesequenceconditionoperator1,5);
h.spn_attitudesequenceconditionname3=new_spinner(h.sp22,{},[0 0 100 20]);
rightof(h.spn_attitudesequenceconditionname3,h.spn_attitudesequenceconditionoperator2,5);

h.txt_attitudesequencelaw=new_text(h.sp22,'Law',[5 180 100 20]);
h.spn_attitudesequencelaw=new_spinner(h.sp22,{'Nadir Pointing','Base Pointing','Solar Pointing'},[0 0 100 20]);
rightof(h.spn_attitudesequencelaw,h.txt_attitudesequencelaw,5);

h.btn_attitudesequencemoveelementup=new_button(h.sp22,'Up',[0 0 40 20]);
rightof(h.btn_attitudesequencemoveelementup,h.spn_attitudesequencepriority,20);
h.btn_attitudesequencemoveelementdown=new_button(h.sp22,'Down',[0 0 40 20]);
under(h.btn_attitudesequencemoveelementdown,h.btn_attitudesequencemoveelementup,5);

h.btn_attitudesequencedeleteelement=new_button(h.sp22,'Delete',[100 10 100 20]);
h.btn_attitudesequenceaddelement=new_button(h.sp22,'Add/Update',[250 10 100 20]);
rightof(h.btn_attitudesequenceaddelement,h.btn_attitudesequencedeleteelement,10);

if ~isempty(all_attitude_configs)
    configs=all_attitude_configs.values;
    UpdateAttitudeTabFromConfig(configs{1},h);
end