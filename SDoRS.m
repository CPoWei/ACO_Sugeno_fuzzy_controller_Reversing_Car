function index = SDoRS(probability, population, num_newAnts)
    %===Specific Distribution of Random Selection===
    %size of probability = (population, 1)
    %type of num_newAnts = 'double'
    %size of index = (num_newAnts, 1)
    probability = round(1000*probability);
    selectDesk = [];
    j = 1;
    
    for i = 1 : population;
        newInteger = repmat(i, [probability(i, 1), 1]);
        selectDesk(j : (j + size(newInteger, 1) - 1), 1) = newInteger; 
        j = j + size(newInteger, 1);
        
    end
    
    index = selectDesk(randi([1 size(selectDesk, 1)], num_newAnts, 1), 1);
    
end




