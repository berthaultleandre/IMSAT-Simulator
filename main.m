function main()
    %% Main
    
    warning('off','all')
    
    close all
    clear variables
    clc
    
    % Create data
    data = CreateData();
    
    % Create interface
    gui  = CreateInterface(data);

    % Update the GUI with default data
    UpdateInterface();    
 
    %% Data creation
    function data = CreateData()
        data = GetData();
    end

    %% Interface creation
    function gui = CreateInterface(data)
        gui = struct();
    
        % Open a window and add some menus
        gui.window = figure(...
            'Name', 'IMSAT Simulator', ...
            'NumberTitle', 'off', ...
            'MenuBar', 'none', ...
            'Toolbar', 'none', ...
            'Unit','normalized',...
            'Position',[0 0 1 1],...
            'outerposition',[0 0 1 1]);
        
        % File menu
        gui.fileMenu = uimenu(gui.window, 'Label', 'File');
        uimenu(gui.fileMenu, 'Label', 'Exit', 'Callback', @OnExit);
        
        gui.tabgp = uitabgroup(gui.window,'Position',[0 0 1 1]);
        gui.tab1 = uitab(gui.tabgp,'Title','General');
        gui.tab2 = uitab(gui.tabgp,'Title','Attitude');
        gui.tab3 = uitab(gui.tabgp,'Title','Simulation');
        gui.tab4 = uitab(gui.tabgp,'Title','Animation');
        gui.tab4.Parent=[];
        
        CreateTab1();
        CreateTab2();
        CreateTab3();
        CreateTab4();
        
        CreateControls();
        
        function CreateTab1()
            gui.layout1 = uix.VBox('Parent', gui.tab1);

            %% Panel 0 : Config

            gui.layout10 = uix.BoxPanel('Parent',gui.layout1,'Title','Config','FontSize',10,...
                                        'BorderType','etchedin','Padding',20);

            gui.layout101=uix.HBox('Parent', gui.layout10, 'Spacing', 20);
            
            gui.txt_generalconfig=new_text(gui.layout101,'Config');
            gui.spn_generalconfig=new_spinner(gui.layout101,data.configs.general.keys);
       
            gui.layout1011=uix.HButtonBox('Parent', gui.layout101, 'Spacing', 20);
            
            gui.btn_updategeneralconfig=new_button(gui.layout1011,'Update');
            gui.btn_deletegeneralconfig=new_button(gui.layout1011,'Delete');
            
            gui.txt_creategeneralconfig=new_text(gui.layout101,'New config name');
            gui.ed_creategeneralconfig=new_edit(gui.layout101,'');
            
            gui.layout1012=uix.HButtonBox('Parent', gui.layout101, 'Spacing', 20);
            
            gui.btn_creategeneralconfig=new_button(gui.layout1012,'Create');
            
            set(gui.layout101, 'Widths', [100 150 150 100 100 100]);

            %% Panel 1 : Spacecraft

            gui.layout11 = uix.BoxPanel('Parent',gui.layout1,'Title','Spacecraft','FontSize',10,...
                                        'BorderType','etchedin','Padding',20);
                                    
            gui.layout111 = uix.VBox('Parent',gui.layout11,'Spacing',20);

            gui.layout1111 = uix.HBox('Parent',gui.layout111,'Spacing',20);
            
            gui.txt_spacecraft=new_text(gui.layout1111,'Spacecraft');
            gui.spn_spacecraft=new_spinner(gui.layout1111,data.spacecrafts.keys);
            
            gui.txt_spacecraftdim=new_text(gui.layout1111,'Dimensions (m)');
            gui.ed_spacecraftdimx=new_edit(gui.layout1111,'');
            gui.ed_spacecraftdimy=new_edit(gui.layout1111,'');
            gui.ed_spacecraftdimz=new_edit(gui.layout1111,'');

            gui.txt_spacecraftdim.Enable='off';
            gui.ed_spacecraftdimx.Enable='off';
            gui.ed_spacecraftdimy.Enable='off';
            gui.ed_spacecraftdimz.Enable='off';

            gui.txt_spacecraftweight=new_text(gui.layout1111,'Weight (kg)');
            gui.ed_spacecraftweight=new_edit(gui.layout1111,'');
            gui.txt_spacecraftweight.Enable='off';
            gui.ed_spacecraftweight.Enable='off';

            set(gui.layout1111,'Widths',[100 150 100 50 50 50 100 50]);
            
            gui.layout1112 = uix.HBox('Parent',gui.layout111,'Spacing',20);
            
            gui.txt_actuators=new_text(gui.layout1112,'Actuators');
            gui.spn_actuators=new_spinner(gui.layout1112,{'Reaction wheels';'Magnetorquers';'Mix'});

            set(gui.layout1112,'Widths',[100 150]);
            
            set(gui.layout111,'Heights',[25 25]);
            
            %% Panel 2 : Initial conditions set
            gui.layout12 = uix.BoxPanel('Parent',gui.layout1,'Title','Initial conditions set','FontSize',10,...
                                        'BorderType','etchedin','Padding',20);

            gui.layout121 = uix.VBox('Parent',gui.layout12,'Spacing',20);

            gui.layout1211 = uix.HBox('Parent',gui.layout121,'Spacing',20);
            gui.txt_cond0=new_text(gui.layout1211,'Initial conditions set');
            gui.spn_cond0=new_spinner(gui.layout1211,data.initial_conditions_sets.keys);

            set(gui.layout1211, 'Widths', [150 150]);
            
            gui.layout1212 = uix.HBox('Parent',gui.layout121,'Spacing',20);

            gui.txt_cond0altitude=new_text(gui.layout1212,'Initial altitude (km)');
            gui.ed_cond0altitude=new_edit(gui.layout1212,'');
            gui.txt_cond0altitude.Enable='off';
            gui.ed_cond0altitude.Enable='off';

            gui.txt_cond0reci0=new_text(gui.layout1212,'Initial position (km)');
            gui.ed_cond0reci0x=new_edit(gui.layout1212,'');
            gui.ed_cond0reci0y=new_edit(gui.layout1212,'');
            gui.ed_cond0reci0z=new_edit(gui.layout1212,'');
            gui.txt_cond0reci0.Enable='off';
            gui.ed_cond0reci0x.Enable='off';
            gui.ed_cond0reci0y.Enable='off';
            gui.ed_cond0reci0z.Enable='off';

            gui.txt_cond0veci0=new_text(gui.layout1212,'Initial linear velocity (km/s)');
            gui.ed_cond0veci0x=new_edit(gui.layout1212,'');
            gui.ed_cond0veci0y=new_edit(gui.layout1212,'');
            gui.ed_cond0veci0z=new_edit(gui.layout1212,'');
            gui.txt_cond0veci0.Enable='off';
            gui.ed_cond0veci0x.Enable='off';
            gui.ed_cond0veci0y.Enable='off';
            gui.ed_cond0veci0z.Enable='off';
            
            set(gui.layout1212, 'Widths', [150 100 150 100 100 100 150 100 100 100]);
            
            gui.layout1213 = uix.HBox('Parent',gui.layout121,'Spacing',20);

            gui.txt_cond0eulob0deg=new_text(gui.layout1213,'Euler angles orbit to body (deg)');
            gui.ed_cond0eulob0degphi=new_edit(gui.layout1213,'');
            gui.ed_cond0eulob0degtheta=new_edit(gui.layout1213,'');
            gui.ed_cond0eulob0degpsi=new_edit(gui.layout1213,'');
            gui.txt_cond0eulob0deg.Enable='off';
            gui.ed_cond0eulob0degphi.Enable='off';
            gui.ed_cond0eulob0degtheta.Enable='off';
            gui.ed_cond0eulob0degpsi.Enable='off';

            gui.txt_cond0wob0=new_text(gui.layout1213,'Angular velocity orbit to body (rad/s)');
            gui.ed_cond0wob0x=new_edit(gui.layout1213,'');
            gui.ed_cond0wob0y=new_edit(gui.layout1213,'');
            gui.ed_cond0wob0z=new_edit(gui.layout1213,'');
            gui.txt_cond0wob0.Enable='off';
            gui.ed_cond0wob0x.Enable='off';
            gui.ed_cond0wob0y.Enable='off';
            gui.ed_cond0wob0z.Enable='off';

            set(gui.layout1213, 'Widths', [200 100 100 100 200 100 100 100]);
            
            set(gui.layout121, 'Heights', [25 25 25]);
            
            %% Panel 3 : Equilibrium
            gui.layout13 = uix.BoxPanel('Parent',gui.layout1,'Title','Equilibrium','FontSize',10,...
                                        'BorderType','etchedin','Padding',20);

            gui.layout131 = uix.HBox('Parent',gui.layout13,'Spacing',20);

            gui.txt_attitudewchap=new_text(gui.layout131,'Equilibrium angular velocity orbit to body (rad/s)');
            gui.ed_attitudewchapx=new_edit(gui.layout131,'');
            gui.ed_attitudewchapy=new_edit(gui.layout131,'');
            gui.ed_attitudewchapz=new_edit(gui.layout131,'');

            gui.txt_attitudehchap=new_text(gui.layout131,'Equilibrium wheels angular momentum (kg.m2/s)');
            gui.ed_attitudehchapx=new_edit(gui.layout131,'');
            gui.ed_attitudehchapy=new_edit(gui.layout131,'');
            gui.ed_attitudehchapz=new_edit(gui.layout131,'');

            set(gui.layout131,'Widths',[150 100 100 100 150 100 100 100]);
            
            %% Panel 4 : Animation config

            gui.layout14 = uix.BoxPanel('Parent',gui.layout1,'Title','Animation config','FontSize',10,...
                                        'BorderType','etchedin','Padding',20);

            gui.layout141 = uix.HBox('Parent',gui.layout14,'Spacing',20);

            gui.layout1411 = uix.VBox('Parent',gui.layout141,'Spacing',20);

            gui.layout14111 = uix.HBox('Parent',gui.layout1411,'Spacing',20);

            gui.txt_animspeed=new_text(gui.layout14111,'Animation speed');
            gui.ed_animspeed=new_edit(gui.layout14111,'');

            gui.layout14112 = uix.HBox('Parent',gui.layout1411,'Spacing',20);

            gui.txt_spacecraftsize=new_text(gui.layout14112,'Spacecraft size');
            gui.ed_spacecraftsize=new_edit(gui.layout14112,'');

            gui.layout14113 = uix.HBox('Parent',gui.layout1411,'Spacing',20);

            gui.txt_arrowlen=new_text(gui.layout14113,'Arrow length');
            gui.ed_arrowlen=new_edit(gui.layout14113,'');

            gui.layout14114 = uix.HBox('Parent',gui.layout1411,'Spacing',20);

            gui.txt_linelen=new_text(gui.layout14114,'Line length');
            gui.ed_linelen=new_edit(gui.layout14114,'');

            gui.layout14115 = uix.HBox('Parent',gui.layout1411,'Spacing',20);

            gui.txt_axislimitratio=new_text(gui.layout14115,'Axis limit ratio');
            gui.ed_axislimitratio=new_edit(gui.layout14115,'');

            gui.layout14116 = uix.HBox('Parent',gui.layout1411,'Spacing',20);

            gui.txt_radiusratio=new_text(gui.layout14116,'Radius ratio');
            gui.ed_radiusratio=new_edit(gui.layout14116,'');

            set(gui.layout1411,'Heights',[25 25 25 25 25 25]);
            
            gui.layout1412 = uix.VBox('Parent',gui.layout141,'Spacing',20);

            gui.layout14121 = uix.HButtonBox('Parent',gui.layout1412,'Spacing',20);
            gui.cbx_savevideo=new_checkbox(gui.layout14121,'Save video');
            gui.cbx_savevideo.Value=0;
            data.enable_video_config=onoff(0);
            
            set(gui.layout14121, 'ButtonSize', [130 35]);

            gui.layout14122 = uix.HBox('Parent',gui.layout1412,'Spacing',20);

            gui.txt_videoname=new_text(gui.layout14122,'Video name');
            gui.ed_videoname=new_edit(gui.layout14122,'');
            gui.txt_videoname.Enable=data.enable_video_config;
            gui.ed_videoname.Enable=data.enable_video_config;

            gui.layout14123 = uix.HBox('Parent',gui.layout1412,'Spacing',20);

            gui.txt_videoformat=new_text(gui.layout14123,'Video format');
            gui.ed_videoformat=new_edit(gui.layout14123,'');
            gui.txt_videoformat.Enable=data.enable_video_config;
            gui.ed_videoformat.Enable=data.enable_video_config;

            gui.layout14124 = uix.HBox('Parent',gui.layout1412,'Spacing',20);

            gui.txt_videoframerate=new_text(gui.layout14124,'Frame rate');
            gui.ed_videoframerate=new_edit(gui.layout14124,'');
            gui.txt_videoframerate.Enable=data.enable_video_config;
            gui.ed_videoframerate.Enable=data.enable_video_config;
            
            set(gui.layout1412,'Height',[25 25 25 25]);
            
            set(gui.layout141,'Widths',[300 300]);
            
            %% Global
            set(gui.layout1,'Heights',[95 150 200 95 -1]);
        end

        function CreateTab2()
            gui.layout2 = uix.VBox('Parent', gui.tab2);

            %% Panel 0 : Config

            gui.layout20 = uix.BoxPanel('Parent',gui.layout2,'Title','Config','FontSize',10,...
                                        'BorderType','etchedin','Padding',20);

            gui.layout201=uix.HBox('Parent', gui.layout20, 'Spacing', 20);
            
            gui.txt_attitudeconfig=new_text(gui.layout201,'Config');
            gui.spn_attitudeconfig=new_spinner(gui.layout201,data.configs.attitude.keys);
       
            gui.layout2011=uix.HButtonBox('Parent', gui.layout201, 'Spacing', 20);
            
            gui.btn_updateattitudeconfig=new_button(gui.layout2011,'Update');
            gui.btn_deleteattitudeconfig=new_button(gui.layout2011,'Delete');
            
            gui.txt_createattitudeconfig=new_text(gui.layout201,'New config name');
            gui.ed_createattitudeconfig=new_edit(gui.layout201,'');
            
            gui.layout2012=uix.HButtonBox('Parent', gui.layout201, 'Spacing', 20);
            
            gui.btn_createattitudeconfig=new_button(gui.layout2012,'Create');
            
            set(gui.layout201, 'Widths', [100 150 150 100 100 100]);
            
            %% Panel 1 : Elementary conditions
            gui.layout21 = uix.HBox('Parent',gui.layout2);
            
            gui.layout211 = uix.VBox('Parent',gui.layout21);
                        
            gui.layout2111 = uix.BoxPanel('Parent',gui.layout211,'Title','Conditions','FontSize',10,...
                                        'BorderType','etchedin');
                                    
            gui.tbl_attitudeelementaryconditions=uitable(gui.layout2111);
            %gui.tbl_attitudeelementaryconditions.Position=[20 20 350 320];
            gui.tbl_attitudeelementaryconditions.ColumnName = {'Name','Type','Parameters'};
            tablecolumnwidth=gui.tbl_attitudeelementaryconditions.Position(3)/length(gui.tbl_attitudeelementaryconditions.ColumnName);
            gui.tbl_attitudeelementaryconditions.ColumnWidth={tablecolumnwidth/2-2};
            gui.tbl_attitudeelementaryconditions.RowName={};
            gui.tbl_attitudeelementaryconditions.ColumnEditable = [false false false];

            gui.layout2112 = uix.BoxPanel('Parent',gui.layout211,'Title','Condition definition','FontSize',10,...
                          'BorderType','etchedin','Padding',20);

            gui.layout21121 = uix.VBox('Parent',gui.layout2112,'Spacing',3);
            
            gui.layout211211 = uix.VBox('Parent',gui.layout21121,'Spacing',20,'Padding',20);
            
            gui.layout2112111 = uix.HBox('Parent',gui.layout211211,'Spacing',3);
            
            gui.txt_attitudeconditiondefinitionname=new_text(gui.layout2112111,'Name');
            gui.ed_attitudeconditiondefinitionname=new_edit(gui.layout2112111,'');

            set(gui.layout2112111,'Widths',[100 150]);
            
            gui.layout2112112 = uix.HBox('Parent',gui.layout211211,'Spacing',3);
            
            gui.txt_attitudeconditiondefinitiontype=new_text(gui.layout2112112,'Type');
            gui.spn_attitudeconditiondefinitiontype=new_spinner(gui.layout2112112,{'Time';'Latitude';'Longitude'});

            set(gui.layout2112112,'Widths',[100 150]);
            
            set(gui.layout211211,'Heights',[25 25]);
            
            gui.layout211212 = uix.HButtonBox('Parent',gui.layout21121,'Spacing',3);
            
            gui.btn_attitudeconditiondefinitiondelete=new_button(gui.layout211212,'Delete');
            gui.btn_attitudeconditiondefinitionvalidate=new_button(gui.layout211212,'Add/Update');
            
            %set(gui.layout21121,'Heights',[180 90]);
            
            %set(gui.layout211,'Heights',[500 -1]);
            
            %% Panel 2 : Attitude sequence
            gui.layout212 = uix.VBox('Parent',gui.layout21,'Spacing',3);
            
            gui.layout2121 = uix.BoxPanel('Parent',gui.layout212,'Title','Table','FontSize',10,...
                                        'BorderType','etchedin');
            gui.tbl_attitudesequence=uitable(gui.layout2121);
            %gui.tbl_attitudesequence.Position=[20 322 350 320];
            gui.tbl_attitudesequence.ColumnName = {'Priority','Condition','Law','Parameters'};
            tablecolumnwidth=gui.tbl_attitudesequence.Position(3)/length(gui.tbl_attitudesequence.ColumnName);
            gui.tbl_attitudesequence.ColumnWidth={tablecolumnwidth-1};
            gui.tbl_attitudesequence.RowName={};
            gui.tbl_attitudesequence.ColumnEditable = [false false false false];
            
            gui.layout2122 = uix.BoxPanel('Parent',gui.layout212,'Title','Element definition','FontSize',10,...
                          'BorderType','etchedin','Padding',20);

            gui.layout21221 = uix.VBox('Parent',gui.layout2122,'Spacing',20,'Padding',20);
            
            gui.layout212211 = uix.HBox('Parent',gui.layout21221,'Spacing',20);
            
            gui.txt_attitudesequencepriority=new_text(gui.layout212211,'Priority');
            gui.spn_attitudesequencepriority=new_spinner(gui.layout212211,{1;2;3});

            set(gui.layout212211,'Widths',[100 150]);
            
            gui.layout212212 = uix.HBox('Parent',gui.layout21221,'Spacing',20);
            
            gui.txt_attitudesequenceconditionname=new_text(gui.layout212212,'Condition');
            gui.spn_attitudesequenceconditionname1=new_spinner(gui.layout212212,{});
            
            gui.spn_attitudesequenceconditionoperator1=new_spinner(gui.layout212212,{'and','or'});
            gui.spn_attitudesequenceconditionname2=new_spinner(gui.layout212212,{});
            
            gui.spn_attitudesequenceconditionoperator2=new_spinner(gui.layout212212,{'and','or'});
            gui.spn_attitudesequenceconditionname3=new_spinner(gui.layout212212,{});
            
            set(gui.layout212212,'Widths',[100 100 50 100 50 100]);
            
            gui.layout212213 = uix.HBox('Parent',gui.layout21221,'Spacing',20);
             
            gui.txt_attitudesequencelaw=new_text(gui.layout212213,'Law');
            gui.spn_attitudesequencelaw=new_spinner(gui.layout212213,{'Nadir Pointing','Base Pointing','Solar Pointing'});
            
            set(gui.layout212213,'Widths',[100 150]);
            
            gui.layout212214 = uix.VBox('Parent',gui.layout21221,'Spacing',3);
            
            gui.layout212215 = uix.HButtonBox('Parent',gui.layout21221,'Spacing',3);
            
            gui.btn_attitudesequencemoveelementup=new_button(gui.layout212215,'Up');
            gui.btn_attitudesequencemoveelementdown=new_button(gui.layout212215,'Down');
            gui.btn_attitudesequencedeleteelement=new_button(gui.layout212215,'Delete');
            gui.btn_attitudesequenceaddelement=new_button(gui.layout212215,'Add/Update');
            
            %% Global
            set(gui.layout2,'Heights',[95 -1]);
            
        end
        
        function CreateTab3() 
            gui.layout3 = uix.VBox('Parent', gui.tab3, 'Spacing', 20);

            gui.layout31 = uix.HBox('Parent',gui.layout3);
            
            gui.layout311 = uix.BoxPanel('Parent',gui.layout31,'Title','Simulation','FontSize',10,...
                                        'BorderType','etchedin','Padding',20);
                                    
            gui.layout3111 = uix.VBox('Parent',gui.layout311,'Spacing',20);
            
            gui.layout31111 = uix.HBox('Parent',gui.layout3111,'Spacing',20);
            def_sim_time=10;
            gui.txt_simtime=new_text(gui.layout31111,'Simulation time (s)');
            gui.ed_simtime=new_edit(gui.layout31111,num2str(def_sim_time));
            
            set(gui.layout31111,'Widths',[100 100]);
            
            gui.layout31112 = uix.HButtonBox('Parent',gui.layout3111);
            gui.btn_startsim=new_button(gui.layout31112,'Start Simulation');
            
            set(gui.layout31112,'ButtonSize', [130 35]);
            
            set(gui.layout3111,'Heights',[25 20]);
            
            gui.layout312 = uix.HBox('Parent',gui.layout31,'Spacing',3);
            
            set(gui.layout31,'Widths',[290 -1]);
            
            gui.layout32 = uix.HBox('Parent',gui.layout3);
            
            set(gui.layout3,'Heights',[140 -1]);
        end
        
        function CreateTab4()
            gui.layout4 = uix.VBox('Parent', gui.tab4, 'Spacing', 3);

            gui.layout41 = uix.HBox('Parent', gui.layout4, 'Spacing', 3, 'Padding', 100);
            axis vis3d
            gui.ax_anim=axes(gui.layout41);  
            gui.ax_anim.Position=[0.25 0.25 0.5 0.5];
            rotate3d on
            hManager = uigetmodemanager(gui.window);
            hManager.CurrentMode.ModeStateData.textState = 0;
            
            gui.layout411 = uix.VBox('Parent', gui.layout41, 'Spacing', 3);

            gui.ax_gndtrk=axes(gui.layout411);

            gui.ax_eulang=axes(gui.layout411);

            set(gui.layout41,'Widths',[-1 -1]);
            
            gui.layout42 = uix.HButtonBox('Parent',gui.layout4,'Spacing',3);

            gui.btn_pause=new_button(gui.layout42,'Pause');
            gui.btn_pause.Enable='off';
            gui.btn_stop=new_button(gui.layout42,'Stop');
            gui.btn_stop.Enable='off';

            gui.layout4.Heights=[-4 -1];
        end
        
        function CreateControls()
            %% Tab 1
            gui.btn_updategeneralconfig.Callback=...
                {@OnPressed_UpdateGeneralConfig};
            gui.btn_deletegeneralconfig.Callback=...
                {@OnPressed_DeleteGeneralConfig};
            gui.btn_creategeneralconfig.Callback=...
                {@OnPressed_CreateGeneralConfig};
            gui.spn_generalconfig.Callback=...
                {@OnSelectedItem_GeneralConfigSpinner};

            gui.spn_spacecraft.Callback=...
                {@OnSelectedItem_SpacecraftSpinner};
            gui.spn_actuators.Callback=...
                {@OnSelectedItem_ActuatorsSpinner};
            gui.spn_cond0.Callback=...
                {@OnSelectedItem_Cond0Spinner};

            gui.cbx_savevideo.Callback=...
                {@OnChecked_SaveVideoCheckbox};

            gui.ed_attitudewchapx.Callback={@OnEdited_GeneralTab};
            gui.ed_attitudewchapy.Callback={@OnEdited_GeneralTab};
            gui.ed_attitudewchapz.Callback={@OnEdited_GeneralTab};

            gui.ed_attitudehchapx.Callback={@OnEdited_GeneralTab};
            gui.ed_attitudehchapy.Callback={@OnEdited_GeneralTab};
            gui.ed_attitudehchapz.Callback={@OnEdited_GeneralTab};

            gui.ed_animspeed.Callback={@OnEdited_GeneralTab};
            gui.ed_spacecraftsize.Callback={@OnEdited_GeneralTab};
            gui.ed_arrowlen.Callback={@OnEdited_GeneralTab};
            gui.ed_linelen.Callback={@OnEdited_GeneralTab};
            gui.ed_axislimitratio.Callback={@OnEdited_GeneralTab};
            gui.ed_radiusratio.Callback={@OnEdited_GeneralTab};
            gui.ed_videoname.Callback={@OnEdited_GeneralTab};
            gui.ed_videoformat.Callback={@OnEdited_GeneralTab};
            gui.ed_videoframerate.Callback={@OnEdited_GeneralTab};
            
            %% Tab 2
            gui.btn_updateattitudeconfig.Callback=...
                {@OnPressed_UpdateAttitudeConfig};
            gui.btn_deleteattitudeconfig.Callback=...
                {@OnPressed_DeleteAttitudeConfig};
            gui.btn_createattitudeconfig.Callback=...
                {@OnPressed_CreateAttitudeConfig};
            gui.spn_attitudeconfig.Callback=...
                {@OnSelectedItem_AttitudeConfigSpinner};

            gui.tbl_attitudeelementaryconditions.CellSelectionCallback=...
                {@OnSelectedItem_ElementaryConditionsTable};
            gui.spn_attitudeconditiondefinitiontype.Callback=...
                {@OnSelectedItem_AttitudeConditionDefinitionTypeSpinner};
            gui.btn_attitudeconditiondefinitiondelete.Callback=...
                {@OnPressed_RemoveConditionDefinitionButton};
            gui.btn_attitudeconditiondefinitionvalidate.Callback=...
                {@OnPressed_ValidateConditionDefinitionButton};

            gui.tbl_attitudesequence.CellSelectionCallback=...
                {@OnSelectedItem_ScenarioTable};
            gui.spn_attitudesequencepriority.Callback=...
                {@OnSelectedItem_AttitudeSequencePrioritySpinner};
            gui.spn_attitudesequencelaw.Callback=...
                {@OnSelectedItem_AttitudeSequenceLawSpinner};
            gui.btn_attitudesequencemoveelementup.Callback=...
                {@OnPressed_MoveAttitudeSequenceElementButton, -1};
            gui.btn_attitudesequencemoveelementdown.Callback=...
                {@OnPressed_MoveAttitudeSequenceElementButton, +1};
            gui.btn_attitudesequencedeleteelement.Callback=...
                {@OnPressed_RemoveAttitudeSequenceElementButton};
            gui.btn_attitudesequenceaddelement.Callback=...
                {@OnPressed_AddAttitudeSequenceElementButton};
            
            %% Tab 3
            gui.btn_startsim.Callback=...
                {@OnPressed_StartSimulationButton};

            %% Tab 4
            gui.btn_pause.Callback=...
                {@OnPressed_PauseAnimationButton};
            gui.btn_stop.Callback=...
                {@OnPressed_StopAnimationButton};
        end
    end

    %% Control callbacks
    % Tab 1
    function OnPressed_CreateGeneralConfig(~,~)
        name=gui.ed_creategeneralconfig.String;
        if ~ismember(name,data.configs.general.keys)
            CreateOrUpdateGeneralConfig(name);
        end
    end
    function OnPressed_UpdateGeneralConfig(~,~)
        name=spnstr(gui.spn_generalconfig);
        CreateOrUpdateGeneralConfig(name);
    end
    function OnChecked_SaveVideoCheckbox(src,~)
        SetGeneralTabUpdateState(false);
        enable=onoff(src.Value);
        set(gui.txt_videoname,'Enable',enable); 
        set(gui.ed_videoname,'Enable',enable); 
        set(gui.txt_videoformat,'Enable',enable); 
        set(gui.ed_videoformat,'Enable',enable);
        set(gui.txt_videoframerate,'Enable',enable); 
        set(gui.ed_videoframerate,'Enable',enable); 
    end
    function OnEdited_GeneralTab(~,~)
        SetGeneralTabUpdateState(false);
    end
    function OnPressed_DeleteGeneralConfig(~,~)
        name=spnstr(gui.spn_generalconfig);
        DeleteGeneralConfig(name);
    end
    function OnSelectedItem_ActuatorsSpinner(~,~)
        SetGeneralTabUpdateState(false);
        name=spnstr(gui.spn_actuators);
        UpdateActuatorsParameters(name,struct([]));
    end
    function OnSelectedItem_Cond0Spinner(src,~)
        SetGeneralTabUpdateState(false);
        name=spnstr(src);
        UpdateCond0Data(name);
    end
    function OnSelectedItem_GeneralConfigSpinner(~,~)
        UpdateTab1();
    end
    function OnSelectedItem_SpacecraftSpinner(src,~)
        SetGeneralTabUpdateState(false);
        name=spnstr(src);
        UpdateSpacecraftData(name);
    end
    function OnSelectedItem_NumberOfWheelsSpinner(~,~)
        SetGeneralTabUpdateState(false);
        UpdateWheelsConfigurations();
    end

    % Tab 2
    function OnPressed_AddAttitudeSequenceElementButton(~,~)
        global current_scenario
        SetAttitudeTabUpdateState(false);
        condition_name1=spnstr(gui.spn_attitudesequenceconditionname1);
        condition_name1=cast(condition_name1,'char');

        condition_name2=spnstr(gui.spn_attitudesequenceconditionname2);
        condition_name2=cast(condition_name2,'char');

        condition_name3=spnstr(gui.spn_attitudesequenceconditionname3);
        condition_name3=cast(condition_name3,'char');

        operator1=spnstr(gui.spn_attitudesequenceconditionoperator1);

        operator2=spnstr(gui.spn_attitudesequenceconditionoperator2);

        condition=CreateScenarioElementCondition(condition_name1,operator1,condition_name2,operator2,condition_name3);

        law_name=spnstr(gui.spn_attitudesequencelaw);
        param=GetLawParam(law_name,false);

        element=CreateScenarioElement(condition,law_name,param);
        index=num2str(gui.spn_attitudesequencepriority.Value);
        current_scenario(index)=element;

        UpdateScenarioTable();
    end
    function OnPressed_CreateAttitudeConfig(~,~)
        name=gui.ed_createattitudeconfig.String;
        if ~ismember(name,data.configs.attitude.keys)
            CreateOrUpdateAttitudeConfig(name);
        end
    end
    function OnPressed_DeleteAttitudeConfig(~,~)
        name=spnstr(gui.spn_attitudeconfig);
        DeleteAttitudeConfig(name);
    end
    function OnPressed_MoveAttitudeSequenceElementButton(~,~,dir)
        global current_scenario
        priority=gui.spn_attitudesequencepriority.Value;
        key=num2str(priority);
        priority2=priority+dir;
        if ~(((priority == 1 || priority > length(current_scenario)) && dir == -1) || ...
                (priority >= length(current_scenario) && dir == +1))
            SetAttitudeTabUpdateState(false);
            key2=num2str(priority+dir);
            temp=current_scenario(key);
            current_scenario(key)=current_scenario(key2);
            current_scenario(key2)=temp;
            gui.spn_attitudesequencepriority.Value=priority2;        
            UpdateScenarioTable();
        end
    end
    function OnPressed_RemoveAttitudeSequenceElementButton(~,~)
        global current_scenario
        SetAttitudeTabUpdateState(false);
        priority=gui.spn_attitudesequencepriority.Value;
        key=num2str(priority);
        remove(current_scenario,key);
        if length(current_scenario)-priority>=0
            for i=priority:length(scenario)
                current_scenario(int2str(i))=current_scenario(int2str(i+1));
                remove(current_scenario,int2str(i+1));
            end
        end
        UpdateScenarioTable();
        if priority>1
            gui.spn_attitudesequencepriority.Value=priority-1;
        else
            gui.spn_attitudesequencepriority.Value=1;
        end
    end
    function OnPressed_RemoveConditionDefinitionButton(~,~)
        global current_conditions
        name=gui.ed_attitudeconditiondefinitionname.String;
        if isKey(current_conditions,name)
            SetAttitudeTabUpdateState(false);
            remove(current_conditions,name);    

            conditions=current_conditions.values;
            if ~isempty(conditions)
                condition=conditions{1};
                name=condition.Name;
                type=condition.Type;
                param=condition.Parameters;
            else
                name='';
                type='Time';
                param=struct([]);
            end

            UpdateConditionDefinitionParameters(name,type,param);
            UpdateElementaryConditions();
        end
    end
    function OnPressed_UpdateAttitudeConfig(~,~)
        name=spnstr(gui.spn_attitudeconfig);
        CreateOrUpdateAttitudeConfig(name);
    end
    function OnPressed_ValidateConditionDefinitionButton(~,~)
        global current_conditions
        SetAttitudeTabUpdateState(false);
        ha=guidata(gui.tbl_attitudeelementaryconditions);
        type=spnstr(gui.spn_attitudeconditiondefinitiontype);
        name=gui.ed_attitudeconditiondefinitionname.String;
        param=GetConditionParam(type);
        new_condition=CreateCondition(name,type,param);
        current_conditions(name)=new_condition;
        UpdateElementaryConditions();
    end
    function OnSelectedItem_AttitudeConditionDefinitionTypeSpinner(~,~)
        name=gui.ed_attitudeconditiondefinitionname.String;
        type=spnstr(gui.spn_attitudeconditiondefinitiontype);
        param=struct([]);
        UpdateConditionDefinitionParameters(name,type,param);
    end
    function OnSelectedItem_AttitudeConfigSpinner(~,~)
        UpdateTab2();
    end
    function OnSelectedItem_AttitudeSequenceLawSpinner(~,~)
        law_name=spnstr(gui.spn_attitudesequencelaw);
        param=GetLawParam(law_name,true);
        UpdateScenarioElementDefinitionParametersAux(law_name,param);
    end
    function OnSelectedItem_AttitudeSequencePrioritySpinner(~,~)
        row=gui.spn_attitudesequencepriority.Value;
        UpdateScenarioElementDefinitionParameters(row);
    end
    function OnSelectedItem_ElementaryConditionsTable(~,event)
        global current_conditions
        indices=event.Indices;
        if length(indices)==2
            row=indices(1);
            col=indices(2);  
            v=current_conditions.values;
            condition=v{row};
            name=condition.Name;
            type=condition.Type;
            param=condition.Parameters;
            UpdateConditionDefinitionParameters(name,type,param);
        end
    end
    function OnSelectedItem_ScenarioTable(~,event)
        indices=event.Indices;
        if length(indices)==2
            row=indices(1);
            UpdateScenarioElementDefinitionParameters(row);
        end
    end

    % Tab 3
    function OnPressed_StartSimulationButton(~,~)
        if isfield(gui,'ax')
            cla(gui.ax_anim);
            gui.ax_anim.Title.String='';
        end
        gui.tab4.Parent=gui.tabgp;
        gui.tabgp.SelectedTab=gui.tab4;
        data.general_config=GetGeneralConfigFromGUI('');
        data.sim_time=str2double(gui.ed_simtime.String);
        StartSimulation();
        %handles.fig.Visible='off';
    end

    % Tab 4
    function OnPressed_PauseAnimationButton(src,~)
        if strcmpi(get(src, 'String'),'Resume')
            set(src, 'String', 'Pause');
            startTimer(true);
        else
            set(src, 'String', 'Resume');
            pauseTimer();
        end
    end
    function OnPressed_StopAnimationButton(src,~)
        if strcmpi(get(src, 'String'),'Restart')
            set(src, 'String', 'Stop');
            StartAnimation();
        else
            set(src, 'String', 'Restart');
            stopTimer();
            set(gui.btn_pause,'Enable','off'); 
        end
    end

    %% Auxiliary functions
    % Tab 1
    function SetGeneralTabUpdateState(updated)
        if ~updated
            if strcmp(gui.btn_updategeneralconfig.Enable,'off')
                gui.btn_updategeneralconfig.BackgroundColor=[0.94 0.94 0.94];
                gui.btn_creategeneralconfig.BackgroundColor='red';
            else
                gui.btn_creategeneralconfig.BackgroundColor=[0.94 0.94 0.94];
                gui.btn_updategeneralconfig.BackgroundColor='red';
            end
        else
            if strcmp(gui.btn_updategeneralconfig.Enable,'off')
                gui.btn_updategeneralconfig.BackgroundColor=[0.94 0.94 0.94];
                gui.btn_creategeneralconfig.BackgroundColor=[0.94 0.94 0.94];
            else
                gui.btn_creategeneralconfig.BackgroundColor=[0.94 0.94 0.94];
                gui.btn_updategeneralconfig.BackgroundColor=[0.94 0.94 0.94];
            end
        end
    end
    function UpdateActuatorsGUI(name,param)
        if strcmp(name,'Reaction wheels') || strcmp(name,'Mix')
            txt_numberofwheels=new_text(gui.layout1112,'Number of wheels');
            spn_numberofwheels=new_spinner(gui.layout1112,{3;4});
            spn_numberofwheels.Callback={@OnSelectedItem_NumberOfWheelsSpinner};
            txt_wheelsconfig=new_text(gui.layout1112,'Wheels configuration');
            spn_wheelsconfig=new_spinner(gui.layout1112,data.wheels_configurations.keys);
            spn_wheelsconfig.Callback={@OnEdited_GeneralTab};
            
            set(gui.layout1112,'Widths',[100 150 150 50 150 100]);
            
            gui.actuatorsgui=containers.Map;
            gui.actuatorsgui('txt_numberofwheels')=txt_numberofwheels;
            gui.actuatorsgui('spn_numberofwheels')=spn_numberofwheels;
            gui.actuatorsgui('txt_wheelsconfig')=txt_wheelsconfig;
            gui.actuatorsgui('spn_wheelsconfig')=spn_wheelsconfig;
            
            if ~isempty(param)
                number_of_wheels_str=num2str(param.number_of_wheels);
                wheels_config_name=param.wheels_config;
                strfnd(spn_numberofwheels,number_of_wheels_str);
            end       
            
            UpdateWheelsConfigurations();
            
            if ~isempty(param)
                spn_wheelsconfig.Value=find(strcmp(spn_wheelsconfig.String,wheels_config_name));
            end
        end
    end
    function UpdateWheelsConfigurations()
        actuatorsgui=gui.actuatorsgui;
        spn_numberofwheels=gui.actuatorsgui('spn_numberofwheels');
        spn_wheelsconfig=gui.actuatorsgui('spn_wheelsconfig');
        number_of_wheels=str2double(spnstr(spn_numberofwheels)); 
        all_wheels_configs=data.wheels_configurations.values;
        wheels_configs_names={};
        j=1;
        for i=1:length(all_wheels_configs)
           if all_wheels_configs{i}.number_of_wheels == number_of_wheels
               wheels_configs_names{j}=all_wheels_configs{i}.name;
               j=j+1;
           end
        end
        spn_wheelsconfig.String=wheels_configs_names; 
    end
    function UpdateActuatorsParameters(name,param)
        strfnd(gui.spn_actuators,name);
        %gui.spn_actuators.Value=find(strcmp(gui.spn_actuators.String,name));
         if isfield(gui,'actuatorsgui')
            keys=gui.actuatorsgui.keys;
            for i=1:length(keys)
                delete(gui.actuatorsgui(keys{i}));
            end
        end
        UpdateActuatorsGUI(name,param);
    end
    function DeleteGeneralConfig(name)
        if ~strcmp(name, 'Default')
            remove(data.configs.general,name);
            configs=data.configs.general;
            save('configs/general_configs.mat','configs');
            gui.spn_generalconfig.String=data.configs.general.keys;
            gui.spn_generalconfig.Value=find(strcmp(gui.spn_generalconfig.String,'Default'));
            UpdateTab1();
        end
    end
    function config=GetGeneralConfigFromGUI(name)
        actuators=containers.Map;
        actuators_name=spnstr(gui.spn_actuators);
        actuators('name')=actuators_name;

        if strcmp(actuators_name,'Reaction wheels') || strcmp(actuators_name,'Mix')
            actuators('parameters')=struct('number_of_wheels',str2double(spnstr(gui.actuatorsgui('spn_numberofwheels'))),...
                'wheels_config',spnstr(gui.actuatorsgui('spn_wheelsconfig')));
        else
            actuators('parameters')=struct([]);
        end

        config=struct('name',name,...
            'spacecraft_name',spnstr(gui.spn_spacecraft),...
            'actuators',actuators,...
            'cond0_name',spnstr(gui.spn_cond0),...
            'attitude_wchap',[str2double(gui.ed_attitudewchapx.String);...
                              str2double(gui.ed_attitudewchapy.String);...
                              str2double(gui.ed_attitudewchapz.String)],...
            'attitude_hchap',[str2double(gui.ed_attitudehchapx.String);...
                              str2double(gui.ed_attitudehchapy.String);...
                              str2double(gui.ed_attitudehchapz.String)],...
            'anim_animation_speed',str2double(gui.ed_animspeed.String),...
            'anim_spacecraft_size',str2double(gui.ed_spacecraftsize.String),...
            'anim_arrow_len',str2double(gui.ed_arrowlen.String),...
            'anim_line_len',str2double(gui.ed_linelen.String),...
            'anim_axis_limit_ratio',str2double(gui.ed_axislimitratio.String),...
            'r_ratio',str2double(gui.ed_radiusratio.String),...
            'anim_save_video',gui.cbx_savevideo.Value,...
            'anim_video_name',gui.ed_videoname.String,...
            'anim_video_format',gui.ed_videoformat.String,...
            'anim_video_frame_rate',str2double(gui.ed_videoframerate.String));
    end
    function UpdateCond0Data(name)
        cond0=data.initial_conditions_sets(name);
        set(gui.ed_cond0eulob0degphi,'String',num2str(cond0.eul_o_b_0_deg(1)));
        set(gui.ed_cond0eulob0degtheta,'String',num2str(cond0.eul_o_b_0_deg(2)));
        set(gui.ed_cond0eulob0degpsi,'String',num2str(cond0.eul_o_b_0_deg(3)));

        set(gui.ed_cond0wob0x,'String',num2str(cond0.w_o_b_0(1)));
        set(gui.ed_cond0wob0y,'String',num2str(cond0.w_o_b_0(2)));
        set(gui.ed_cond0wob0z,'String',num2str(cond0.w_o_b_0(3)));

        set(gui.ed_cond0reci0x,'String',num2str(floor(cond0.r_eci_0(1)/1000)));
        set(gui.ed_cond0reci0y,'String',num2str(floor(cond0.r_eci_0(2)/1000)));
        set(gui.ed_cond0reci0z,'String',num2str(floor(cond0.r_eci_0(3)/1000)));

        set(gui.ed_cond0veci0x,'String',num2str(floor(cond0.v_eci_0(1))));
        set(gui.ed_cond0veci0y,'String',num2str(floor(cond0.v_eci_0(2))));
        set(gui.ed_cond0veci0z,'String',num2str(floor(cond0.v_eci_0(3))));

        set(gui.ed_cond0altitude,'String',num2str(floor((norm(cond0.r_eci_0)-data.constants.re_m)/1000)));
    end
    function UpdateSpacecraftData(name)
        spacecraft=data.spacecrafts(name);
        set(gui.ed_spacecraftdimx,'String',num2str(spacecraft.dim(1)));
        set(gui.ed_spacecraftdimy,'String',num2str(spacecraft.dim(2)));
        set(gui.ed_spacecraftdimz,'String',num2str(spacecraft.dim(3)));
        set(gui.ed_spacecraftweight,'String',num2str(spacecraft.m));
    end
    function CreateOrUpdateGeneralConfig(name)
        if ~isempty(name) && ~strcmp(name,'Default')
            SetGeneralTabUpdateState(true);
            new_general_config=GetGeneralConfigFromGUI(name);
            data.configs.general(name)=new_general_config;
            gui.spn_generalconfig.String=data.configs.general.keys;
            strfnd(gui.spn_generalconfig,name);
            configs=data.configs.general;
            save('configs/general_configs.mat','configs');
            UpdateTab1();
        end
    end

    % Tab 2
    function CreateOrUpdateAttitudeConfig(name)
        global current_conditions current_scenario
        if ~isempty(name) && ~strcmp(name,'Default')
            SetAttitudeTabUpdateState(true);
            conditions=current_conditions;
            scenario=current_scenario;
            new_attitude_config=struct('name',name,...
            'conditions',conditions,...
            'scenario',scenario);
            data.configs.attitude(name)=new_attitude_config;
            configs=data.configs.attitude;
            save('configs/attitude_configs.mat','configs');
            gui.spn_attitudeconfig.String=configs.keys;
            strfnd(gui.spn_attitudeconfig,name);
            UpdateTab2();
        end
    end
    function DeleteAttitudeConfig(name)
        if ~strcmp(name, 'Default')
            remove(data.configs.attitude,name);
            configs=data.configs.attitude;
            save('configs/attitude_configs.mat','configs');
            gui.spn_attitudeconfig.String=data.configs.attitude.keys;
            gui.spn_attitudeconfig.Value=1;
            UpdateTab2();
        end
    end
    function param=GetConditionParam(type)
        conditiongui=gui.conditiongui;
        if strcmp(type,'Time')
            startTime=str2double(conditiongui('ed_attitudeconditiontimestart').String);
            endTime=str2double(conditiongui('ed_attitudeconditiontimeend').String);
            param=struct('StartTime',startTime,'EndTime',endTime);
        elseif strcmp(type,'Latitude')
            latitudeMin=str2double(conditiongui('ed_attitudeconditionlatitudemin').String);
            latitudeMax=str2double(conditiongui('ed_attitudeconditionlatitudemax').String);
            param=struct('LatitudeMin',latitudeMin,'LatitudeMax',latitudeMax);
        elseif strcmp(type,'Longitude')
            longitudeMin=str2double(conditiongui('ed_attitudeconditionlongitudemin').String);
            longitudeMax=str2double(conditiongui('ed_attitudeconditionlongitudemax').String);
            param=struct('LongitudeMin',longitudeMin,'LongitudeMax',longitudeMax);
        end
    end
    function param_str=GetConditionParamStr(type,param)
        if strcmp(type,'Time')
            param_str=strcat(num2str(param.StartTime),', ',num2str(param.EndTime));
        elseif strcmp(type,'Latitude')
            param_str=strcat(num2str(param.LatitudeMin),', ',num2str(param.LatitudeMax));
        elseif strcmp(type,'Longitude')
            param_str=strcat(num2str(param.LongitudeMin),', ',num2str(param.LongitudeMax));
        end
    end
    function param=GetLawParam(law_name,default)
        all_bases_name=data.bases.keys;
        if strcmp(law_name,'Base Pointing')
            if default
                param=struct('Base',all_bases_name(1));
            else
                tab=gui.tbl_attitudesequence;
                ha=guidata(tab);
                if isfield(ha,'scenarioelementgui')
                    scenarioelementgui=ha.scenarioelementgui;
                    spn=scenarioelementgui('spn_scenarioelementbase');
                    base_name=spnstr(spn);
                    param=struct('Base',base_name);
                else
                    param=struct('Base',all_bases_name(1));
                end
            end
        elseif strcmp(law_name,'Nadir Pointing')
            param=struct([]);
        elseif strcmp(law_name,'Solar Pointing')
            param=struct([]);
        end
    end
    function param_str=GetScenarioElementParamStr(law_name,param)
        if strcmp(law_name,'Base Pointing')
            param_str=param.Base;
        elseif strcmp(law_name,'Nadir Pointing')
            param_str='None';
        elseif strcmp(law_name,'Solar Pointing')
            param_str='None';
        end
    end
    function SetAttitudeTabUpdateState(updated)
        if ~updated
            if strcmp(gui.btn_updateattitudeconfig.Enable,'off')
                gui.btn_updateattitudeconfig.BackgroundColor=[0.94 0.94 0.94];
                gui.btn_createattitudeconfig.BackgroundColor='red';
            else
                gui.btn_createattitudeconfig.BackgroundColor=[0.94 0.94 0.94];
                gui.btn_updateattitudeconfig.BackgroundColor='red';
            end
        else
            if strcmp(gui.btn_updateattitudeconfig.Enable,'off')
                gui.btn_updateattitudeconfig.BackgroundColor=[0.94 0.94 0.94];
                gui.btn_createattitudeconfig.BackgroundColor=[0.94 0.94 0.94];
            else
                gui.btn_createattitudeconfig.BackgroundColor=[0.94 0.94 0.94];
                gui.btn_updateattitudeconfig.BackgroundColor=[0.94 0.94 0.94];
            end
        end
    end
    function UpdateAttitudeSequenceConditions()
        global current_conditions
        keys=current_conditions.keys;
        keys=horzcat(' ',keys);
        gui.spn_attitudesequenceconditionname1.String=keys;
        gui.spn_attitudesequenceconditionname1.Value=1;
        gui.spn_attitudesequenceconditionname2.String=keys;
        gui.spn_attitudesequenceconditionname2.Value=1;
        gui.spn_attitudesequenceconditionname3.String=keys;
        gui.spn_attitudesequenceconditionname3.Value=1;
    end
    function UpdateConditionDefinitionParameters(name,type,param)
        gui.ed_attitudeconditiondefinitionname.String=name;
        strfnd(gui.spn_attitudeconditiondefinitiontype,type);
        if isfield(gui,'conditiongui')
            keys=gui.conditiongui.keys;
            for i=1:length(keys)
                delete(gui.conditiongui(keys{i}));
            end
        end
        UpdateConditionGUI(type,param);
    end
    function UpdateConditionGUI(type,param)
        if strcmp(type,'Time')
            
            hbox1=uix.HBox('Parent',gui.layout211211,'Spacing',3);
            
            txt_attitudeconditiontimestart=new_text(hbox1,'Start time');
            ed_attitudeconditiontimestart=new_edit(hbox1,'');
            
            set(hbox1,'Widths',[100 100]);

            hbox2=uix.HBox('Parent',gui.layout211211,'Spacing',3);
            
            txt_attitudeconditiontimeend=new_text(hbox2,'End time');
            ed_attitudeconditiontimeend=new_edit(hbox2,'');
            
            set(hbox2,'Widths',[100 100]);
            
            set(gui.layout211211,'Heights',[25 25 25 25]);
            
            if ~isempty(param)
                ed_attitudeconditiontimestart.String=num2str(param.StartTime);
                ed_attitudeconditiontimeend.String=num2str(param.EndTime);
            end

            gui.conditiongui=containers.Map;
            gui.conditiongui('hbox1')=hbox1;
            gui.conditiongui('hbox2')=hbox2;
            gui.conditiongui('txt_attitudeconditiontimestart')=txt_attitudeconditiontimestart;
            gui.conditiongui('ed_attitudeconditiontimestart')=ed_attitudeconditiontimestart;
            gui.conditiongui('txt_attitudeconditiontimeend')=txt_attitudeconditiontimeend;
            gui.conditiongui('ed_attitudeconditiontimeend')=ed_attitudeconditiontimeend;
        elseif strcmp(type,'Latitude')            
            
            hbox1=uix.HBox('Parent',gui.layout211211,'Spacing',3);
            
            txt_attitudeconditionlatitudemin=new_text(hbox1,'Latitude min.');
            ed_attitudeconditionlatitudemin=new_edit(hbox1,'');
            
            set(hbox1,'Widths',[100 100]);

            hbox2=uix.HBox('Parent',gui.layout211211,'Spacing',3);
            
            txt_attitudeconditionlatitudemax=new_text(hbox2,'Latitude max.');
            ed_attitudeconditionlatitudemax=new_edit(hbox2,'');
            
            set(hbox2,'Widths',[100 100]);
            
            set(gui.layout211211,'Heights',[25 25 25 25]);

            if ~isempty(param)
                ed_attitudeconditionlatitudemin.String=num2str(param.LatitudeMin);
                ed_attitudeconditionlatitudemax.String=num2str(param.LatitudeMax);
            end

            gui.conditiongui=containers.Map;
            gui.conditiongui('hbox1')=hbox1;
            gui.conditiongui('hbox2')=hbox2;
            gui.conditiongui('txt_attitudeconditionlatitudemin')=txt_attitudeconditionlatitudemin;
            gui.conditiongui('ed_attitudeconditionlatitudemin')=ed_attitudeconditionlatitudemin;
            gui.conditiongui('txt_attitudeconditionlatitudemax')=txt_attitudeconditionlatitudemax;
            gui.conditiongui('ed_attitudeconditionlatitudemax')=ed_attitudeconditionlatitudemax;
        elseif strcmp(type,'Longitude')
                        
            hbox1=uix.HBox('Parent',gui.layout211211,'Spacing',3);
            
            txt_attitudeconditionlongitudemin=new_text(hbox1,'Longitude min.');
            ed_attitudeconditionlongitudemin=new_edit(hbox1,'');
            
            set(hbox1,'Widths',[100 100]);

            hbox2=uix.HBox('Parent',gui.layout211211,'Spacing',3);
            
            txt_attitudeconditionlongitudemax=new_text(hbox2,'Longitude max.');
            ed_attitudeconditionlongitudemax=new_edit(hbox2,'');
            
            set(hbox2,'Widths',[100 100]);
            
            set(gui.layout211211,'Heights',[25 25 25 25]);
            
            if ~isempty(param)
                ed_attitudeconditionlongitudemin.String=num2str(param.LongitudeMin);
                ed_attitudeconditionlongitudemax.String=num2str(param.LongitudeMax);
            end

            gui.conditiongui=containers.Map;
            gui.conditiongui('hbox1')=hbox1;
            gui.conditiongui('hbox2')=hbox2;
            gui.conditiongui('txt_attitudeconditionlongitudemin')=txt_attitudeconditionlongitudemin;
            gui.conditiongui('ed_attitudeconditionlongitudemin')=ed_attitudeconditionlongitudemin;
            gui.conditiongui('txt_attitudeconditionlongitudemax')=txt_attitudeconditionlongitudemax;
            gui.conditiongui('ed_attitudeconditionlongitudemax')=ed_attitudeconditionlongitudemax;
        end
    end
    function UpdateElementaryConditions()
        global current_conditions
        newdata={};
        v=values(current_conditions);
        for i=1:length(current_conditions)
            condition=v{i};
            name=condition.Name;
            type=condition.Type;
            param=condition.Parameters;
            param_str=GetConditionParamStr(type,param);
            if isempty(newdata)
                newdata={{name, type, param_str}};
            else
                newdata={cat(1,newdata{:});{name, type, param_str}};
            end
        end
        newdata=cat(1, newdata{:});
        gui.tbl_attitudeelementaryconditions.Data=newdata;
        UpdateAttitudeSequenceConditions();
    end
    function UpdateScenarioElementDefinitionParameters(row) 
        global current_scenario
        if row>length(current_scenario)
            return;
        end
        if row == length(gui.spn_attitudesequencepriority.String)
            law_name='Nadir Pointing';
            parameters=struct([]);
        else
            line=int2str(row);
            element=current_scenario(line);
            condition=element.Condition;
            e1=isfield(condition,'Condition1');
            e2=isfield(condition,'Condition2');
            e3=isfield(condition,'Condition3');
            if e1
                condition_name1=element.Condition.Condition1;
                strfnd(gui.spn_attitudesequenceconditionname1,condition_name1);
            end
            if e2
                operator1=element.Condition.Operator1;
                strfnd(gui.spn_attitudesequenceconditionoperator1,operator1);
                condition_name2=element.Condition.Condition2;
                strfnd(gui.spn_attitudesequenceconditionname2,condition_name2);
            end
            if e3
                operator2=element.Condition.Operator2;
                strfnd(gui.spn_attitudesequenceconditionoperator1,operator2);
                condition_name3=element.Condition.Condition3;
                strfnd(gui.spn_attitudesequenceconditionname3,condition_name3);
            end
            
            law_name=element.Law;
            parameters=element.Parameters;
            gui.spn_attitudesequencepriority.Value=row;
        end
        strfnd(gui.spn_attitudesequencelaw,law_name);
        UpdateScenarioElementDefinitionParametersAux(law_name,parameters);
    end
    function UpdateScenarioElementDefinitionParametersAux(law_name,param)
        if isfield(gui,'scenarioelementgui')
            keys=gui.scenarioelementgui.keys;
            for i=1:length(keys)
                delete(gui.scenarioelementgui(keys{i}));
            end
        end
        UpdateScenarioElementGUI(law_name,param);
    end
    function UpdateScenarioElementGUI(law_name,param)
        if strcmp(law_name,'Nadir Pointing')
            return;
        elseif strcmp(law_name,'Base Pointing')
            
            vbox = uix.VBox('Parent',gui.layout212214,'Spacing',3);
            
            hbox = uix.HBox('Parent',vbox,'Spacing',20);
            
            txt_scenarioelementbase=new_text(hbox,'Base');
            spn_scenarioelementbase=new_spinner(hbox,data.bases.keys);
            
            set(hbox,'Widths',[100 100]);
            
            base_index=strfnd(spn_scenarioelementbase,param.Base);
            if isempty(base_index)
                base_index=1;
            end
            spn_scenarioelementbase.Value=base_index;
            
            gui.scenarioelementgui=containers.Map;
            gui.scenarioelementgui('vbox')=vbox;
            gui.scenarioelementgui('hbox')=hbox;
            gui.scenarioelementgui('txt_scenarioelementbase')=txt_scenarioelementbase;
            gui.scenarioelementgui('spn_scenarioelementbase')=spn_scenarioelementbase;
        elseif strcmp(law_name,'Solar Pointing')
            return;
        end
    end
    function UpdateScenarioTable()
        global current_scenario
        newdata={};
        keys=current_scenario.keys;
        [sortedKeys, sortIdx]=sort(keys);
        values=current_scenario.values;
        sortedValues=values(sortIdx);
        for i=1:length(sortedKeys)
            key=int2str(i);
            element=current_scenario(key);
            condition=GetElementConditionStr(element.Condition);
            law_name=element.Law;
            param=element.Parameters;
            param_str=GetScenarioElementParamStr(law_name,param);
            new_line={key, condition, law_name, param_str};
            if isempty(newdata)
                newdata={new_line};
            else
                newdata={cat(1,newdata{:});new_line};
            end
        end
        newdata=cat(1, newdata{:});
        gui.tbl_attitudesequence.Data=newdata;
        gui.spn_attitudesequencepriority.String=num2cell(1:(length(current_scenario)+1));
    end

    % Tab 3
    
    % Tab 4
    
    %% Interface update
    function UpdateInterface()
        UpdateTab1();
        UpdateTab2();
        UpdateTab3();
        UpdateTab4();        
    end
    function UpdateTab1()
        config_name=spnstr(gui.spn_generalconfig);
        if strcmp(config_name,'Default')
            gui.btn_updategeneralconfig.Enable='off';
            gui.btn_deletegeneralconfig.Enable='off';
        else
            gui.btn_updategeneralconfig.Enable='on';
            gui.btn_deletegeneralconfig.Enable='on';
        end
        config=data.configs.general(config_name);

        spacecraft_name=config.spacecraft_name;
        cond0_name=config.cond0_name;

        strfnd(gui.spn_spacecraft,spacecraft_name);
        strfnd(gui.spn_cond0,cond0_name);

        UpdateSpacecraftData(spacecraft_name);
        UpdateCond0Data(cond0_name);   

        attitude_wchap=config.attitude_wchap;
        gui.ed_attitudewchapx.String=num2str(attitude_wchap(1));
        gui.ed_attitudewchapy.String=num2str(attitude_wchap(2));
        gui.ed_attitudewchapz.String=num2str(attitude_wchap(3));
        attitude_hchap=config.attitude_hchap;
        gui.ed_attitudehchapx.String=num2str(attitude_hchap(1));
        gui.ed_attitudehchapy.String=num2str(attitude_hchap(2));
        gui.ed_attitudehchapz.String=num2str(attitude_hchap(3));

        anim_animation_speed=config.anim_animation_speed;
        gui.ed_animspeed.String=num2str(anim_animation_speed);
        anim_spacecraft_size=config.anim_spacecraft_size;
        gui.ed_spacecraftsize.String=num2str(anim_spacecraft_size);
        anim_arrow_len=config.anim_arrow_len;
        gui.ed_arrowlen.String=num2str(anim_arrow_len);
        anim_line_len=config.anim_line_len;
        gui.ed_linelen.String=num2str(anim_line_len);
        anim_axis_limit_ratio=config.anim_axis_limit_ratio;
        gui.ed_axislimitratio.String=num2str(anim_axis_limit_ratio);
        r_ratio=config.r_ratio;
        gui.ed_radiusratio.String=num2str(r_ratio);
        anim_save_video=config.anim_save_video;
        enable_video_config=onoff(anim_save_video);
        gui.cbx_savevideo.Value=anim_save_video;
        anim_video_name=config.anim_video_name;
        gui.txt_videoname.Enable=enable_video_config;
        gui.ed_videoname.Enable=enable_video_config;
        gui.ed_videoname.String=anim_video_name;
        anim_video_format=config.anim_video_format;
        gui.txt_videoformat.Enable=enable_video_config;
        gui.ed_videoformat.Enable=enable_video_config;
        gui.ed_videoformat.String=anim_video_format;
        anim_video_frame_rate=config.anim_video_frame_rate;
        gui.txt_videoframerate.Enable=enable_video_config;
        gui.ed_videoframerate.Enable=enable_video_config;
        gui.ed_videoframerate.String=num2str(anim_video_frame_rate);

        UpdateActuatorsParameters(config.actuators('name'),config.actuators('parameters'));
    end
    function UpdateTab2()
        global current_conditions current_scenario
        config_name=spnstr(gui.spn_attitudeconfig);
        if strcmp(config_name,'Default')
            gui.btn_updateattitudeconfig.Enable='off';
            gui.btn_deleteattitudeconfig.Enable='off';
        else
            gui.btn_updateattitudeconfig.Enable='on';
            gui.btn_deleteattitudeconfig.Enable='on';
        end
        config=data.configs.attitude(config_name);
        
        
        gui.spn_attitudeconfig.String=data.configs.attitude.keys;
        strfnd(gui.spn_attitudeconfig,config_name);
            
        % Deep copy config.conditions to current_conditions
        current_conditions=containers.Map;
        k=config.conditions.keys;
        v=config.conditions.values;
        for i=1:length(k)
            current_conditions(k{i})=v{i};
        end
        conditions=current_conditions.values;

        % Deep copy config.scenario to current_scenario
        current_scenario=containers.Map;
        k=config.scenario.keys;
        v=config.scenario.values;
        for i=1:length(k)
            current_scenario(k{i})=v{i};
        end

        UpdateElementaryConditions();
        UpdateAttitudeSequenceConditions();
        if ~isempty(conditions)
            condition=conditions{1};
            name=condition.Name;
            type=condition.Type;
            param=condition.Parameters;
        else
            name='';
            type='Time';
            param=struct([]);
        end
        UpdateConditionDefinitionParameters(name,type,param);
        UpdateScenarioTable();
        UpdateScenarioElementDefinitionParameters(1);
    end
    function UpdateTab3()
    end
    function UpdateTab4()
    end

    %% Menu callbacks
    function OnExit(~,~)
        stopTimer();
        delete(gui.window);
    end % onExit

    %% Simulation
    function StartSimulation()
        global current_scenario;

        %% Imports
        igrf11300km=load('igrf11-300km.mat');
        %load b_o_avg_dipole_model.mat

        %% Init
        fprintf("Setting up model...\n\n")
        c=data.constants;

        %% Gather GUI Data
        general_config=data.general_config;
        
        spacecraft_name=general_config.spacecraft_name;
        spacecraft=data.spacecrafts(spacecraft_name);
        
        cond0_name=general_config.cond0_name;
        cond0=data.initial_conditions_sets(cond0_name);
        
        r_ratio=general_config.r_ratio;
        
        sim_time=data.sim_time;   

        %% Actuators
        actuators=general_config.actuators;
        name=actuators('name');
        if strcmp(name,'Reaction wheels') || strcmp(name,'Mix')
            parameters=actuators('parameters');
            data.constants.omega_w_0 = [0,0,0]';
            data.constants.h_0=[0,0,0]';
            data.constants.tau_w=1;
            data.constants.num_wheels=parameters.number_of_wheels;
            wheels_config=data.wheels_configurations(parameters.wheels_config);
            data.constants.W=wheels_config.distr_matrix;
            data.constants.h_w_max=0.03;
        end

        %% Control parameters
        data.constants.w_chap=general_config.attitude_wchap; %angular velocity equilibrium [rad/s]
        data.constants.h_chap=general_config.attitude_hchap; %wheels angular momentum equilibrium [kg*m2/s]
        data.constants.Tc=0.2; %control horizon [s]

        %% Satellite and orbit properties
        data.constants.eul_o_b_0_deg = cond0.eul_o_b_0_deg;
        data.constants.w_o_b_0=cond0.w_o_b_0;
        data.constants.r_eci_0=cond0.r_eci_0;
        data.constants.v_eci_0=cond0.v_eci_0;

        data.constants.h_o = norm(data.constants.r_eci_0)-data.constants.re_m; %height above sea level [m]
        data.constants.dim=spacecraft.dim; %length,width,height[m]
        data.constants.S = data.constants.dim(1)*data.constants.dim(2); %m2
        data.constants.m_s=spacecraft.m;%mass[kg]
        data.constants.r_o = data.constants.re_m + data.constants.h_o; %orbit radius [m]
        data.constants.w_0 = sqrt(data.constants.mu/(data.constants.r_o^3)); %angular velocity [rad/s]
        data.constants.T_o = 2*pi/data.constants.w_0; %Orbit period [s]
        data.constants.v0 = 2*pi*data.constants.r_o/data.constants.T_o;
        data.constants.T = round(data.constants.T_o);

        %% Inertia tensor
        data.constants.I_x=data.constants.m_s/12*(data.constants.dim(2)^2+data.constants.dim(3)^2);
        data.constants.I_y=data.constants.m_s/12*(data.constants.dim(1)^2+data.constants.dim(3)^2);
        data.constants.I_z=data.constants.m_s/12*(data.constants.dim(1)^2+data.constants.dim(2)^2);
        data.constants.I=diag([data.constants.I_x,data.constants.I_y,data.constants.I_z]); %Matrix of intertia

        %% Initial attitude and velocity
        data.constants.w_o_io=[0;data.constants.w_0;0]; %angular velocity inertial to orbit
        data.constants.euler_o_b_0=pi/180*data.constants.eul_o_b_0_deg; %initial angles orbit to body [rad]
        data.constants.q_0=euler2quat(data.constants.euler_o_b_0)'; %initial attitude orbit to body
        data.constants.R_o_b=Rquat(data.constants.q_0); %initial rotation matrix orbit to body
        data.constants.w_o_ib=data.constants.R_o_b*data.constants.w_o_io; %initial angular velocity orbit to body [rad]
        data.constants.w_b_ib_0=data.constants.w_o_b_0+data.constants.w_o_ib; %initial angular velocity body to inertial [rad]

        %% Earth magnetic field
        %Calculates average earth magnetic field in orbital frame
        data.constants.b_o_avg=b_o_avg_dipole_model(data.constants);

        data.constants.b_b_avg=data.constants.R_o_b*data.constants.b_o_avg; %average earth magnetic field in body frame

        %% Orbit
        data.constants.k=data.constants.h_o/data.constants.re_m*r_ratio; %spacecraft altitude with rescaling
        data.constants.r_s=1+data.constants.k; %spacecraft orbit radius with rescaling

        tspan=[0 sim_time]; %simulation time span

        y0=[data.constants.r_eci_0' data.constants.v_eci_0']; %initial conditions set, position and velocity

        [t_orb,r_orb,v_orb]=GetSpacecraftOrbit(tspan,y0,data); %calculates orbit

        %Calculate orbital data
        n_step_orb=length(t_orb);
        pos_orb=zeros(3,n_step_orb); %animation positions
        Rio_orb=zeros(3,3,n_step_orb); %rotation matrices inertial to orbit
        phi_orb=zeros(1,n_step_orb); %phi angles inertial to orbit
        theta_orb=zeros(1,n_step_orb); %theta angles inertial to orbit

        step=1;  
        for t=t_orb'
            r_i=r_orb(:,step);
            n=norm(r_i);
            k=n/c.re_m;
            pos=r_i/n*(1+(k-1)*r_ratio);
            pos_orb(:,step)=pos;
            theta=atan2(sqrt(pos(1)^2+pos(2)^2),pos(3));
            phi=atan2(pos(2),pos(1));
            theta_orb(1,step)=theta;
            phi_orb(1,step)=phi;
            v=v_orb(:,step);
            Rio=roti2o_2(v,pos);
            Rio_orb(:,:,step)=Rio;
            step=step+1;
        end

        %% Orbit plot
        
        axes(gui.ax_gndtrk);
        
        lat = zeros(n_step_orb,1);
        lon = zeros(n_step_orb,1);

        for i=1:n_step_orb
            lon(i)=180/pi*phi_orb(1,i);
            lat(i)=180/pi*(pi/2-theta_orb(1,i));
        end

        plot(gui.ax_gndtrk,lon, lat);

        title('Ground track of the ISS');
        xlabel('Longitude (rad)');
        ylabel('Latitude (rad)');
        hold on

        %% Attitude control (LQR)

        fprintf("Computing LQR variable gain... ")

        per=0; %percentage to display
        lineLength=fprintf("%d%%\n",per);

        q_chap_data=zeros(4,n_step_orb); %attitude equilibriums
        K_data=[]; %variable LQR gain
        A_data=[]; %variable LQR gain
        B_data=[]; %variable LQR gain

        scenario=current_scenario;
        scenario_keys=scenario.keys;
        if isempty(scenario_keys)
            error('The current attitude scenario is empty. Please add an element in the Attitude tab.')
        end

        dt_reg=1;
        t_reg=0:dt_reg:sim_time;
        step=1;
        for t_r=t_reg 
            [~,idx_orb]=min(abs(t_orb-t_r));
            t_o=t_orb(idx_orb);
            
            %Display percentage
            new_per=floor(t_r/sim_time*100);
            if (new_per~=per)
                per=new_per;
                fprintf(repmat('\b',1,lineLength))
                lineLength=fprintf("%d%%\n",per);
            end

            %Gather orbital data
            state=struct();
            state.t=t_r;
            state.Rio=Rio_orb(:,:,idx_orb);
            state.pos=pos_orb(:,idx_orb);
            state.phi=phi_orb(1,idx_orb);
            state.theta=theta_orb(1,idx_orb);
            state.longitude=180/pi*state.phi;
            state.latitude=180-180/pi*state.theta;

            %Attitude control scenario
            for i=1:length(scenario_keys)
                element_tmp=scenario(int2str(i));
                complex_condition=element_tmp.Condition;
                
                condition_check=CheckComplexCondition(complex_condition,state);
                if condition_check
                    element=element_tmp;
                    break;
                end
            end

            if ~exist('element','var')
                element=scenario(int2str(length(scenario)));
            end
            
            Rob_chap=GetRobChap(element.Law,element.Parameters,data,state);

            %Compute new attitude reference
            q_chap=rotm2quat(Rob_chap);

            %Compute new state space system
            %[A,B,C,D]=state_space_wheels_only(g_chap, w_chap, h_chap, I, w_0);
            [A,B,C,D]=state_space_wheels_only_2(q_chap, data);
            A_data(:,(step-1)*9+1:step*9)=A;
            B_data(:,(step-1)*3+1:step*3)=B;
            %Compute new LQR gain
            %Gc=gramt(A,B,Tc);
            %Q=1/Tc*inv(Gc);
            Q=eye(size(A,1))*0.001;
            R=eye(size(B,2));
            nj=size(A,1);
            K_lqr=lqr(A,B,Q,R);

            q_chap_data(:,step)=q_chap;
            K_data(:,(step-1)*nj+1:step*nj)=K_lqr;
            step=step+1;
        end

        %Display complete
        fprintf(repmat('\b',1,lineLength))
        fprintf("100%%\n\n")

        data.constants.igrf11300km=igrf11300km;

        data.preprocessdata=struct();
        data.preprocessdata.r_orb=r_orb;
        data.preprocessdata.v_orb=v_orb;
        data.preprocessdata.phi_orb=phi_orb;
        data.preprocessdata.theta_orb=theta_orb;
        data.preprocessdata.pos_orb=pos_orb;
        data.preprocessdata.Rio_orb=Rio_orb;
        data.preprocessdata.A_data=A_data;
        data.preprocessdata.B_data=B_data;
        data.preprocessdata.K_data=K_data;
        data.preprocessdata.q_chap_data=q_chap_data;
        data.preprocessdata.t_orb=t_orb;
        data.preprocessdata.n_step_orb=n_step_orb;
        data.preprocessdata.t_reg=t_reg;
        
        data.constants.Cobs=eye(9);
        %data.constants.Ts=4e-4;
        data.constants.Ts=1e-2;
        data.constants.n=4e-2;
        %Choix 1 : De Larminat
        % To=100;
        % Go=gramt(A',Cobs',To);
        % Robs=1/To*inv(Go);
        % Qobs=eye(6);

        %Choix 2
        data.constants.sigma=1e-4;
        data.constants.Robs=data.constants.sigma*(data.constants.Cobs)'*data.constants.Cobs;
        data.constants.Qobs=eye(9);

        save('data/data.mat','data');

        %% Start Simulink model
        fprintf("Model set up successfully!\n\n");
        fprintf("Starting simulation...\n\n");

        sim('spacecraft_model','StartTime','0','StopTime',num2str(sim_time));
    end

    %% Animation
    function StartAnimation()
        %% Init
        fprintf("Simulation ended successfully!\n\n");
        fprintf("Starting animation...\n\n");

        t_orb=data.preprocessdata.t_orb;
        pos_orb=data.preprocessdata.pos_orb;
        Rio_orb=data.preprocessdata.Rio_orb;
        n_step_orb=data.preprocessdata.n_step_orb;
        c=data.constants;
        sim_time=data.sim_time;
        
        data.postprocessdata=struct();
        
        Rob_data_file=load('data/Rob_data.mat');
        Rob_data=Rob_data_file.Rob_data;
        
        data.postprocessdata.Rob_data=Rob_data;
        
        %% Pre-process

        t_sim=Rob_data.Time;
        n_step_sim=length(t_sim); %number of samples from Simulink
        
        poss=zeros(3,n_step_sim); %spacecraft position (Simulink samples)
        Ribs=zeros(3,3*n_step_sim); %rotation matrix inertial to body (Simulink samples)
        Ss=zeros(16,3*n_step_sim); %spacecrafts (Simulink samples)

        

        
        dt_anim=1;
        step=1;
        t_anim=0:dt_anim:sim_time;
        data.anim.t_anim=t_anim;
        n_step_anim=length(t_anim);
        phi_ob = zeros(n_step_anim,1);
        phi_ob = zeros(n_step_anim,1);
        phi_ob = zeros(n_step_anim,1);
        for t_a=t_anim
            [~,idx_orb]=min(abs(t_orb-t_a));
            t_o=t_orb(idx_orb);
            [~,idx_sim]=min(abs(t_sim-t_a));
            t_s=t_sim(idx_sim);

            %Gather data
            pos=pos_orb(:,idx_orb);
            Rio=Rio_orb(:,:,idx_orb)';
            poss(:,step)=pos;
            Rob=Rob_data.Data(:,:,idx_sim);

            %Calculate rotation matrix inertial to body
            Rib=Rob*Rio;
            Ribs(:,3*step-2:3*step)=Rib;

            %Pre-create spacecraft
            S=create_spacecraft(pos, Rib, c.dim*data.general_config.anim_spacecraft_size);
            Ss(:,3*step-2:3*step)=S;
            
            eul_ob=rotm2eul(Rob);
            phi_ob(step,1)=180/pi*eul_ob(1);
            theta_ob(step,1)=180/pi*eul_ob(2);
            psi_ob(step,1)=180/pi*eul_ob(3);
            
            step=step+1;
        end

        axes(gui.ax_eulang);
        plot(gui.ax_eulang,t_anim,phi_ob,t_anim,theta_ob,t_anim,psi_ob);
        hold on       
        title('Euler angles between orbital and body frames');
        xlabel('Time (s)');
        ylabel('Angle (°)');
        hold on     
        %legend('phi','theta','psi','Location','NorthOutside','Orientation','horizontal','Box','off');
        
        %% Animate

        if (data.general_config.anim_save_video)
            video = VideoWriter(data.general_config.anim_video_name,data.general_config.anim_video_format);
            video.FrameRate = data.general_config.anim_video_frame_rate;
            video.Quality=90;
            gui.video=video;
            open(video)
        end
        
        data.anim=struct();
        data.anim.Ss=Ss;
        data.anim.poss=poss;
        data.anim.Ribs=Ribs;
        data.anim.t_anim=t_anim;
        
        gui.btn_pause.Enable='on';
        gui.btn_stop.Enable='on';

        startTimer(false);
    end

    function pauseTimer()
        if isfield(gui,'timer') && ~isempty(gui.timer)
            stop(gui.timer);
            gui.timer = [];
        end
    end

    function stopTimer()
        gui.btn_stop.Selected='on';
        set(gui.btn_stop, 'String', 'Restart');
        gui.btn_pause.Enable='off';
        set(gui.btn_pause, 'String', 'Pause');
        if isfield(gui,'video')
            close(gui.video);
        end
        pauseTimer();
    end

    function startTimer(restart)
        global gndtrk_line eulang_line last_anim_step anim_step pos old_pos bases_plt earth lines spacecraft arrows lines2 arrows2;
        
        if ~restart
            cla(gui.ax_anim);
            gui.ax_anim.Title.String='';
        end
        
        anim_data=data.anim;
        t_anim=data.anim.t_anim;
        t_orb=data.preprocessdata.t_orb;
        phi_orb=data.preprocessdata.phi_orb;
        n_step_anim=length(t_anim);
        config=data.general_config;
        poss=data.anim.poss;
        c=data.constants;
        w_e_deg=c.w_e_deg;
        if (~restart)
            last_anim_step=1;
            anim_step=1;
        end
        
        gui.timer = timer('Name','MyTimer',             ...
                        'Period',1,          ... 
                        'StartDelay',0,                 ... 
                        'TasksToExecute',n_step_anim,           ... 
                        'ExecutionMode','fixedDelay', ...
                        'TimerFcn',@TimerStep);
        tic;
        axes(gui.ax_anim);
        start(gui.timer);
    
        function TimerStep(~,~)
            % These demos need a window opening
            if (anim_step>n_step_anim)
                stopTimer();
                return;
            end
            
            t=t_anim(anim_step);
            last_t=t_anim(last_anim_step);
            
            if anim_step~=1
                delete(eulang_line);
                delete(gndtrk_line);
            end
            
            eulang_line=xline(gui.ax_eulang,t);
            hold on
            [~,idx_orb]=min(abs(t_orb-t));
            phi=180/pi*phi_orb(1,idx_orb);
            gndtrk_line=xline(gui.ax_gndtrk,phi);
            hold on
            
            title({'IMSAT Simulator',['t=',num2str(t),'s']})
            
            origin=poss(:,1);
            if (anim_step==1)
                pos=origin;
                dt=t-0;
                
                %Draw Earth
                earth=draw_earth_spherical();
                
                %Draw ECI frame
                drawframe([0;0;0],eye(3),config.anim_arrow_len, config.anim_line_len);

                %Draw orbit line
                for i=2:n_step_anim
                    pos_temp=poss(:,i);
                    old_pos_temp=poss(:,i-1);
                    plot3([old_pos_temp(1), pos_temp(1)],...
                        [old_pos_temp(2), pos_temp(2)],...
                        [old_pos_temp(3), pos_temp(3)],'c');
                    hold on
                end
                
                %% Axis
                %Labels
                xlabel('x') 
                ylabel('y') 
                zlabel('z') 

                %Limits
                lim=config.anim_axis_limit_ratio*norm(origin);
                Lim=[-lim lim];
                xlim(Lim)
                ylim(Lim)
                zlim(Lim)
            else
                dt=t-last_t;
                delete(spacecraft);
                delete(bases_plt);
                delete(lines);
                delete(lines2);
                delete(arrows);
                delete(arrows2);
            end
                
            function earth=draw_earth_spherical()
                [X,Y,Z] = sphere;
                imData = imrotate(imread('earthmap1k.jpg'),180);
                earth=warp(X,Y,Z,imData);
                earth.EdgeColor='none';
                hold on
            end
            
            rotate(earth,[0 0 1], w_e_deg*dt);
            
            %Draw ECEF frame
            [arrows2,lines2]=drawframe([0;0;0],Rzyx(0,0,-pi/180*w_e_deg*t),config.anim_arrow_len, config.anim_line_len);

            %% Draw bases
            bases_plt=[];
            bas=data.bases.values;
            for i=1:length(bas)
                [plt,txt]=draw_base(bas{i},t);
                bases_plt=[bases_plt plt txt];
            end
            
            function [plt,txt]=draw_base(base,t)
                name=base.name;
                [x,y,z]=base_position(base,t,0,w_e_deg);
                plt=plot3(x,y,z,'ro', 'MarkerSize', 5);
                hold on
                [x,y,z]=base_position(base,t,0.3,w_e_deg);
                txt=text(x,y,z,name);
                hold on
            end
            
            %Gather next data
            pos=poss(:,anim_step);
            if (anim_step==1)
                old_pos=pos;
            end
            Rib=anim_data.Ribs(:,3*anim_step-2:3*anim_step);
            S=anim_data.Ss(:,3*anim_step-2:3*anim_step);

            %Display new elements
            spacecraft=draw_spacecraft(S);
            [arrows,lines]=drawframe(pos, Rib, config.anim_arrow_len, config.anim_line_len);
           
            function plt = draw_spacecraft(S)
                plt=plot3(S(:,1),S(:,2),S(:,3),'b');
                hold on
            end

            v=plot3([old_pos(1), pos(1)], ...
                [old_pos(2), pos(2)], ...
                [old_pos(3), pos(3)],'m'); %display travelled distance
            hold on
            v.LineWidth=2;

            if (config.anim_save_video)
                frame=getframe(gcf);
                writeVideo(gui.video, frame);
            end

            %{
            pause_time = -1;
            i=0;
            while pause_time<0
                i=i+1;
                if anim_step+i>length(anim_data.times)
                    i=i-1;
                    break;
                end
                dt = anim_data.times(anim_step+i)-anim_data.times(anim_step);
                delay = toc;
                pause_time = dt/config.anim_animation_speed-delay-timer_period;
            end
            last_anim_step = anim_step;
            anim_step = min(anim_step+i,n_data);
            pause(pause_time);
        
            tic
            %}
            last_anim_step = anim_step;
            anim_step = anim_step+config.anim_animation_speed;
        end
        
         function [arrows, lines] = drawframe(center, R, arrow_len, line_len)
            ux=center + arrow_len*R'*[1;0;0];
            uy=center + arrow_len*R'*[0;1;0];
            uz=center + arrow_len*R'*[0;0;1];
            plt1=arrow3(center', ux', 'r');
            hold on    
            plt2=arrow3(center', uy', 'g');
            hold on    
            plt3=arrow3(center', uz', 'b');
            hold on    
            
            ux=center + line_len*R'*[1;0;0];
            uy=center + line_len*R'*[0;1;0];
            uz=center + line_len*R'*[0;0;1];
            pltx=plot3([center(1), ux(1)],[center(2), ux(2)],[center(3), ux(3)],'r');
            hold on
            plty=plot3([center(1), uy(1)],[center(2), uy(2)],[center(3), uy(3)],'g');
            hold on
            pltz=plot3([center(1), uz(1)],[center(2), uz(2)],[center(3), uz(3)],'b');
            hold on
            arrows=[plt1 plt2 plt3];
            lines=[pltx plty pltz];
        end
    end
end

