function MeM_model = SCM_Drive_GRN(inputfile, staticfile)
%SCM_Drive_GRN('/Input/MeM_input.txt', '/Output/MeM_output_A.txt', '/Output/MeM_output_M.txt')
%indata1= importdata('./Input/MeM_input.txt');
%str=pwd;
%index_dir=findstr(str,'/');
%dirx=str(1:index_dir(end)-1)
%inputf=strcat(dirx,inputfile);
%indata1= importdata(inputf);
%staticf= strcat(dirx,'staticfile');
%indata2= importdata(staticf);

indata1= importdata(inputfile);
indata2= importdata(staticfile);
GRN_data=indata1.data; 
Env_data=indata2.data; 

%global outA;
%global outM;
%% outA=strcat(dirx,outputfile_A);
%% outM=strcat(dirx,outputfile_M);

%outA=outputfile_A;
%outM=outputfile_M;



global Vfactor;
Vfactor=GRN_data(:,10);

global CO2_Env;
global CO2_cond;
global LI;
global Jmax;
global alfa;
global fc;
global Theta;
global beta;
CO2_Env=Env_data(1);
CO2_cond = CO2_Env*0.7/(3 * 10^4);
LI=Env_data(2)/30;
Jmax=0.180/30*1000;
alfa=0.85;
fc=0.15;
Theta=0.7;
beta=0.7519;



global Tp;
Tp=25;
Begin = 1;
global tglobal;     % The total running time
tglobal = 3000;
global options1 
options1 = odeset('RelTol',1e-4);
time = tglobal;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Global variables used for obtaining flux and concentration data %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     

global PS_OLD_TIME;
global PS_TIME_N;
global PS_VEL;
PS_OLD_TIME = 0;
PS_TIME_N= 0;
PS_VEL = zeros(1,1);

global PR_OLD_TIME;
global PR_TIME_N;
global PR_VEL;
PR_OLD_TIME = 0;
PR_TIME_N = 1;
PR_VEL = zeros(1,1);

global SUCS_OLD_TIME;
global SUCS_TIME_N;
global SUCS_VEL;
global SUCS_CON;

SUCS_OLD_TIME = 0;
SUCS_TIME_N = 1;
SUCS_VEL = zeros(1,3);    % Clean memory
SUCS_CON = zeros(3,1);    % Clean memory
%%%%%%%%%%%%%%%%%%%%%%%%
%   Initialation step %
%%%%%%%%%%%%%%%%%%%%%%%%

global GP; 
GP = 0;
% Begin = 1;
% PS_PRs = zeros(23,1);
CMs = CM_Ini(Begin);

ModelComb = IModelCom;        % Initialize the structure of the model, i.e. Is this model separate or combined with others. 

global PR_PS_com;             % This is a variable indicating whether the PR model is actually need to be combined with PS or not. If 1 then means combined; 0 means not. 
PR_PS_com = 1;

global ATPActive;
ATPActive = 0;

global PSPR_SUCS_com;        % This is a variable indicating whether the PSPR model is actually need to be combined with SUCS or not. If 1 then means combined; 0 means not. 
PSPR_SUCS_com = 1;

%%%%%%%%%%%%%%%%%%%%%%%%
%   Calculation  step %
%%%%%%%%%%%%%%%%%%%%%%%%

CM_Param = 0;

SUCS_Param = zeros(2,1);
SUCS_Param(1) = 1;
SUCS_Param(2) = 1;

PS_PR_Param = 0;



[Tt,d] = ode15s(@CM_mb,[0,time],CMs, options1,PS_PR_Param, SUCS_Param);   

global d_plot;
d_plot=d;

global Tt_plot;
Tt_plot = Tt;


%%%%%%%%%%%%%%%%%%%%%%%
%   output  step. Notice if the graph needs to be displayed, then, the following line should not be commented out     %
%%%%%%%%%%%%%%%%%%%%%%%
CM_OUT(Tt,d);

PSPR_SUCS_com = 0;
IModelCom;
end