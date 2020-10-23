% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team) 
% Modified By: Solayman Hossain Emon, Aust CSE 37th Batch.

clc;
clear;
close all;

%% ACO Parameters

tour=2;        % Number of Tours

dis = [0 10 12 11; 10 0 13 15; 12 13 0 9; 11 15 9 0]; % Distance Matrix

tau0=ones(length(dis));	% Initial Phromone

alpha=2;        % Phromone Exponential Weight
beta=1;         % Heuristic Exponential Weight

rho=0.5;       % Evaporation Rate
Q=1;
start_city=1;
%ran = [0.684, 0.4024, 0.421, 0.7332];
nAnt=2;        % Number of Ants (Population Size)
ran = [0.091 0.111 0.131; 0.151 0.171 0.191];

CostFunction=@(tour) TourLength(tour,dis);
nVar=length(dis);  %jumlah kota.

%% Initialization

%eta=1./dis;             % Visibility Matrix

%generating the Visibility Matrix using inverse distance
n = length(dis);
for i=1:n
 for j=1:n
 if dis(i,j)==0
 eta(i,j)=0;
 else
 eta(i,j)=1/dis(i,j); 
 end
 end
end

BestCost=zeros(tour,1);    % Array to Hold Best Cost Values

% Empty Ant
empty_ant.Tour=[];
empty_ant.Cost=[];

% Ant Colony Matrix
ant=repmat(empty_ant,nAnt,1);

% Best Ant
BestSol.Cost=inf;

disp('Distance Matrix');
disp('----------------');
disp(dis);


disp('Visibility Matrix');
disp('------------------------');
disp(eta);

disp('Initial Pheromon Matrix');
disp('-----------------------');
disp(tau0);


%% ACO Main Loop

for it=1:tour
    
    % Move Ants
    disp('################################');
    disp(['Tour ' num2str(it)]);
    disp('################################');
    for k=1:nAnt
        
        %ant(k).Tour=randi([1 nVar]);
        ant(k).Tour=start_city;
        disp('');
        disp('---------------------');
        disp(['Ant ', num2str(k)]);
        disp('---------------------');
        indx = 1;
        for l=2:nVar
            
            i=ant(k).Tour(end);
            disp(['Selected Cities:: ', num2str(ant(k).Tour)]);
            P=tau0(i,:).^alpha.*eta(i,:).^beta;
            P(ant(k).Tour)=0;
            disp('Values of Pheromon*Visivibility:::');
            disp(P);
            
            %P(ant(k).Tour)=0;
            P=P/sum(P);
            disp('Probability:::');
            disp(P);
            
            %if rem(l,2)==0
            %  indx = 1;
            %else 
            %  indx = 2;
            %end 
            r = ran(k,indx);
            disp(['used random value:::', num2str(r)]);
            [j,C]=RouletteWheelSelection(P,r);
            disp('Cumulative Probability:::');
            disp(C);
            disp('~~~~~~~~~~~~~~~~');
            indx = indx + 1;
            %disp(j);
            
            %disp(ant(k).Tour);
            ant(k).Tour=[ant(k).Tour j];
            
        end
        
        
        ant(k).Cost=CostFunction(ant(k).Tour);
        
        if ant(k).Cost<BestSol.Cost
            BestSol=ant(k);
        end
        disp(['Ant', num2str(k), ' :: ', num2str(ant(k).Tour),  ' Distance :: ', num2str(ant(k).Cost)]);
        disp('');
        
    end
    
    % Evaporation
    tau0=(1-rho)*tau0;
    
    % Update Phromones
    for k=1:nAnt
        
        tour=ant(k).Tour;
        
        tour=[tour tour(1)]; %#ok
        
        for l=1:nVar
            
            i=tour(l);
            j=tour(l+1);
            
            tau0(i,j)=tau0(i,j)+Q/ant(k).Cost;
         
            
        end
        disp(' ');
        disp(['Updated Pheromone Matrix By Ant', num2str(k),' :']);
        disp(tau0);
        
    end
    
    % Evaporation
    %tau=(1-rho)*tau;
    %disp(tau);
    
    % Store Best Cost
    BestCost(it)=BestSol.Cost;
    
    % Show Iteration Information
    disp(['Tour ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    
end


