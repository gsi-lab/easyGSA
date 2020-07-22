function y = gSobol(x)
    % 5 dimensional implementation of g-function of Sobol.
    
    a=[1:5];
    prod = 1;
    for j = 1:5
        xi = x(:,j);
        ai = a(j);
        new1 = abs(4.*xi-2) + ai;
        new2 = 1 + ai;
        prod = prod .* new1./new2;
    end
    y = prod;
end