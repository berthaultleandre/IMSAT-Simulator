%% Tab 1 : General
gui.btn_updategeneralconfig.Callback=...
    {@OnPressed_UpdateGeneralConfig, gui};
gui.btn_deletegeneralconfig.Callback=...
    {@OnPressed_DeleteGeneralConfig, gui};
gui.btn_creategeneralconfig.Callback=...
    {@OnPressed_CreateGeneralConfig, gui};
gui.spn_generalconfig.Callback=...
    {@OnSelectedItem_GeneralConfigSpinner, gui};

gui.spn_spacecraft.Callback=...
    {@OnSelectedItem_SpacecraftSpinner, gui};
gui.spn_actuators.Callback=...
    {@OnSelectedItem_ActuatorsSpinner, gui};
gui.spn_cond0.Callback=...
    {@OnSelectedItem_Cond0Spinner, gui};

gui.cbx_savevideo.Callback=...
    {@OnChecked_SaveVideoCheckbox, gui};

gui.ed_attitudewchapx.Callback={@OnEdited_GeneralTab, gui};
gui.ed_attitudewchapy.Callback={@OnEdited_GeneralTab, gui};
gui.ed_attitudewchapz.Callback={@OnEdited_GeneralTab, gui};

gui.ed_attitudehchapx.Callback={@OnEdited_GeneralTab, gui};
gui.ed_attitudehchapy.Callback={@OnEdited_GeneralTab, gui};
gui.ed_attitudehchapz.Callback={@OnEdited_GeneralTab, gui};

gui.ed_animspeed.Callback={@OnEdited_GeneralTab, gui};
gui.ed_spacecraftsize.Callback={@OnEdited_GeneralTab, gui};
gui.ed_arrowlen.Callback={@OnEdited_GeneralTab, gui};
gui.ed_linelen.Callback={@OnEdited_GeneralTab, gui};
gui.ed_axislimitratio.Callback={@OnEdited_GeneralTab, gui};
gui.ed_radiusratio.Callback={@OnEdited_GeneralTab, gui};
gui.ed_videoname.Callback={@OnEdited_GeneralTab, gui};
gui.ed_videoformat.Callback={@OnEdited_GeneralTab, gui};
gui.ed_videoframerate.Callback={@OnEdited_GeneralTab, gui};

%% Tab 2 : Attitude
gui.btn_updateattitudeconfig.Callback=...
    {@OnPressed_UpdateAttitudeConfig, gui};
gui.btn_deleteattitudeconfig.Callback=...
    {@OnPressed_DeleteAttitudeConfig, gui};
gui.btn_createattitudeconfig.Callback=...
    {@OnPressed_CreateAttitudeConfig, gui};
gui.spn_attitudeconfig.Callback=...
    {@OnSelectedItem_AttitudeConfigSpinner, gui};

gui.tbl_attitudeelementaryconditions.CellSelectionCallback=...
    {@OnSelectedItem_ElementaryConditionsTable, gui};
gui.spn_attitudeconditiondefinitiontype.Callback=...
    {@OnSelectedItem_AttitudeConditionDefinitionTypeSpinner, gui};
gui.btn_attitudeconditiondefinitiondelete.Callback=...
    {@OnPressed_RemoveConditionDefinitionButton, gui};
gui.btn_attitudeconditiondefinitionvalidate.Callback=...
    {@OnPressed_ValidateConditionDefinitionButton, gui};

gui.tbl_attitudesequence.CellSelectionCallback=...
    {@OnSelectedItem_ScenarioTable, gui};
gui.spn_attitudesequencepriority.Callback=...
    {@OnSelectedItem_AttitudeSequencePrioritySpinner, gui};
gui.spn_attitudesequencelaw.Callback=...
    {@OnSelectedItem_AttitudeSequenceLawSpinner, gui};
gui.btn_attitudesequencemoveelementup.Callback=...
    {@OnPressed_MoveAttitudeSequenceElementButton, gui, -1};
gui.btn_attitudesequencemoveelementdown.Callback=...
    {@OnPressed_MoveAttitudeSequenceElementButton, gui, +1};
gui.btn_attitudesequencedeleteelement.Callback=...
    {@OnPressed_RemoveAttitudeSequenceElementButton, gui};
gui.btn_attitudesequenceaddelement.Callback=...
    {@OnPressed_AddAttitudeSequenceElementButton, gui};

%% Tab 3 : Simulation
gui.btn_startsim.Callback=...
    {@OnPressed_StartSimulationButton, gui};

%% Tab 4 : Animation
gui.btn_pause.Callback=...
    {@OnPressed_PauseAnimationButton, gui};
gui.btn_stop.Callback=...
    {@OnPressed_StopAnimationButton, gui};