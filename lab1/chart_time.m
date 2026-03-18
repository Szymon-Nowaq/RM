clear; clc;

% Zakres k
k_values = 2:16;
l_values = 2:16;

times = zeros(length(l_values), length(k_values));

for li = 1:length(l_values)
    l = l_values(li);
    
    for ki = 1:length(k_values)
        k = k_values(ki);
        n = 2^k;
        
        % Losowe macierze
        A = rand(n);
        B = rand(n);
        
        % Pomiar czasu
        tic;
        C = lab1(A, B, l);
        times(li, ki) = toc;
        
        fprintf('l=%d, k=%d (n=%d): %.4f s\n', l, k, n, times(li, ki));
    end
end

% Wykres
figure;
hold on;

for li = 1:length(l_values)
    plot(k_values, times(li,:), '-o', 'DisplayName', ['l = ' num2str(l_values(li))]);
end

xlabel('k (macierz 2^k × 2^k)');
ylabel('Czas [s]');
title('Czas mnożenia macierzy (Strassen + Binet)');
legend show;
grid on;