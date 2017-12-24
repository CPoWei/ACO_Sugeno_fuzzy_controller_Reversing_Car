function mainPara = evalError(controlModel, mainPara, newPara_cell, testPara, traErrSwitch)
    
    population = mainPara.population;
    newDockingError = NaN(size(newPara_cell, 1), 1);
    
    X = testPara.X;
    Y = testPara.Y;
    Phi = testPara.Phi;
    X_exp = repmat(X, length(Y), 1);
    X_exp = X_exp(:);
    Y_exp = repmat(Y', 1, length(X));
    Y_exp = Y_exp(:);
    
    for i = 1 : size(newPara_cell, 1);
        docking_error = 0;
        trajectory_error = 0;
        
        [controlModel.input(1).mf.params] = newPara_cell{i, 1}{:};
        [controlModel.input(2).mf.params] = newPara_cell{i, 2}{:};
        [controlModel.output.mf.params] = newPara_cell{i, 3}{:};
        
        for j = 1 : length(Phi);
            phi = Phi(1, j);
            for k = 1 : length(X)*length(Y);
                x = X_exp(k, 1);
                y = Y_exp(k, 1);
                [~, x_p, y_p, phi_p, steps] = truck_reversing_fuzzy_controller(controlModel, x, y, phi, 1, 0);
                docking_error = docking_error + sqrt(((0.5*pi - phi_p) / pi)^2 + ((50 - x_p) / 50)^2 + ((100 - y_p) / 100)^2);
                if traErrSwitch == 1
                    trajectory_error = trajectory_error + (steps / sqrt((50 - x)^2 + (100 - y)^2));
                    %fprintf('(%d/%d)\n', (j + length(X)*length(Y)*(k - 1)), length(X)*length(Y)*length(Phi));
                end
            end
        end
        newDockingError(i, 1) = docking_error / (length(X)*length(Y)*length(Phi));
        
    end
    
    %Ranking(ascend)
    tMainPara = mainPara;
    tMainPara.dockingError.all = [tMainPara.dockingError.all; newDockingError];
    tMainPara.para_cell = [tMainPara.para_cell; newPara_cell];
    tMainPara = sortAnts(tMainPara);
    mainPara.dockingError.all = tMainPara.dockingError.all(1 : population, :);
    mainPara.para_cell = tMainPara.para_cell(1 : population, :);
    
    mainPara.dockingError.meanAndmin(1, 1) = mean(mainPara.dockingError.all);
    mainPara.dockingError.meanAndmin(2, 1) = mainPara.dockingError.all(1, 1);
    
end