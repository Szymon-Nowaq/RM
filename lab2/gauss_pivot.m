function [X, time, A] = gauss_pivot(A, B)
    tic;
    % wymiary macierzy wejściowej
    [n, m] = size(A);
    % sprawdzenie poprawności wymiarów macierzy
    if size(B) ~= n | size(B) ~= m | n ~=m
        error('Wrong dimensions of matrices!');
    end

    % pętla po wierszach od pierwszego do przedostatniego
    for i = 1:n-1
        % pivoting – znajdź największy element w kolumnie
        [~, idx] = max(abs(A(i:end, i)));
        % określenie, w którym wierszu znajduje się ten element
        idx = idx + i - 1;

        % zamiana wierszy i oraz tego z maksymalnym elementem
        temp_i = A(i, :);
        A(i, :) = A(idx, :);
        A(idx, :) = temp_i;

        temp_i = B(i, 1);
        B(i, 1) = B(idx, 1);
        B(idx, 1) = temp_i;

        % eliminacja od wiersza i+1 do końca - w kolumnie i pod wierszem i
        % zostają same zera
        for j = i+1:n
            factor = A(j, i) / A(i, i);
            A(j, :) = A(j, :) - factor * A(i, :);
            B(j, 1) = B(j, 1) - factor * B(i, 1);
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
