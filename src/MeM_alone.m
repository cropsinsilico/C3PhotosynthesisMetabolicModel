
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set up I/O Channels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
in1 = CisInterface('CisAsciiArrayInput', 'input1');
in2 = CisInterface('CisAsciiArrayInput', 'input2');
in3 = CisInterface('CisAsciiArrayInput', 'input3');
inLI = CisInterface('CisAsciiTableInput', 'light_intensity');
out = CisInterface('CisOutput', 'output', '%f');
disp('Done establishing I/O channels');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Receive input 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[flag, Input1_cell] = in1.recv();
if (~flag)
  disp('Error getting input1');
  exit(-1);
end;
Input1 = containers.Map(Input1_cell(:,1), Input1_cell(:,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Receive input 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[flag, Input2_cell] = in2.recv();
if (~flag)
  disp('Error getting input2');
  exit(-1);
end;
Input2 = containers.Map(Input2_cell(:,1), Input2_cell(:,2));

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
