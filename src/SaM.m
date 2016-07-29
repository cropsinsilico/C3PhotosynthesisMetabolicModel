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
%    disp ('In source code\n');
%    disp(Static);
%    disp(Input);
%    Output = 1;

%     GRN_data = cellstr(strsplit(char(Input)));
%     A=size(GRN_data);
%     Output=num2str(A(1));

    all_rows = strsplit(char(Static), '\r');
    header_row = strsplit(all_rows{1}, '\t');
    nCols = length(header_row);
    nRows = length(all_rows);
    static_data = cell([nRows nCols]);
    S=size(static_data);
    Output=num2str(S(2));% nCols=3 nRows=1

    sOutput = sprintf(Output);
    out.send(sOutput);
%end

exit();
