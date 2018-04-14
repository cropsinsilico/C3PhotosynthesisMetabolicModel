
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set up I/O Channels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
in1 = CisInterface('CisInput', 'MeM_input1');
in2 = CisInterface('CisInput', 'MeM_input2');
in3 = CisInterface('CisInput', 'MeM_input3');
inLI = CisInterface('CisInput', 'MeM_light_intensity');
out = CisInterface('CisOutput', 'MeM_output', '%f\n');
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
[flag, Input3] = in3.recv();
if (~flag)
  disp('Error getting input3');
  exit(-1);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize variables independent of individual leaf segment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global Arate;
global CO2in;
global Tpin;
global Liin;

MeM_model(Input1, Input2, Input3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Continue reading new light intensities for new leaf segments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

flag = true;
while flag
  [flag, vars] = inLI.recv();
  if flag
    Liin = vars{1};
    fprintf('Running MeM for light intensity of %f\n', Liin);
    Arate = MeM_run(Liin, CO2in, Tpin);
    fprintf('MeM(LI = %f) = %f\n', Liin, Arate);
    out.send(Arate);
  end;
end;

disp('Exited loop');

exit();
