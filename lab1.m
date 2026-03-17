function C = lab1(A, B, l)
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

    limit = 2^l;
    
    if n <= limit
        C = algorytmBineta(A, B);
    else
        C = algorytmStrassena(A, B, l);
    end
end

function C = algorytmBineta(A, B)
    n = size(A, 1);
    if n == 1
        C = A * B;
        return;
    end
    
    % Podział na ćwiartki
    m = n/2;
    
    A11 = A(1:m, 1:m); A12 = A(1:m, m+1:end);
    A21 = A(m+1:end, 1:m); A22 = A(m+1:end, m+1:end);
    
    B11 = B(1:m, 1:m); B12 = B(1:m, m+1:end);
    B21 = B(m+1:end, 1:m); B22 = B(m+1:end, m+1:end);
    
    % 8 mnożeń, 4 dodawania
    C11 = algorytmBineta(A11, B11) + algorytmBineta(A12, B21);
    C12 = algorytmBineta(A11, B12) + algorytmBineta(A12, B22);
    C21 = algorytmBineta(A21, B11) + algorytmBineta(A22, B21);
    C22 = algorytmBineta(A21, B12) + algorytmBineta(A22, B22);
    
    %Macierz wynikowa
    C = [C11, C12; C21, C22];
end

function C = algorytmStrassena(A, B, l)
    n = size(A, 1);
    
    % Podział na ćwiartki
    m = n/2;
    
    A11 = A(1:m, 1:m); A12 = A(1:m, m+1:end);
    A21 = A(m+1:end, 1:m); A22 = A(m+1:end, m+1:end);
    
    B11 = B(1:m, 1:m); B12 = B(1:m, m+1:end);
    B21 = B(m+1:end, 1:m); B22 = B(m+1:end, m+1:end);
    
    % 7 mnożeń, 18 dodawań
    M1 = lab1(A11 + A22, B11 + B22, l);
    M2 = lab1(A21 + A22, B11, l);
    M3 = lab1(A11, B12 - B22, l);
    M4 = lab1(A22, B21 - B11, l);
    M5 = lab1(A11 + A12, B22, l);
    M6 = lab1(A21 - A11, B11 + B12, l);
    M7 = lab1(A12 - A22, B21 + B22, l);
    
    % Macierz wynikowa
    C11 = M1 + M4 - M5 + M7;
    C12 = M3 + M5;
    C21 = M2 + M4;
    C22 = M1 - M2 + M3 + M6;
    
    C = [C11, C12; C21, C22];
end