function c = wum_1(M)
    c = max(sum(abs(M),1)) * max(sum(abs(inv(M)),1));
end
