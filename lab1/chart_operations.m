k_values = 2:7;
l_values = 2:7;

ops_add = zeros(length(l_values), length(k_values));
ops_sub = zeros(length(l_values), length(k_values));
ops_mul = zeros(length(l_values), length(k_values));
ops_total = zeros(length(l_values), length(k_values));

for li = 1:length(l_values)
    fprintf('%d / %d\n', li, length(l_values))
    l = l_values(li);
    
    for ki = 1:length(k_values)
        k = k_values(ki);
        n = 2^k;
        
        A = rand(n);
        B = rand(n);
        
        [~, ops] = lab1(A, B, l);
        
        ops_add(li, ki) = ops.add;
        ops_sub(li, ki) = ops.sub;
        ops_mul(li, ki) = ops.mul;
        ops_total(li, ki) = ops.add + ops.sub + ops.mul;
        
        fprintf('   %d / %d\n', ki, length(k_values))
    end
end

figure; hold on;
for li = 1:length(l_values)
    plot(k_values, ops_add(li,:), '-o', 'DisplayName', ['l=' num2str(l_values(li))]);
end
xlabel('k (rozmiar 2^k)');
ylabel('Liczba dodawań');
title('Dodawanie');
legend show;
grid on;

figure; hold on;
for li = 1:length(l_values)
    plot(k_values, ops_sub(li,:), '-o', 'DisplayName', ['l=' num2str(l_values(li))]);
end
xlabel('k (rozmiar 2^k)');
ylabel('Liczba odejmowań');
title('Odejmowanie');
legend show;
grid on;

figure; hold on;
for li = 1:length(l_values)
    plot(k_values, ops_mul(li,:), '-o', 'DisplayName', ['l=' num2str(l_values(li))]);
end
xlabel('k (rozmiar 2^k)');
ylabel('Liczba mnożeń');
title('Mnożenie');
legend show;
grid on;

figure; hold on;
for li = 1:length(l_values)
    plot(k_values, ops_total(li,:), '-o', 'DisplayName', ['l=' num2str(l_values(li))]);
end
xlabel('k (rozmiar 2^k)');
ylabel('Liczba operacji');
title('Wszystkie operacje');
legend show;
grid on;