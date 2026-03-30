function [X, time, L, U, P] = lu_pivot(A, B)
    tic;
    % wymiary macierzy wejściowej
    [n, m] = size(A);
    % sprawdzenie poprawności wymiarów macierzy
    if size(B) ~= n | size(B) ~= m | n ~= m
        error('Wrong dimensions of matrices!');
    end

    % inicjalizacja
    L = eye(n);
    U = A;
    P = eye(n);

    % eliminacja – faktoryzacja LU z pivotingiem (slajd 36)
    for k = 1:n-1
        % pivoting – znajdź największy element w kolumnie k od wiersza k w dół
        [~, idx] = max(abs(U(k:n, k)));
        idx = idx + k - 1;

        % zamiana wierszy w U
        U([k, idx], :) = U([idx, k], :);
        % zamiana wierszy w P
        P([k, idx], :) = P([idx, k], :);
        % zamiana wierszy w L (tylko już obliczona część, kolumny 1:k-1)
        L([k, idx], 1:k-1) = L([idx, k], 1:k-1);

        if abs(U(k, k)) < 1e-12
            error('Pivot is zero or very small – matrix may be singular');
        end

        % obliczenie mnożników i aktualizacja
        for i = k+1:n
            L(i, k) = U(i, k) / U(k, k);
            U(i, :) = U(i, :) - L(i, k) * U(k, :);
        end
    end

    % rozwiązanie PA = LU  =>  Ax = B  =>  LUx = PB
    Pb = P * B;

    % rozwiązanie Ly = Pb (podstawianie w przód)
    y = zeros(n, 1);
    y(1) = Pb(1);
    for i = 2:n
        y(i) = Pb(i) - L(i, 1:i-1) * y(1:i-1);
    end

    % rozwiązanie Ux = y (podstawianie wstecz)
    X = zeros(n, 1);
    X(n) = y(n) / U(n, n);
    for i = n-1:-1:1
        X(i) = (y(i) - U(i, i+1:n) * X(i+1:n)) / U(i, i);
    end

    time = toc;
end
