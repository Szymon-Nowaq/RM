function projekt4_svd_AtA()
    % 1. Przygotowanie macierzy A (wymiary nxm) [cite: 15, 16, 17]
    n = 7; 
    m = 5; 
    A = [
        0.8235, 0.7655, 0.7547, 0.9597, 0.6991;
        0.6948, 0.7952, 0.2760, 0.3404, 0.8909;
        0.3171, 0.1869, 0.6797, 0.5853, 0.9593;
        0.9502, 0.4898, 0.6551, 0.2238, 0.5472;
        0.0344, 0.4456, 0.1626, 0.7513, 0.1386;
        0.4387, 0.6463, 0.1190, 0.2551, 0.1493;
        0.3816, 0.7094, 0.4984, 0.5060, 0.2575
    ];
    
    disp('--- Macierz A ---');
    disp(A);
    figure(1); % Jawne określenie numeru okna
    spy(A);
    title('Macierz A');
    
    % 2. Obliczenie macierzy A^T * A 
    % Wynikiem jest macierz kwadratowa mxm
    At = A';
    AtA = At * A; 
    
    disp('--- Macierz A^T * A ---');
    disp(AtA);
    figure(2);
    spy(AtA);
    title('Struktura macierzy A^T A');
    
    % 3. Obliczenie wartości i wektorów własnych dla A^T * A [cite: 63, 65]
    % Wektory własne AtA tworzą macierz V 
    [eigenVectorsV, eigenValues] = eig(AtA);
    lambda = diag(eigenValues);
    
    % Sortowanie wartości własnych malejąco [cite: 67]
    [lambda_sorted, idx] = sort(lambda, 'descend');
    
    % Uporządkowana macierz wektorów własnych V [cite: 69]
    V = eigenVectorsV(:, idx);
    
    % 4. Tworzenie macierzy diagonalnej S (wymiary nxm) [cite: 70, 71]
    % S_ii = sqrt(lambda_i) [cite: 63, 74]
    S = zeros(n, m); 
    for i = 1:min(n, m) 
        S(i, i) = sqrt(lambda_sorted(i));
    end
    
    disp('--- Macierz S ---');
    disp(S); 
    figure(3);
    spy(S);
    title('Macierz diagonalna S');
    
    % 5. Obliczenie macierzy U za pomocą równania: U = A * V * S^-1 [cite: 94]
    U = zeros(n, n);
    
    % Obliczamy m kolumn U: U(:,i) = A*V(:,i) / S(i,i) [cite: 101]
    for i = 1:m
        if S(i, i) > 1e-10 % Stabilność numeryczna [cite: 99]
            U(:, i) = (A * V(:, i)) / S(i, i);
        end
    end
    
    % Dopełnienie bazy dla macierzy U (opcjonalnie dla pełnego SVD)
    if n > m
        [Q, ~] = qr(U(:, 1:m));
        U = Q;
    end
    
    disp('--- Macierz U ---');
    disp(U);
    figure(4);
    spy(U);
    title('Macierz U');
    
    disp('--- Macierz V ---');
    disp(V);
    figure(5);
    spy(V);
    title('Macierz V');
    
    % Weryfikacja rekonstrukcji: A = U * S * V' [cite: 8]
    A_rec = U * S * V';
    disp('--- Weryfikacja (U * S * V^T) ---');
    disp(A_rec);
end
