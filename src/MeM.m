P = py.sys.path;
pp = strcat(fileparts(fileparts(fileparts(pwd))), '/interface');
if count(P,pp) == 0
    insert(P,int32(0),pp);
end

import PsiInterface.*

%function SaM(InputFile,OutputFile)
    in = py.PsiInterface.PsiInput('input1');
    st = py.PsiInterface.PsiInput('static');
    out = py.PsiInterface.PsiOutput('output');

    Input = in.recv()
    Static = st.recv()
    disp ('In source code\n');
    disp(Static);
    Output = 1;
    
    global Arate;
    MeM_model(Input, Static);
    Outdata = Arate;
    
    sOutput = sprintf('Net Photosynthesis = %d',Outdata);
    out.send(sOutput);
%end

exit();
