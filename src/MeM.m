P = py.sys.path;
pp = strcat(fileparts(fileparts(fileparts(pwd))), '/interface');
if count(P,pp) == 0
    insert(P,int32(0),pp);
end

import PsiInterface.*
    disp('Matlab running')

    in1 = py.PsiInterface.PsiInput('MeM_input1');
    in2 = py.PsiInterface.PsiInput('MeM_input2');
    in3 = py.PsiInterface.PsiInput('MeM_input3');  
    out = py.PsiInterface.PsiOutput('MeM_output');
    Input1 = in1.recv()
    Input2 = in2.recv()

    while 1
    disp('Matlab loop start')
    Input3 = in3.recv()
    disp('Matlab loop receive')   

    global Arate;
    global TandArateout;
    MeM_model(Input1, Input2,Input3);
    Outdata = num2str(Arate);
    % Outdata = num2str(TandArateout);
    sOutput = sprintf(Outdata);
    out.send(sOutput);
    disp('Matlab loop ends')
    end

exit();
