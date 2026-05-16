A = [
    5     4     1;
    -5    -4    0;
    0     2     5
    ];
% A = randi([-5,5],3,3);

disp("Macierz A:");
disp(A);

disp("PROGRAM 1");

At = A.';
AA_T = A * At;

epsilon = 1e-8;
max_iter = 10000;
p = 2;

% losowanie wektora początkowego
while true
    z = rand(3,1);

    w = AA_T*z;
    lambda = max(abs(w));
    err = abs(w - lambda * z);
    err = err.^2;
    err = sqrt(sum(err));

    % sprawdzenie, czy nie spełnia warunku stopu
    if err >= epsilon
        break;
    end
end

disp(z);
disp(err);

i = 0;
while err > epsilon && i < max_iter
    i = i + 1;
    % obliczenie wektora w
    w = AA_T * z;
    % obliczenie wartości własnej
    lambda = max(abs(w));
    % obliczenie błędu
    err = abs(w - lambda * z);
    err = err.^2;
    err = sqrt(sum(err));

    fprintf("Iteracja %d, error = %.12e\n", i, err);
    % aktualizacja wektora z
    z = w / lambda;
end

disp("Wektor własny:");
disp(z);
fprintf("Wartość własna: %d\n", lambda);
fprintf("Error: %d\n", err);
fprintf("Liczba iteracji: %d\n\n", i);

disp("PROGRAM 2");

m = 3;
At = A.';
AA_T = A * At;

% wartości i wektory własne
[eigenVectors, eigenValues] = eig(AA_T);
disp("Wartości własne:");
disp(diag(eigenValues));

disp("Wektory własne:");
disp(eigenVectors);

lambda = diag(eigenValues);
[lambda_sorted, idx] = sort(lambda, 'descend');
U = eigenVectors(:, idx);

D = zeros(m, m);
for i = 1:m
    D(i,i) = sqrt(lambda_sorted(i));
end

disp("Macierz U");
disp(U);
disp("Macierz D");
disp(D);

% macierz V = A^T x U x D^-1
V = zeros(m);
for i = 1:m
    if D(i,i) > 1e-10
        V(:,i) = (A' * U(:,i)) / D(i,i);
    end
end
disp("Macierz V");
disp(V);
