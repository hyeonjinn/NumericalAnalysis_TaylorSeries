function cos_Taylor(x, a, n)

y = ones(size(x));

for i = 1 : length(x)
    y(i) = cos(a);
    
    for j = 1 : n
        value = ( diff(j, a) * (x(i) - a)^j )/factorial(j);
        y(i) = y(i) + value;
    end
end

plot(x, y, 'r:o','LineWidth',5)
end


function k = diff(n, b)

    switch mod(n, 4)
        case 0
            k = cos(b);
        case 1
            k = (-1) * sin(b);
        case 2
            k = (-1) * cos(b);
        case 3 
            k = sin(b);
    end
end