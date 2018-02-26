function MeM_model(inputfile1, inputfile2,inputfile3)
%SCM_Drive_GRN('/Input/MeM_input.txt', '/Output/MeM_output_A.txt', '/Output/MeM_output_M.txt')
%indata1= importdata('./Input/MeM_input.txt');
%str=pwd;
%index_dir=findstr(str,'/');
%dirx=str(1:index_dir(end)-1)
%inputf=strcat(dirx,inputfile);
%indata1= importdata(inputf);
%staticf= strcat(dirx,'staticfile');
%indata2= importdata(staticf);

%indata1= importdata(inputfile);
%indata2= importdata(staticfile);
%GRN_data=indata1.data; 
%Env_data=indata2.data; 

params_data = cellstr(strsplit(char(inputfile3)));
params_data = deblank(params_data);
    
%    for k = 1:length(params_data)
%        if strcmp(params_data{k}, 'CO2')
%            n_CO2 = params_data{k+1};
%        end
%        if strcmp(params_data{k}, 'light')
%            n_light = params_data{k+1};
%        end
%        if strcmp(params_data{k}, 'Temp')
%            n_Temp = params_data{k+1};
%        end
%        if strcmp(params_data{k}, 'GRNC')
%            n_GRNC = params_data{k+1};
%        end
%        if strcmp(params_data{k}, 'GRNT')
%            n_GRNT = params_data{k+1};
%        end        
%    end
    for k = 1:length(params_data)
        if strcmp(params_data{k}, 'GRNT')
            n_CO2 = params_data{k+1};
            n_light = params_data{k+2};
            n_Temp = params_data{k+3};
            n_GRNC = params_data{k+4};
            n_GRNT = params_data{k+5};
        end        
    end

%global outA;
%global outM;
%% outA=strcat(dirx,outputfile_A);
%% outM=strcat(dirx,outputfile_M);

%outA=outputfile_A;
%outM=outputfile_M;

global GRNC;
global GRNT;
GRNC=str2num(n_GRNC);
GRNT=str2num(n_GRNT);

global VfactorC;
global VfactorT;

    input_data = cellstr(strsplit(char(inputfile1)));
    
    for k = 1:length(input_data)
        if strcmp(input_data{k}, 'Glyma.08G175800')
           GRN_data{1} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.02G228700')
           GRN_data{2} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.17G261700')
           GRN_data{3} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.10G066700')
           GRN_data{4} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.04G011900')
           GRN_data{5} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.06G094300')
           GRN_data{6} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.19G106800')
           GRN_data{7} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.10G281400')
           GRN_data{8} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.15G012500')
           GRN_data{9} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.17G228800')
           GRN_data{10} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.13G222300')
           GRN_data{11} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.01G026700')
           GRN_data{12} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.08G214300')
           GRN_data{13} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.08G044100')
           GRN_data{14} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.08G165500')
           GRN_data{15} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.09G015500')
           GRN_data{16} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.01G010200')
           GRN_data{17} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.10G265400')
           GRN_data{18} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.19G046600')
           GRN_data{19} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.19G088400')
           GRN_data{20} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.08G302600')
           GRN_data{21} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.13G062700')
           GRN_data{22} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.10G086600')
           GRN_data{23} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.06G323700')
           GRN_data{24} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.03G027500')
           GRN_data{25} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.15G038100')
           GRN_data{26} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.04G008300')
           GRN_data{27} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.10G059500')
           GRN_data{28} = input_data{k+1};
        end
        if strcmp(input_data{k}, 'Glyma.04G015900')
           GRN_data{29} = input_data{k+1};
        end
    end

%Vfactor=GRN_data(:,10);
for i=1:29
        VfactorC(i)=subs(GRN_data{i});
end


input_dataT = cellstr(strsplit(char(inputfile2)));
    
    for k = 1:length(input_dataT)
        if strcmp(input_dataT{k}, 'Glyma.07g182300')
           GRN_dataT{1} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.12g153000')
           GRN_dataT{2} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.07g258500')
           GRN_dataT{3} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.19g089100')
           GRN_dataT{4} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.08g108900')
           GRN_dataT{5} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.07g028500')
           GRN_dataT{6} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.13g361400')
           GRN_dataT{7} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.10g281400')
           GRN_dataT{8} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.05g141400')
           GRN_dataT{9} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.16g044900')
           GRN_dataT{10} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.04g051200')
           GRN_dataT{11} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.08g302600')
           GRN_dataT{12} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.02g228700')
           GRN_dataT{13} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.10g086600')
           GRN_dataT{14} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.05g025300')
           GRN_dataT{15} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.03g185800')
           GRN_dataT{16} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.07g142700')
           GRN_dataT{17} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.02g222400')
           GRN_dataT{18} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.04g030300')
           GRN_dataT{19} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.04g032600')
           GRN_dataT{20} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.05g237000')
           GRN_dataT{21} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.08g165400')
           GRN_dataT{22} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.09g247900')
           GRN_dataT{23} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.19g243000')
           GRN_dataT{24} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.13g046200')
           GRN_dataT{25} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.11g226900')
           GRN_dataT{26} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.05g127800')
           GRN_dataT{27} = input_dataT{k+1};
        end
        if strcmp(input_dataT{k}, 'Glyma.08g308600')
           GRN_dataT{28} = input_dataT{k+1};
        end

    end

%Vfactor=GRN_data(:,10);
for i=1:28
        VfactorT(i)=subs(GRN_dataT{i});
end


%Vfactor(i)=subs(GRN_data{i});

CO2in=str2num(n_CO2);
Liin=str2num(n_light);
Tpin=str2num(n_Temp);

Arate=MeM_run(Liin,CO2in,Tpin);
end