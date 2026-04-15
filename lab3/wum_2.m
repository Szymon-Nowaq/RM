function c = wum_2(M)
    s = svd(M);
    c = max(s) / min(s);
end
