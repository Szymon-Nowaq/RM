function [X, time, A] = gauss_without_pivot_v1(A, B)
    tic;
    % wymiary macierzy wejściowej
    [n, m] = size(A);
    % sprawdzenie poprawności wymiarów macierzy
    if size(B) ~= n | size(B) ~= m | n ~=m
        error('Wrong dimensions of matrices!');
    end

    % pętla po wszystkich wierszach
    for i = 1:n
        % zamiana i-tego elementu na przekątnej na jedynkę
        aii = A(i,i);
        A(i, :) = A(i, :) / aii;
        B(i) = B(i) / aii;   
        
        % pętla po wszystkich wierszach poniżej
        for k = i+1:n
            % odejmowanie wiersza i od k przeskalowanego tak, żeby dostać 0
            % pod przekątną
            factor = A(k, i) / A(i, i);
            A(k, :) = A(k, :) - A(i, :) * factor;
            B(k) = B(k) - B(i) * factor;
        end
    end

    % rozwiązanie układu równań
    X = zeros(n, 1);
    % obliczenie ostatniej wartości
    X(n) = B(n) / A(n, n);
    for i = n-1:-1:1
        X(i) = (B(i) - A(i, i+1:n) * X(i+1:n)) / A(i, i);
    end
    
    time = toc;
end
