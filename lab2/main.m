n = 15;
A = rand(n);
B = rand(n, 1);

disp("Macierz A")
disp(A);
disp("Wektor B")
disp(B);

[X, time, A_p1] = gauss_without_pivot_v1(A, B);
disp("Eliminacja Gaussa wersja 1")
disp("Czas:");
disp(time);
disp("Wynik");
disp(X);
disp("Macierz po przekształceniach");
disp(A_p1);


[X, time, A_p2] = gauss_without_pivot_v2(A, B);
disp("Eliminacja Gaussa wersja 2")
disp("Czas:");
disp(time);
disp("Wynik");
disp(X);
disp("Macierz po przekształceniach");
disp(A_p2);

[X, time, A_p] = gauss_pivot(A, B);
disp("Eliminacjia Gaussa z pivotem")
disp("Czas:");
disp(time);
disp("Wynik");
disp(X);
disp("Macierz po przekształceniach");
disp(A_p);

[X, time, L, U] = lu_no_pivot(A, B);
disp("LU faktoryzacja bez pivotingu")
disp("Czas:");
disp(time);
disp("Wynik");
disp(X);
disp("Macierz L");
disp(L);
disp("Macierz U");
disp(U);

[X, time, L, U, P] = lu_pivot(A, B);
disp("LU faktoryzacja z pivotingiem")
disp("Czas:");
disp(time);
disp("Wynik");
disp(X);
disp("Macierz L");
disp(L);
disp("Macierz U");
disp(U);
disp("Macierz P");
disp(P);
