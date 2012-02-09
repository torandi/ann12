items_per_class = 200 + randn(1)*100;

classA(1, :) = randn(1,items_per_class/2) .* 0.5 + 1.0;
classA(2, :) = randn(1,items_per_class/2) .* 0.5 + 0.5;
classB(1, :) = randn(1,items_per_class/2) .* 0.5 - 1.0;
classB(2, :) = randn(1,items_per_class/2) .* 0.5 + 0.0;

patterns = [classA, classB];

targets = [(ones(1, size(classA,2)) .* 1.0), (ones(1, size(classB, 2)) .* -1.0)];

permute = randperm(size(patterns,2));
patterns = patterns(:, permute);
targets = targets(:, permute);
