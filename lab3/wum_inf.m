function c = wum_inf(M)
    c = max(sum(abs(M),2)) * max(sum(abs(inv(M)),2));
end
