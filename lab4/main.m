% Macierz nxm - wizualizacja
A = [
    0.8235    0.7655    0.7547    0.9597    0.6991;
    0.6948    0.7952    0.2760    0.3404    0.8909;
    0.3171    0.1869    0.6797    0.5853    0.9593;
    0.9502    0.4898    0.6551    0.2238    0.5472;
    0.0344    0.4456    0.1626    0.7513    0.1386;
    0.4387    0.6463    0.1190    0.2551    0.1493;
    0.3816    0.7094    0.4984    0.5060    0.2575
    ];

n = 7;
m = 5;
% A = rand(n, m);
disp("Macierz A");
disp(A);
spy(A);


% Macierz AA^T
At = A.';
AA_T = A * At;
disp("Macierz AA^T");
disp(AA_T);
spy(AA_T);

% wartości i wektory własne
[eigenVectors, eigenValues] = eig(AA_T);

lambda = diag(eigenValues);
[lambda_sorted, idx] = sort(lambda, 'descend');

% uporządkowana macierz wektorów własnych U
U = eigenVectors(:, idx);
% macierz diagonalna S
S = zeros(n, m);
for i = 1:min(n,m)
    S(i,i) = sqrt(lambda_sorted(i));
end

disp("Macierz U");
disp(U);
disp("Macierz S");
disp(S);


% macierz V = A^T x U x S^-1
V = zeros(m);
for i = 1:m
    if S(i,i) > 1e-10
        V(:,i) = (A' * U(:,i)) / S(i,i);
    end
end
disp("Macierz V");
disp(V);
spy(V);
disp("Macierz V^T");
disp(V');
