function [eplus_in_curr,userdata] = controlFile(cmd,eplus_out_prev, eplus_in_prev, time, stepNumber, userdata) 
% ---------------FUNCTION INPUTS---------------

% INPUTS TO ENERGYPLUS
% eplus_in_prev - Data Structure with all previous inputs
% 	eplus_in_curr.tsp1 = ; 
% 	eplus_in_curr.tsp2 = ; 
% 	eplus_in_curr.tsp3 = ; 

% OUTPUTS FROM ENERGYPLUS 
% eplus_out_prev - Data Structure with all previous outpus
% 	eplus_out_curr.Power1 = ; 
% 	eplus_out_curr.Power2 = ; 
% 	eplus_out_curr.Power3 = ; 
% 	eplus_out_curr.outTemp = ; 
% 	eplus_out_curr.txSolar = ; 
% 	eplus_out_curr.floorTemp = ; 
% 	eplus_out_curr.heat1 = ; 
% 	eplus_out_curr.heat2 = ; 
% 	eplus_out_curr.heat3 = ; 
% 	eplus_out_curr.temp1 = ; 
% 	eplus_out_curr.temp2 = ; 
% 	eplus_out_curr.temp3 = ; 

% OTHER INPUTS
% cmd  - MLE+ Command to distinguish init or normal step
% userdata  - user defined variable which can be changed and evolved
% time - vector with timesteps
% stepNumber - Number of Time Step in the simulation (Starts at 1)

% ---------------FUNCTION OUTPUTS---------------
% eplus_in_curr - vector with the values of the input parameters.
% This should be a 1xn vector where n is number of eplus_in parameters
% userdata - user defined variable which can be changed and evolved

if strcmp(cmd,'init')
    gavn = 'INIT'
	% ---------------WRITE YOUR CODE---------------
	% Initialization mode. This part sets the
	% input parameters for the first time step.
	 eplus_in_curr.tsp1 = 12; 
	 eplus_in_curr.tsp2 = 12; 
	 eplus_in_curr.tsp3 = 33; 
elseif strcmp(cmd,'normal') 
   % gavn = 'NORMAL'
	% ---------------WRITE YOUR CODE---------------
	% Normal mode. This part sets the input 
	% parameters for the subsequent time steps.
	 eplus_in_curr.tsp1 = 3; 
	 eplus_in_curr.tsp2 = 12; 
	 eplus_in_curr.tsp3 = rand()*30; 
     eplus_out_prev.temp3(end)
end
end
