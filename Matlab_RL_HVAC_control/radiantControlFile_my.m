function [eplus_in_curr, userdata] = RadiantControlFileBaseline(cmd,eplus_out_prev, eplus_in_prev, time, stepNumber, userdata)
if strcmp(cmd,'init')
  addpath('./RL_lib')
  
epsilon = 0.7; % Initial value
epsilonDecay = 0.98; % Decay factor per iteration.
epsilon = epsilon*epsilonDecay;
discount = 0.8;
learnRate = 0.99;
  successRate =1;
  % Temperature setpoint and actual temp state space definition
  tsps = [15:0.2:26];
  temps = tsps;  % setting the same
  actions = [0, -0.1, 0.1];
  %[states, R, Q] = RL_setup(tsps, temps, actions);
  
  
  load Q.mat;
  load states.mat
  load R.mat
  userdata.epsilon = epsilon;
  
   z1 = [20, 15];
    [next_state, state_index] = min(abs(sum(states - repmat(z1,[size(states,1),1]).^2, 2)));
      
       if (rand()>epsilon) && rand()<=successRate
        	[~,action_idx] = max(Q(state_index,:)); % Pick the action the Q matrix thinks is best!
       else
             action_idx = randi(length(actions),1); % Random action!
       end
    action_idx
    act = actions(action_idx); % Taking  chosen action
    eplus_in_prev
  %%    Update  Q matrix (z1 has to be updated at this step)
  z1_new = [20, eplus_out_prev.temp3(end)];
 [next_state, new_state_index] = min(abs(sum(states - repmat(z1_new,[size(states,1),1]).^2, 2))); % Interpolate again to find the new state the system is closest to.
 %OLD_one = Q(next_state_index, action_idx)
 %% Updating Action-Value function with Sarsa
  Q(state_index, action_idx) = Q(state_index,action_idx) + learnRate * ( R(new_state_index) ...
      + discount*max(Q(new_state_index,:)) - Q(state_index,action_idx));
  
  userdata.currState = z1_new;
  eplus_in_curr.tsp1 = 25;
  eplus_in_curr.tsp2 = 10;
  eplus_in_curr.tsp3 = 22+act;
  userdata.old_tsp3 =  eplus_in_curr.tsp3;
  userdata.Q = Q;
  userdata.states = states;
  userdata.R = R;
  save('./RL_lib/Q.mat','Q');
  save('./RL_lib/states.mat','states');
  save('./RL_lib/R.mat','R');
  
elseif strcmp(cmd,'normal')
    
   z1_new = [eplus_in_prev.tsp3(end), eplus_out_prev.temp3(end)]
   Q = userdata.Q;
   addpath('./RL_lib')
   %load Q.mat;
   R = userdata.R;
   actions = [ 0, -0.1, 0.1];
   states = userdata.states;
   %%
successRate = 1;
epsilon = userdata.epsilon; % Initial value
epsilonDecay = 0.98; % Decay factor per iteration.
epsilon = epsilon*epsilonDecay;
userdata.epsilon = epsilon;
discount = 0.8;
learnRate = 0.99;  
   %% curr state
    z1 = userdata.currState;
    z1
     [state, state_index] = min(abs(sum((states - repmat(z1,[size(states,1),1])).^2, 2)))
       
       if (rand()>epsilon) && rand()<=successRate
        	[~,action_idx] = max(Q(state_index,:)); % Pick the action the Q matrix thinks is best!
          F =   'First';
        else
             action_idx = randi(length(actions),1); % Random action!
             S = 'Second';
        end
            action_idx
            act = actions(action_idx); % Taking  chosen action (which way change TSP)
         
   %% New state acquired 
%gavno = abs(states - repmat(z1_new,[size(states,1),1])).^2
 [next_state, new_state_index] = min(sum(abs(states - repmat(z1_new,[size(states,1),1])).^2, 2)) % Interpolate again to find the new state the system is closest to.
 OLD_Q= Q(state_index, action_idx);
 Q(state_index, action_idx) = Q(state_index,action_idx) + learnRate * ( R(new_state_index)...
                                                                + discount*max(Q(new_state_index,:)) - Q(state_index,action_idx));
 Change=  R(new_state_index) + discount*max(Q(new_state_index,:)) - Q(state_index,action_idx) ;                                                  
    % Output
     state_index
     new_state_index
%     epsilon
    
    Best_Q = discount*max(Q(new_state_index,:));
     % ---------------------------------------------------------------------------------------------
    userdata.currState = z1_new;
    eplus_in_curr.tsp1 = 25;
    eplus_in_curr.tsp2 = 10;
    
%    count = userdata.counter;
    
%  if (count == 96)
%          eplus_in_curr.tsp3 = 22;
%           userdata.old_tsp3 = eplus_in_curr.tsp3;
%           userdata.counter = 0;
%          
% else
         eplus_in_curr.tsp3 = userdata.old_tsp3 + act;
         userdata.old_tsp3 = eplus_in_curr.tsp3;
%         userdata.counter =  userdata.counter+1;
 % end
    TSP3 = eplus_in_curr.tsp3;
    userdata.Q = Q;
    TSP3
    save('./RL_lib/Q.mat','Q');
end
