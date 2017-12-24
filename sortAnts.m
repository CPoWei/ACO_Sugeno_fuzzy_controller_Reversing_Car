function target = sortAnts(target)
    
    [~, sortedIndex] = sort(target.dockingError.all, 1, 'ascend');
    target.dockingError.all = target.dockingError.all(sortedIndex, :);
    target.para_cell = target.para_cell(sortedIndex, :);
    
end

%[~, index] = sort(a(:, 2), 1, 'descend')
%a = a(index, :)