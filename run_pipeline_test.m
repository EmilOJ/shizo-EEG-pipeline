%clc; close all; clear all;
pars = initialize_pars('participant','s1001','experiment','steady_state');
initialize_paths(pars);
%importing initial data. should be /data/"patientnumber"/data_ini.mat
if exist([pars.my_data_folder,filesep,pars.participant,filesep,'data_init.mat']) == 0
   error('Data_init.mat does not exist in ',pars.my_data_folder,filesep,pars.participant) 
end
data = importdata([pars.my_data_folder,filesep,pars.participant,filesep,'data_init.mat']);
for i_module = 1:length(pars.module_order) %iterate through all modules
   use_data_file = check_for_old_data(pars,i_module);
   if use_data_file == 1
       data = importdata([pars.my_data_folder,filesep,pars.participant,filesep,'data_out_module_',num2str(i_module),'.mat']);
   else
       %running the function for the current module
      eval(['data = ',pars.module_order{i_module},'(pars,data);'])
      %saving both data and pars used for the data
      save([pars.my_data_folder,filesep,pars.participant,filesep,'data_out_module_',num2str(i_module),'.mat'],'data')
      save([pars.my_data_folder,filesep,pars.participant,filesep,'pars_used_for_module_',num2str(i_module),'.mat'],'pars')
   end
end