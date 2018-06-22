function [ states, R, Q ] = RL_setup_test( tsps, temps, powers, actions )

states = zeros(length(tsps)*length(temps)*length(powers),3); % State: [tsps, zone temp, zone power consumption]
   index =1;
    for j=1:length(tsps)
        for k = 1:length(temps)
            for i = 1:length(powers)
               states(index,:) = [tsps(j), temps(k), powers(i)];
               index = index +1;
            end
        end
    end
    R = zeros(length(states),1);
    constraint = [22, 25];
    for i=1:length(states)-1
        R(i) = rewardFunc_test(states(i,1),states(i,2), states(i,3),constraint);
    end
      Q = repmat(R,[1,length(actions)]); 

end

