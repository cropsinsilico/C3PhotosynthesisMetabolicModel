P = py.sys.path;
pp = strcat(fileparts(fileparts(fileparts(pwd))), '/interface');
if count(P,pp) == 0
    insert(P,int32(0),pp);
end

import PsiInterface.*

%function SaM(InputFile,OutputFile)
    %InputFileID = fopen(InputFile);
    in = py.PsiInterface.PsiInput('input1');
    %StaticFileID = fopen('./Input/SaM_static.txt');
    st = py.PsiInterface.PsiInput('static');
    out = py.PsiInterface.PsiOutput('output');

    Input = in.recv()
    Static = st.recv()
    Output = str2num(char(Input))+str2num(char(Static))
    sOutput = sprintf('Sum = %d',Output);
    out.send(sOutput);
%end

exit();
