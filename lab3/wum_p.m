function c = wum_p(M, p)
    n = 0;
    for i = 1:1000
        x = rand(size(M,2),1);
        x = x / norm(x, p);
        n = max(n, norm(M*x, p));
    end

    n_inv = 0;
    for i = 1:1000
        x = rand(size(M,2),1);
        x = x / norm(x, p);
        n_inv = max(n_inv, norm(inv(M)*x, p));
    end

    c = n * n_inv;
end
