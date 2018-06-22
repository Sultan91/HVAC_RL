function [ err ] = rewardFunc_test( setpointT, actualT, power, constraint)
low = constraint(1);
high = constraint(2);
if (actualT>low & actualT<high)
    err = -(abs(setpointT - actualT))^2 - power/100;
else
    err = -(abs(setpointT - actualT))^2 -1000- power/100;
end
end

