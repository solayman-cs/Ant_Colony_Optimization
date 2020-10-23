% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team) 
% Modified By: Solayman Hossain Emon, Aust CSE 37th Batch.

function L=TourLength(tour,dis)

    n=numel(tour);

    tour=[tour tour(1)];
    
    L=0;
    for i=1:n
        L=L+dis(tour(i),tour(i+1));
    end

end