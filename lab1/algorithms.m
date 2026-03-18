function [C, ops] = lab1(A, B, l)
    % A, B - macierze wejściowe o wymiarach [2^n x 2^n]
    % l - próg
    a1 = size(A, 1);
    a2 = size(A, 2);
    b1 = size(B, 1);
    b2 = size(B, 2);
    
    if (a1 == a2) && (a2 == b1) && (b1 == b2)
        n = a1;
    else
        disp("Wymiary macierzy nie są identyczne");
        return;
    end

    if mod(log2(a1),1) ~= 0
        error('Rozmiar macierzy musi być potęgą 2');
    end

    limit = 2^l;
    
    if n <= limit
        [C, ops] = algorytmBineta(A, B);
    else
        [C, ops] = algorytmStrassena(A, B, l);
    end
end

function [C, ops] = algorytmBineta(A, B)

    n = size(A,1);
    
    if n == 1
        C = A * B;
        ops.mul = 1;
        ops.add = 0;
        ops.sub = 0;
        return;
    end

    m = n/2;

    A11 = A(1:m,1:m); A12 = A(1:m,m+1:end);
    A21 = A(m+1:end,1:m); A22 = A(m+1:end,m+1:end);

    B11 = B(1:m,1:m); B12 = B(1:m,m+1:end);
    B21 = B(m+1:end,1:m); B22 = B(m+1:end,m+1:end);

    % 8 mnożeń, 4 dodawania
    [C11_1, ops1] = algorytmBineta(A11,B11);
    [C11_2, ops2] = algorytmBineta(A12,B21);
    C11 = C11_1 + C11_2;

    [C12_1, ops3] = algorytmBineta(A11,B12);
    [C12_2, ops4] = algorytmBineta(A12,B22);
    C12 = C12_1 + C12_2;

    [C21_1, ops5] = algorytmBineta(A21,B11);
    [C21_2, ops6] = algorytmBineta(A22,B21);
    C21 = C21_1 + C21_2;

    [C22_1, ops7] = algorytmBineta(A21,B12);
    [C22_2, ops8] = algorytmBineta(A22,B22);
    C22 = C22_1 + C22_2;

    % sumowanie operacji
    ops.mul = ops1.mul+ops2.mul+ops3.mul+ops4.mul+ops5.mul+ops6.mul+ops7.mul+ops8.mul;
    ops.add = ops1.add+ops2.add+ops3.add+ops4.add+ops5.add+ops6.add+ops7.add+ops8.add + 4*(m)^2; % 4 dodania macierzy
    ops.sub = ops1.sub+ops2.sub+ops3.sub+ops4.sub+ops5.sub+ops6.sub+ops7.sub+ops8.sub;
    
    %Macierz wynikowa
    C = [C11 C12; C21 C22];
end

function [C, ops] = algorytmStrassena(A, B, l)

    n = size(A,1);
   % Podział na ćwiartki
    m = n/2;

    A11 = A(1:m,1:m); A12 = A(1:m,m+1:end);
    A21 = A(m+1:end,1:m); A22 = A(m+1:end,m+1:end);

    B11 = B(1:m,1:m); B12 = B(1:m,m+1:end);
    B21 = B(m+1:end,1:m); B22 = B(m+1:end,m+1:end);

    % 7 mnożeń, 18 dodawań
    [M1, o1] = lab1(A11+A22, B11+B22, l);
    [M2, o2] = lab1(A21+A22, B11, l);
    [M3, o3] = lab1(A11, B12-B22, l);
    [M4, o4] = lab1(A22, B21-B11, l);
    [M5, o5] = lab1(A11+A12, B22, l);
    [M6, o6] = lab1(A21-A11, B11+B12, l);
    [M7, o7] = lab1(A12-A22, B21+B22, l);

    C11 = M1 + M4 - M5 + M7;
    C12 = M3 + M5;
    C21 = M2 + M4;
    C22 = M1 - M2 + M3 + M6;

    % zliczanie
    ops.mul = o1.mul+o2.mul+o3.mul+o4.mul+o5.mul+o6.mul+o7.mul;
    ops.add = o1.add+o2.add+o3.add+o4.add+o5.add+o6.add+o7.add + 18*(m^2);
    ops.sub = o1.sub+o2.sub+o3.sub+o4.sub+o5.sub+o6.sub+o7.sub;

    %Macierz wynikowa
    C = [C11 C12; C21 C22];
end