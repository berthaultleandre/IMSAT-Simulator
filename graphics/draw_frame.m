function [arrows, lines] = draw_frame(center, R, arrow_len, line_len)
    ux=center + arrow_len*R'*[1;0;0];
    uy=center + arrow_len*R'*[0;1;0];
    uz=center + arrow_len*R'*[0;0;1];
    plt1=arrow3(center', ux', 'r');
    plt2=arrow3(center', uy', 'g');
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
    arrows=[plt1 plt2 plt3];
    lines=[pltx plty pltz];
end