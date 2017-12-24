function mainPara = initialAnts(controlModel, mainPara, testPara)

    mfParaNum = mainPara.mfParaNum;
    population = mainPara.population;
    mainPara.weights = exp((-(0 : (population - 1))'.^2) / (2*(mainPara.q*population)^2)) ...
                     / (mainPara.q*population*((2*pi)^0.5));
    mainPara.probability = mainPara.weights / sum(mainPara.weights);
    
    for i = 1 : population;
        X_rand = 100.*rand(5, mfParaNum);
        Phi_rand = -90 + 360.*rand(7, mfParaNum);
        Theta_rand = (-30) + 60.*rand(7, 1);

        X_rand = mat2cell(X_rand, ones(1, 5));
        Phi_rand = mat2cell(Phi_rand, ones(1, 7));
        Theta_rand = mat2cell(Theta_rand, ones(1, 7));
        mainPara.para_cell(i, :) = {X_rand, Phi_rand, Theta_rand};
        
        [controlModel.input(1).mf.params] = mainPara.para_cell{i, 1}{:};
        [controlModel.input(2).mf.params] = mainPara.para_cell{i, 2}{:};
        [controlModel.output.mf.params] = mainPara.para_cell{i, 3}{:};
 
        [docking_error, ~] = singleEvalError(controlModel, testPara, 0);
        mainPara.dockingError.all(i, 1) = docking_error;
        
    end
    
    %Ranking(ascend)
    mainPara = sortAnts(mainPara);
    
    mainPara.dockingError.meanAndmin(1, 1) = mean(mainPara.dockingError.all);
    mainPara.dockingError.meanAndmin(2, 1) = mainPara.dockingError.all(1, 1);
    fprintf('Generation : 1 | mean_docking_error : %.4f | outstanding_docking_error : %.4f\n', mainPara.dockingError.meanAndmin(1, 1), ...
                                                                                               mainPara.dockingError.meanAndmin(2, 1));
                                                                                           
end

%[c.input(1).mf.params] = d{:}
%r = a + (b-a).*rand(N,1)
%writefis(r, '/Users/jibowei/Desktop/r.fis')


