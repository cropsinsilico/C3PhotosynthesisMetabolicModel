
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set up I/O Channels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
in1 = YggInterface('YggInput', 'MeM_input1');
in2 = YggInterface('YggInput', 'MeM_input2');
in3 = YggInterface('YggInput', 'MeM_input3');
out = YggInterface('YggOutput', 'MeM_output', '%f\n');
disp('Done establishing I/O channels');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Receive input 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[flag, Input1_map] = in1.recv_dict();
if (~flag)
  disp('Error getting input1');
  exit(-1);
end;
Input1 = containers.Map(Input1_map('Glyma_ID'), Input1_map('Ele:Amb'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Receive input 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[flag, Input2_map] = in2.recv_dict();
if (~flag)
  disp('Error getting input2');
  exit(-1);
end;
Input2 = containers.Map(Input2_map('Glyma_ID'), Input2_map('Ele:Amb'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Receive input 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [flag, Input3] = in3.recv();
% if (~flag)
%   disp('Error getting input3');
%   exit(-1);
% end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize variables independent of individual leaf segment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global Arate;
global CO2in;
global Tpin;
global Liin;
global GRNC;
global GRNT;

MeM_model(Input1, Input2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Continue reading new light intensities for new leaf segments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

flag = true;
while flag
  [flag, vars] = in3.recv();
  if flag
    CO2in = vars{1};
    Liin = vars{2};
    Tpin = vars{3};
    GRNC = vars{4};
    GRNT = vars{5};

    fprintf('Running MeM for CO2=%f, Light=%f, T=%f, GRNC=%d, GRNT=%d\n', ...
	    CO2in, Liin, Tpin, GRNC, GRNT);
    Arate = MeM_run(Liin, CO2in, Tpin);
    fprintf('MeM(LI = %f) = %f\n', Liin, Arate);
    out.send(Arate);
  end;
end;

disp('Exited loop');

exit();
