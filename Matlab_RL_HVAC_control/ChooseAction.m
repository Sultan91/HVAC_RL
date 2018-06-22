function [ action_idx ] = ChooseAction( epsilon, succRate, actions, state_index,Q )
if (rand()>epsilon) && rand()<=succRate
        	[~,action_idx] = max(Q(state_index,:)); % Pick the action the Q matrix thinks is best!
 else
             action_idx = randi(length(actions),1); % Random action!



end

