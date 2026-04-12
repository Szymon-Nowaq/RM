clc; clear;

M = [4 9 2;
     3 5 7;
     8 1 6];

% NORMA 1
disp("NORMA 1")
norm1 = max(sum(abs(M), 1));

% wersja bez wbudowanej funkcji
n = size(M,1);
norm1_1 = 0;
for j = 1:n
    col_sum = 0;
    for i = 1:n
        col_sum = col_sum + abs(M(i,j));
    end
    if col_sum > norm1_1
        norm1_1 = col_sum;
    end
end
if norm1 ~= norm1_1
    error("Error in norm1")
end

% NORMA INF
disp("NORMA INF")
normInf = max(sum(abs(M), 2));

% wersja bez wbudowanej funkcji
normInf_1 = 0;
for i = 1:n
    row_sum = 0;
    for j = 1:n
        row_sum = row_sum + abs(M(i,j));
    end
    if row_sum > normInf_1
        normInf_1 = row_sum;
    end
end
if normInf ~= normInf_1
    error("Error in normInf")
end

% NORMA 2
disp("NORMA 2")

% I sposób
eig_vals = eig(M);
disp("wartości własne:")
disp(eig_vals);
norm2 = max(abs(eig_vals));
fprintf("Wynik: %f\n", norm2);

% II sposób
n = size(M,1);
syms lambda
I = eye(n);
char_matrix = M - lambda * I;
char_poly = det(char_matrix);
 
lambda_vals = double(solve(char_poly == 0, lambda));
norm2_2 = max(abs(lambda_vals));

disp('Wartosci wlasne:');
disp(lambda_vals);
fprintf("Wynik: %f\n", norm2_2);

% III sposób
eig_vals_1 = eig(M' * M);
norm2_1 = sqrt(max(eig_vals_1));

disp("wartości własne macierzy A^T*A:")
disp(sqrt(eig_vals_1))
fprintf("Wynik: %f\n", norm2_1);


% NORMA p
function n = norm_p_vec(x, p)
    sum_x = sum(abs(x).^p);
    n = (sum_x)^(1/p);
end

p_values = 2:10;

n = size(M,2);
num_trials = 10000;

% obliczenia dla różnych wartości p
for p = p_values
    max_val = 0;
    % próby dla 1000 losowych wektorów
    for i = 1:num_trials
        x = randn(n,1);
        
        % normalizacja wektora, aby miał normę p równą 1
        nx = norm_p_vec(x, p);
        x = x / nx;
        
        % obliczenie ||Mx||_p
        Mx = M * x;
        val = norm_p_vec(Mx, p);
        
        % sprawdzenie, czy norma większa od dotychczasowej największej
        if val > max_val
            max_val = val;
        end
    end
    
    normP = max_val;
    fprintf('Norma p (p=%d): %f\n', p, normP);
end

% WYNIKI
fprintf('Norma 1: %f\n', norm1);
fprintf('Norma 2: %f\n', norm2);
fprintf('Norma inf: %f\n', normInf);
