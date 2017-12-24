function mainPara = antsEvolve(controlModel, mainPara,testPara)
    
    population = mainPara.population;
    mfParaNum = mainPara.mfParaNum;
    num_newAnts = mainPara.num_newAnts;
    para_array = NaN(population, (5 + 7 + 7)*mfParaNum);
    sigma_antBody = NaN(num_newAnts, (5 + 7 + 7)*mfParaNum);
    newPara_cell = cell(num_newAnts, 3);
    
    %Spread para_cell
    for i = 1 : population;
        tmp_array = [cell2mat(mainPara.para_cell{i, 1}); cell2mat(mainPara.para_cell{i, 2}); ...
                    [cell2mat(mainPara.para_cell{i, 3}), zeros(7, 1)]];
        para_array(i, :) = reshape(tmp_array', [1, (size(tmp_array, 1)*size(tmp_array, 2))]);
        
    end
    
    %Create new ants, Random selection and calculate standard deviation 
    index = SDoRS(mainPara.probability, population, num_newAnts);
    mu_antBody = para_array(index, :); 
    for i = 1 : size(mu_antBody, 1);
        sigma_antBody(i, :) = mainPara.zeta ...
                            *sum(abs(para_array - repmat(mu_antBody(i, :), [population, 1])), 1)...
                            / (population - 1);
                        
    end
    
    [row, col] = size(sigma_antBody);
    newPara_array = sigma_antBody.*randn(row, col) + mu_antBody;
    
    %Fitting parameters range
    para_X = newPara_array(:, 1 : 5*mfParaNum);
    para_X(para_X > 100) = 100;
    para_X(para_X <= 0) = 0.001;

    para_Phi = newPara_array(:, (5*mfParaNum + 1) : (5 + 7)*mfParaNum);
    para_Phi(para_Phi > 270) = 270;
    para_Phi(para_Phi < -90) = -90;
    para_Phi(para_Phi == 0) = 0.001;
    
    para_Theta = newPara_array(:, ((5 + 7)*mfParaNum + 1) : end);
    para_Theta(para_Theta > 30) = 30;
    para_Theta(para_Theta < -30) = -30;
    para_Theta(para_Theta == 0) = 0.001;
    
    %storing parameters to mainPara.para_cell
    for i = 1 : num_newAnts;
        tPara_X = reshape(para_X(i, :), [mfParaNum, 5])';
        tPara_Phi = reshape(para_Phi(i, :), [mfParaNum, 7])';
        tPara_Theta = reshape(para_Theta(i, :), [mfParaNum, 7])';
        
        tPara_X = mat2cell(tPara_X, ones(1, 5));
        tPara_Phi = mat2cell(tPara_Phi, ones(1, 7));
        tPara_Theta = mat2cell(tPara_Theta(:, 1), ones(1, 7));        
        newPara_cell(i, :) = {tPara_X, tPara_Phi, tPara_Theta};
        
    end
    mainPara = evalError(controlModel, mainPara, newPara_cell, testPara, 0);
    
end

%y = a.*randn(1000,1) + b;





