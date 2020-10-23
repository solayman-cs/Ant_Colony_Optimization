% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team) 
% Modified By: Solayman Hossain Emon, Aust CSE 37th Batch.

function [j,C]=RouletteWheelSelection(P,r)

    C=cumsum(P);
    
    j=find(r<=C,1,'first');

end