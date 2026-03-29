function [X, time, A] = gauss_without_pivot_v2(A, B)
    tic;
    % wymiary macierzy wejściowej
    [n, m] = size(A);
    % sprawdzenie poprawności wymiarów macierzy
    if size(B) ~= n | size(B) ~= m | n ~=m
        error('Wrong dimensions of matrices!');
    end

    % pętla po elementach na przekątnej
    for i = 1:n
        % pętla po wierszach poniżej elementu na przekątnej
        for k = i+1:n
            % zerowanie elementów pod i-tym elementem przekątnej
            if abs(A(i,i)) < 1e-12
                error('Pivot is zero or very small – matrix may be singular');
            end
            factor = A(k, i) / A(i, i);
            A(k, :) = A(k, :) - A(i, :) * factor;
            B(k, 1) = B(k, 1) - B(i, 1) * factor;
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
