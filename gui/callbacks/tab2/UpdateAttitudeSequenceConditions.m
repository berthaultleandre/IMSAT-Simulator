function UpdateAttitudeSequenceConditions(h)
    global current_conditions
    keys=current_conditions.keys;
    keys=horzcat(' ',keys);
    h.spn_attitudesequenceconditionname1.String=keys;
    h.spn_attitudesequenceconditionname1.Value=1;
    h.spn_attitudesequenceconditionname2.String=keys;
    h.spn_attitudesequenceconditionname2.Value=1;
    h.spn_attitudesequenceconditionname3.String=keys;
    h.spn_attitudesequenceconditionname3.Value=1;
end