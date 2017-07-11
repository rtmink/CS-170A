function [Sublist1 Sublist2] = randsplit(List)
    rp = randperm(max(size(List)));
    n = max(size(rp));
    l1 = rp(1:floor(n/2));
    l1n = max(size(l1));
    l2 = rp(floor(n/2)+1:n);
    l2n = max(size(l2));

    Sublist1 = List(1:l1n);
    Sublist2 = List(l1n+1:n);

    for i=1:l1n
        Sublist1(i) = List(l1(i));
    end

    for i=1:l2n
        Sublist2(i) = List(l2(i));
    end
end