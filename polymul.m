  function poly3 = polymul(poly1, poly2)
    % 이 메소드는 두 다항식의 곱셈을 수행합니다.
    % 다항식의 각 항을 곱하여 새로운 다항식을 반환합니다.
    len1 = length(poly1);
    len2 = length(poly2);
    result_coeffs = zeros(1, len1 + len2 - 1);
    
    for i = 1:len1
        for j = 1:len2
            result_coeffs(i + j - 1) = result_coeffs(i + j - 1) + poly1(i) * poly2(j);
        end
    end
    poly3 = result_coeffs;
end
