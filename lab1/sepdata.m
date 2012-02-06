classA(1, :) = randn(1,100) .* 0.5 + 1.0;
classA(2, :) = randn(1,100) .* 0.5 + 0.5;
classB(1, :) = randn(1,100) .* 0.5 - 1.0;
classB(2, :) = randn(1,100) .* 0.5 + 0.0;

patterns = [classA, classB];

targets = [(ones(1, 100) .* 1.0), (ones(1, 100) .* -1.0)];

permute = randperm(200);
patterns = patterns(:, permute);
targets = targets(:, permute);
