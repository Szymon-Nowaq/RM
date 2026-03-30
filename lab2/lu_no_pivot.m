function [X, time, L, U] = lu_no_pivot(A, B)
    tic;
    % wymiary macierzy wejściowej
    [n, m] = size(A);
    % sprawdzenie poprawności wymiarów macierzy
    if size(B) ~= n | size(B) ~= m | n ~= m
        error('Wrong dimensions of matrices!');
    end

    % inicjalizacja L jako macierz jednostkowa
    L = eye(n);
    U = A;

    % eliminacja – faktoryzacja LU bez pivotingu (slajd 33)
    for k = 1:n-1
        if abs(U(k, k)) < 1e-12
            error('Pivot is zero or very small – matrix may be singular');
        end
        for i = k+1:n
            % mnożnik l_ik = a_ik / a_kk
            L(i, k) = U(i, k) / U(k, k);
            % aktualizacja wiersza i macierzy U
            U(i, :) = U(i, :) - L(i, k) * U(k, :);
        end
    end

    % rozwiązanie Ly = B (podstawianie w przód)
    y = zeros(n, 1);
    y(1) = B(1);
    for i = 2:n
        y(i) = B(i) - L(i, 1:i-1) * y(1:i-1);
    end

    % rozwiązanie Ux = y (podstawianie wstecz)
    X = zeros(n, 1);
    X(n) = y(n) / U(n, n);
    for i = n-1:-1:1
        X(i) = (y(i) - U(i, i+1:n) * X(i+1:n)) / U(i, i);
    end

    time = toc;
end
